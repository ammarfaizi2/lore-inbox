Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751220AbWG1OdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbWG1OdV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 10:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751985AbWG1OdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 10:33:21 -0400
Received: from nz-out-0102.google.com ([64.233.162.206]:35245 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751220AbWG1OdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 10:33:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:reply-to:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=eXrU3A6OJME9KtVEuhiZtc2/aRd/ZUMR7k1YRdxbsBshNO9D24tA2vyWN1RYHlOWPAVDcxRQqJN7boSQie8ht6BHMYk0i0PKzuQAYhMQwTLLcFlxPLjYkGacO1timh6AoMe7pKWViRemX17zeNbxDJDqCFEs0yRqBhhqMA3jJ7U=
Reply-To: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com
To: Greg KH <gregkh@suse.de>
Subject: Re: Kubuntu's udev broken with 2.6.18-rc2-mm1
Date: Fri, 28 Jul 2006 10:33:05 -0400
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, andrew.j.wade@gmail.com,
       linux-kernel@vger.kernel.org
References: <20060727015639.9c89db57.akpm@osdl.org> <20060727125655.f5f443ea.akpm@osdl.org> <20060727201255.GA9515@suse.de>
In-Reply-To: <20060727201255.GA9515@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607281033.06111.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
From: Andrew James Wade <andrew.j.wade@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 July 2006 16:12, Greg KH wrote:
> On Thu, Jul 27, 2006 at 12:56:55PM -0700, Andrew Morton wrote:
> > On Fri, 28 Jul 2006 15:46:08 -0400
> > Andrew James Wade <andrew.j.wade@gmail.com> wrote:
> > 
> > > Hello,
> > > 
> > > Some change between -rc1-mm2 and -rc2-mm1 broke Kubuntu's udev
> > > (079-0ubuntu34). In particular /dev/mem went missing, and /dev/null had
> > > bogus permissions (crw-------). I've kludged around the problem by
> > > populating /lib/udev/devices from a good /dev, but I'm assuming the
> > > breakage was unintentional.
> > > 
> > 
> > /dev/null damage is due to a combination of vdso-hash-style-fix.patch and
> > doing the kernel build as root (don't do that).
> > 
> > I don't know what happened to /dev/mem.
> 
> Me either.  Look in /sys/class/mem/  Is it full of symlinks or real
> directories?

Symlinks.

> If symlinks, your version of udev should be able to handle it properly,
> but might have a bug somehow.
> 
> Try running udevmonitor and echo a "1" to /sys/class/mem/mem/uevent and
> see if udev creates the device properly or not.

udevmonitor prints the received event from the kernel [UEVENT]
and the event which udev sends out after rule processing [UDEV]

UEVENT[1154093169.330045] add@/devices/mem
UDEV  [1154093169.331914] add@/devices/mem

The device node was not created.

udev.log for 2.6.18-rc1-mm2 (which does work) has these lines:

UEVENT[1154105360.092631] add@/class/mem/mem
ACTION=add
DEVPATH=/class/mem/mem
SUBSYSTEM=mem
SEQNUM=589
MAJOR=1
MINOR=1

...

UDEV  [1154105363.575086] add@/class/mem/mem
UDEV_LOG=3
ACTION=add
DEVPATH=/class/mem/mem
SUBSYSTEM=mem
SEQNUM=589
MAJOR=1
MINOR=1
UDEVD_EVENT=1
DEVNAME=/dev/mem

The Changelog for udev v081 has:
"prepare moving of /sys/class devices to /sys/devices"
Is this related? 

Thanks,
Andrew Wade

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWG0UPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWG0UPO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 16:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbWG0UPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 16:15:13 -0400
Received: from mail.kroah.org ([69.55.234.183]:17316 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750712AbWG0UPL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 16:15:11 -0400
Date: Thu, 27 Jul 2006 13:12:55 -0700
From: Greg KH <gregkh@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
       andrew.j.wade@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: Kubuntu's udev broken with 2.6.18-rc2-mm1
Message-ID: <20060727201255.GA9515@suse.de>
References: <20060727015639.9c89db57.akpm@osdl.org> <200607281546.09592.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <20060727125655.f5f443ea.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060727125655.f5f443ea.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2006 at 12:56:55PM -0700, Andrew Morton wrote:
> On Fri, 28 Jul 2006 15:46:08 -0400
> Andrew James Wade <andrew.j.wade@gmail.com> wrote:
> 
> > Hello,
> > 
> > Some change between -rc1-mm2 and -rc2-mm1 broke Kubuntu's udev
> > (079-0ubuntu34). In particular /dev/mem went missing, and /dev/null had
> > bogus permissions (crw-------). I've kludged around the problem by
> > populating /lib/udev/devices from a good /dev, but I'm assuming the
> > breakage was unintentional.
> > 
> 
> /dev/null damage is due to a combination of vdso-hash-style-fix.patch and
> doing the kernel build as root (don't do that).
> 
> I don't know what happened to /dev/mem.

Me either.  Look in /sys/class/mem/  Is it full of symlinks or real
directories?

If symlinks, your version of udev should be able to handle it properly,
but might have a bug somehow.

Try running udevmonitor and echo a "1" to /sys/class/mem/mem/uevent and
see if udev creates the device properly or not.

thanks,

greg k-h

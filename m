Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751399AbWHCXk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbWHCXk1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 19:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbWHCXk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 19:40:27 -0400
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:16102 "EHLO
	mail6.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751398AbWHCXk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 19:40:26 -0400
Date: Thu, 3 Aug 2006 16:40:25 -0700 (PDT)
From: Trent Piepho <xyzzy@speakeasy.org>
X-X-Sender: xyzzy@shell2.speakeasy.net
To: Adrian Bunk <bunk@stusta.de>
cc: Dave Jones <davej@redhat.com>, Greg KH <greg@kroah.com>,
       Zachary Amsden <zach@vmware.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>,
       v4l-dvb-maintainer@linuxtv.org, linux-acpi@vger.kernel.org
Subject: Re: [v4l-dvb-maintainer] Options depending on STANDALONE
In-Reply-To: <20060803202543.GH25692@stusta.de>
Message-ID: <Pine.LNX.4.58.0608031610110.9178@shell2.speakeasy.net>
References: <44D1CC7D.4010600@vmware.com> <1154603822.2965.18.camel@laptopd505.fenrus.org>
 <44D23B84.6090605@vmware.com> <20060803190327.GA14237@kroah.com>
 <44D24B31.2080802@vmware.com> <20060803193600.GA14858@kroah.com>
 <20060803195617.GD16927@redhat.com> <20060803202543.GH25692@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Aug 2006, Adrian Bunk wrote:
> On Thu, Aug 03, 2006 at 03:56:17PM -0400, Dave Jones wrote:
> > You're describing PREVENT_FIRMWARE_BUILD.  The text Zach quoted is from
> > STANDALONE, which is something else completely.  That allows us to not
> > build drivers that pull in things from /etc and the like during compile.
> > (Whoever thought that was a good idea?)
>
>
> Is DVB_AV7110_FIRMWARE really still required?
> ALL other drivers work without such an option.

The other DVB drivers that need firmware load it when the device is opened
or used (ie.  a channel is tuned).  At least for the ones I'm familiar
with.  If they are compiled directly into the kernel, they can still use
FW_LOADER since the loading won't happen until utill well after booting is
done.

For AV7110, it looks like the firmware loading is done when the driver is
first initialized.  If AV7110 is compiled into the kernel, FW_LOADER can
not be used.  The filesystem with the firmware won't be mounted yet.

So AV7110 has an option to compile a firmware file into the driver.

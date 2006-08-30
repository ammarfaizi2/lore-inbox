Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751354AbWH3TRx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbWH3TRx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 15:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbWH3TRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 15:17:53 -0400
Received: from smtp18.orange.fr ([193.252.22.126]:7588 "EHLO
	smtp-msa-out18.orange.fr") by vger.kernel.org with ESMTP
	id S1751354AbWH3TRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 15:17:52 -0400
X-ME-UUID: 20060830191751230.384587000098@mwinf1808.orange.fr
Date: Wed, 30 Aug 2006 21:15:45 +0200
To: David Lang <dlang@digitalinsight.com>
Cc: Sven Luther <sven.luther@wanadoo.fr>, Olaf Hering <olaf@aepfle.de>,
       Michael Buesch <mb@bu3sch.de>, Greg KH <greg@kroah.com>,
       Oleg Verych <olecom@flower.upol.cz>,
       James Bottomley <James.Bottomley@steeleye.com>,
       debian-kernel@lists.debian.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MODULE_FIRMWARE for binary firmware(s)
Message-ID: <20060830191544.GA17203@powerlinux.fr>
References: <1156802900.3465.30.camel@mulgrave.il.steeleye.com> <Pine.LNX.4.63.0608290844240.30381@qynat.qvtvafvgr.pbz> <20060829183208.GA11468@kroah.com> <200608292104.24645.mb@bu3sch.de> <20060829201314.GA28680@aepfle.de> <Pine.LNX.4.63.0608291341060.30381@qynat.qvtvafvgr.pbz> <20060830054433.GA31375@aepfle.de> <Pine.LNX.4.63.0608301048180.31356@qynat.qvtvafvgr.pbz> <20060830181310.GA11213@powerlinux.fr> <Pine.LNX.4.63.0608301119170.31356@qynat.qvtvafvgr.pbz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0608301119170.31356@qynat.qvtvafvgr.pbz>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2006 at 11:20:53AM -0700, David Lang wrote:
> On Wed, 30 Aug 2006, Sven Luther wrote:
> 
> >On Wed, Aug 30, 2006 at 10:52:02AM -0700, David Lang wrote:
> >>On Wed, 30 Aug 2006, Olaf Hering wrote:
> >>
> >>>>you are assuming that
> >>>>
> >>>>1. modules are enabled and ipw2200 is compiled as a module
> >>>
> >>>No, why?
> >>
> >>becouse if the ipw isn't compiled as a module then it's initialized
> >>(without firmware) before the initramfs or initrd is run. if it could be
> >>initialized later without being a module then it could be initialized as
> >>part of the normal system
> >
> >Euh, ...
> >
> >I wonder why you need to initialize the ipw2200 module so early ? It was my
> >understanding that the initramfs thingy was run very early in the process, 
> >and
> >i had even thought of moving fbdev modules into it.
> >
> >Do you really need to bring up ipw2200 so early ? It is some kind of 
> >wireless
> >device, right ?
> 
> if modules are not in use the device is initialized when the kernel starts 
> up. this is before any userspace starts.

Well. but you could do the initialization at open time too, like the other
case that was mentioned here, no ? 

> >As for initramfs, you can just cat it behind the kernel, and it should work
> >just fine, or at least this is how it was supposed to work.
> 
> yes, if I want to set one up.
> 
> other then this new requirement to have the ipw2200 driver as a module I 
> have no reason to use one. normal userspace is good enough for me.

Well, ok.

The real question seems to be if we want to keep the firmware inside the
driver or not.

If we want to remove it, then we put, not the module, but the firmware itself
with some basic userspace to load it on demand in the initramfs, and this is
reason enough to create an initramfs. The fact that the builtin device is
initialized before the initramfs is loaded seems like a bug to me, since the
idea of the initramfs (well, one of them at least), was to initialize it early
enough for this kind of things.

If on the other side, it is more important to not have an initramfs (because
of security issues, or bootloader constraints or what not), then sure, there
is not much choice than putting the firmware in the driver or in the kernel
directly.

But again, the initramfs is just a memory space available at the end of the
kernel, and there is no hardware-related constraint to access it which are in
any way different from having the firmware linked in together with the kernel,
so it is only a matter of organisation of code, as well as taking a decision
on the above, and to act accordyingly.

Does using an initramfs really have some negative side, security related ?
Would some kind of signed or encrypted initramfs be preferable there ? 

Friendly,

Sven Luther

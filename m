Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWGKV45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWGKV45 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 17:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbWGKV45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 17:56:57 -0400
Received: from ns1.suse.de ([195.135.220.2]:5829 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932164AbWGKV44 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 17:56:56 -0400
Date: Tue, 11 Jul 2006 14:52:37 -0700
From: Greg KH <greg@kroah.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "H. Peter Anvin" <hpa@zytor.com>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Clean up old names in tty code to current names
Message-ID: <20060711215237.GA663@kroah.com>
References: <9e4733910607092111i4c41c610u8b9df5b917cca02c@mail.gmail.com> <1152524657.27368.108.camel@localhost.localdomain> <9e4733910607100541i744dd744n16c35c50dae1e98d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910607100541i744dd744n16c35c50dae1e98d@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2006 at 08:41:50AM -0400, Jon Smirl wrote:
> On 7/10/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> >Ar Llu, 2006-07-10 am 00:11 -0400, ysgrifennodd Jon Smirl:
> >> Fix various places in the tty code to make it match the current naming 
> >system.
> >>         pty_slave_driver->driver_name = "pty_slave";
> >
> >
> >NAK to just about all of this. Its gratuitous breaking of existing apps,
> >it achieves nothing and some of it like the pty stuff is just plain
> >incorrect anyway.
> 
> The whole naming scheme encoded into the tty code is incompatible with
> udev. Udev allows renames and this code isn't aware of them.

No, it's not incompatible at all.

Sure udev lets you rename things stupidly, but you can do the same thing
with a simple 'rm' and 'mknod' too.

A good udev setup will follow the LSB naming scheme, and also provide a
persistent device naming scheme for some classes of devices.  If your
distro does not do this, then file bugs and complain to them.

In short, this is not a kernel problem.

> I thought the idea behind udev was to remove all of this naming code
> from the kernel and handle it in user space.

No, that was never the idea behind udev.  udev was created to allow
persistent device naming to be possible, that's all.  It was not
intended to rip all naming out of the kernel, only the non-LSB compliant
names.

Although some people at times have proposed that the in-kernel names be
removed entirely, saner minds have always prevailed.

> So if I want legacy device names I would add a section to /etc/udev to
> create them. Udev is already capable of doing this.

udev should already do this.  If not, then blame your distro for setting
it up improperly.

> >If you want to add sysfs interfaces to the tty code great, but please
> >leave the existing, relied up, functional and effectively user space ABI
> >tty files alone.
> 
> So far I haven't identified anything that is really needed that isn't
> already available in sysfs.
> 
> It does seem that we are missing a user space library call for
> converting a device number into a device name using the udev database.

Again, if you really want this, add the option to udevinfo.  Don't keep
complaining about it...

And no, I would never expect the ps tools to rely on the udev package,
that would be insane.

thanks,

greg k-h

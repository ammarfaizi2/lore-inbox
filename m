Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263839AbTKRXV3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 18:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263840AbTKRXV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 18:21:29 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:63937 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263839AbTKRXV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 18:21:27 -0500
Date: Wed, 19 Nov 2003 00:21:25 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rob Landley <rob@landley.net>
Cc: Pavel Machek <pavel@ucw.cz>, Patrick Mochel <mochel@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Patrick's Test9 suspend code.
Message-ID: <20031118232125.GA30268@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.44.0311170844230.12994-100000@cherise> <200311180602.18511.rob@landley.net> <20031118182216.GB745@elf.ucw.cz> <200311181612.52176.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311181612.52176.rob@landley.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > It then saved happily but didn't resume because I hadn't told it the
> > > default resume partition was /dev/hda2.  (I don't have to specify which
> > > partition to save to, why do I have to specify which one to resume from? 
> > > Oh
> > > well...)
> >
> > Think again. How is kernel expected to find out partition which it
> > should resume from? Try all of them?
> >
> > You did swapon before suspend, that's where you specified "which
> > partition". You need to tell it what to resume from...
> 
> I know.  Then again, if grub can read ext2... :)

:-), Okay, we could make grub read /etc/fstab... But again user can do
swapoff and swapon manually etc.

> Better would be the initramfs stuff, though.  If there's a way to trigger a 
> resume that kills all running processes and loads userspace from the swap 
> partition, then you could do that from initramfs _after_ finding /root a 
> checking fstab, life is good.  (of course ext3 is brain-dead enough to always 
> replay the journal even if it mounts read-only, so you'd have to mount it 
> ext2 or something...  Hmmm...)

Having sto stop userspace processes and bring hardware back to some
sane state would complicate swsusp (and its testing!) a lot. Maybe in
2.8 when it works perfectly in other cases....

> > Strange, it looks like you tried suspending in the middle of module
> > being [un]loaded?
> 
> This was _right_ after the system booted up.  Possibly hotplug was still 
> finding stuff, or the pcmcia wireless card had just decided it had found its 
> access point, or some such...
> 
> These kinds of asynchronous module loads and unloads do happen.  The orinoco 
> card driver is broken enough to sometimes decide that when it loses 
> connection with the access point, instead of toggling the link status it 
> decides the card has been unplugged!  (Real pain when that happens, by the 
> way...)
> 
> So I can imagine modprobe was running, yeah.  But I hadn't done it personally.

I'd attribute it to buggy module.  If you can reproduce it you can try
to fix it....

....but swsusp with modular kernels... I'm not sure if it can even
work. .. yes it can but you really should get it working monolithic, first.

								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.

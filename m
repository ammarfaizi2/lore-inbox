Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbTLHXmA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 18:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbTLHXk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 18:40:28 -0500
Received: from mail.kroah.org ([65.200.24.183]:12190 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261950AbTLHXkF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 18:40:05 -0500
Date: Mon, 8 Dec 2003 15:34:28 -0800
From: Greg KH <greg@kroah.com>
To: Andreas Jellinghaus <aj@dungeon.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: State of devfs in 2.6?
Message-ID: <20031208233428.GA31370@kroah.com>
References: <200312081536.26022.andrew@walrond.org> <20031208154256.GV19856@holomorphy.com> <pan.2003.12.08.23.04.07.111640@dungeon.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pan.2003.12.08.23.04.07.111640@dungeon.inka.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 09, 2003 at 12:04:08AM +0100, Andreas Jellinghaus wrote:
> On Mon, 08 Dec 2003 15:50:45 +0000, William Lee Irwin III wrote:
> > I would say it's deprecated at the very least. sysfs and udev are
> > supposed to provide equivalent functionality, albeit by a somewhat
> > different mechanism.
> 
> huh?
> 
> aj@simulacron:/dev$ find -type c -mount |grep -v pty |wc -l
>     164
> aj@simulacron:/dev$ find -type b |wc -l
>     157
> aj@simulacron:/dev$ find /sys/ -name dev |wc -l
>     250
> 
> After ignoring .devfsd we are left with 70 devices missing:
>  - 15 floppy devices

You have 15 floppy devices connected to your box?  All floppy devices
should show up in /sys/block.

>  - 5 input/ devices

Patch for sysfs support for this has been posted by Hanna Linder.  It
still needs work before being added to the kernel tree.

>  - full, kmem, kmsg, mem, null, port, random, urandom, zero

Patch for this has been posted by me to lkml in the past.  It will
probably go into 2.6.1

>  - printers/0 

Hanna Linder is working on a patch for these devices.

>  - 5 misc/ devices

Patch for this has been posted by me to lkml in the past.  It will
probably go into 2.6.1.

>  - 12 snd/ devices
>  - 5 sound/ devices

I have a patch here from Leann Ogasawara that adds sysfs support for
these devices.  I've been lacking time to test it better, but again, it
will probably make it into 2.6.1.

>  - 18 vcc/ devices

Hm, good catch.  I wonder why these aren't getting picked up in
/sys/class/tty as they are tty devices.  I thought they used to be
there...

> I wouldn't call udev deprecated, unless a newer kernel has the
> essential devices, too.

You mean s/udev/devfs/ right?  :)

> And is there a udev version that can
> do devfs names? last time I checked only lanana names were supported.

There is a udev config file that was just posted to linux-hotplug-devel
that supports a lot of devfs names.  If there are any missing that you
use, please post a config file for them.

Remember, I don't use devfs, so I really don't care about a udev mapping
for it :)

> Some distributions were quite happy to move from /dev and lanana to
> devfs with better names.

Hm, 2?  And one of them (Mandrake) got smart and went back...

> I doubt everyone will rush to udev with lanana names,

Why not?  It's the standard afterall.  Remember, the devfs users are in
the tiny minority here.

> and
> re-introducing makedev for devices not represented
> in sysfs doesn't sound very nice either. So 2.8.* might be a nice time
> frame for dropping devfs, or at least give sysfs and udev a few months
> to catch up on the issues mentioned.

Regardless of the state of udev, devfs has insolvable problems and you
should not use it.  End of story.

thanks,

greg k-h

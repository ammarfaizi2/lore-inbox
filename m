Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264187AbTDJV3R (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 17:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264188AbTDJV3R (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 17:29:17 -0400
Received: from [209.226.175.203] ([209.226.175.203]:31715 "EHLO
	toq7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S264187AbTDJV3P (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 17:29:15 -0400
Date: Thu, 10 Apr 2003 17:35:34 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Greg KH <greg@kroah.com>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: USB optical mouse on laptop causes bk12 boot to hang
In-Reply-To: <20030407155858.GA2553@kroah.com>
Message-ID: <Pine.LNX.4.44.0304101727410.1369-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Apr 2003, Greg KH wrote:

> On Mon, Apr 07, 2003 at 09:23:19AM -0400, Robert P. J. Day wrote:
> > 
> >   on to the next issue.  the setup:
> > 	dell inspiron 8100 laptop
> > 	RH 9
> > 	2.5.66-bk12
> > 
> >   for ergonomic reasons, rather than use the laptop keyboard and
> > touchpad, i have (under the previous RH 8 and 2.4.20) been using
> > an external PS/2 keyboard and logitech USB optical mouse.  this
> > setup has been working fine -- when both external input devices
> > are connected, i can use either keyboard, and just the optical
> > USB mouse.
> > 
> >   booting under 2.5.66-bk12, if just the keyboard is connected,
> > no problem.  the boot works, both keyboards are active, and the
> > touchpad works.
> > 
> >   however, if i connect *only* the optical mouse, the boot gets
> > to "Freeing unused kernel memory", hangs for about a minute, 
> > then powers down the box.  not good.  (same thing happens if 
> > both external keyboard and mouse are connected, so i've isolated
> > it to just the optical mouse).
> 
> What happens when you plug in the mouse, after the boot process has
> completed?

ok, here's the result of testing all this with 2.5.67-bk2.  i built
a new kernel and modules, rebooted and:

1) with USB optical mouse and PS/2 keyboard:
	system hangs after "Freeing unused kernel memory"

2) with USB optical mouse only:
	same problem as 1)

3) with PS/2 keyboard only:
	boots fine, both keyboards work, and onboard touchpad works

so having the mouse plugged into the USB port seems to be the issue.

  and checking further, i find that i've apparently no USB support
loaded whatsoever.  i plugged in the mouse, and got no reaction
(i was tailing /var/log/messages at the time).  plugged in a
USB zip drive, still no reaction at all.

  /var/log/dmesg shows nothing related to USB recognition.
and another oddity is that, as the system was booting, i got
a complaint that it couldn't mount the FAT partition as the
kernel had no vfat support.

  but i have vfat support as a module, however, "lsmod" shows
a really skimpy set of loaded modules.  it looks like autoloading
of modules just isn't happening.  i don't even have a module for
the USB bus, which explains a lot.

  i have full module support selected in kernel configuration,
but it seems that the required modules just aren't being loaded
on demand.

  i just tested and "modprobe" seems to work, but i don't
understand why none of this stuff is being loaded at boot
time.

  i'm still running under the new kernel, so i'm willing to
entertain things i can check, but i have no X session (nvidia,
which i haven't even *tried* to set up under 2.5.67).

  any hints?

rday


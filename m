Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263697AbTKKTYt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 14:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263698AbTKKTXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 14:23:00 -0500
Received: from gaia.cela.pl ([213.134.162.11]:54280 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S263703AbTKKTWT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 14:22:19 -0500
Date: Tue, 11 Nov 2003 20:22:14 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.4.23-pre9 ide+XFree+ptrace=Complete hang
Message-ID: <Pine.LNX.4.44.0311111849590.27840-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a very vague bug report... however this is something which 
definetely shouldn't be happening.  This is more a question as to whether 
such an issue is known and if not, how should I go about fixing it...

Running a patched 2.4.23-pre9 kernel (I don't think the patches are in
places which might affect this) on a Satellite 2590 CDT laptop (pretty old
and no real stability problems so far, I've had uptimes of months
(obviously not on this kernel, but on 2.4.9-34 RH) with hibernation,
everything is supported under linux) I'm experiencing total lockups
(non-responding keyboard, ps2 mouse, usb mouse, ping from outside,
sometimes even the bios crashes (the fn key ceases to cause a status LED
to light up)).  This is an up2date RH9 system.

This has happened now a dozen times in the last hour.

All I need to do is start the Xserver (i'm using twm as the window 
manager, so no extra junk) open an xterm and run
  strace /bin/ls -lR /
as a normal unpriveledged user.
Junk starts spamming across the terminal (as expected) and then sooner or 
later (random time interval) everything crashes, most likely with the 
terminal screen empty from a given scanline (often in the middle of a text 
row) and on down.  This has never happened on ls -lR / alone in an xterm 
(ie the Xserver screen update doesn't seem to be the problem).
I expect this is some sort of interaction (race?) but I have no idea how 
to go about testing this...

Obviously due to this being under X, there's no oops.

Running strace /bin/ls -lR / on a text console doesn't appear to cause 
crashes - but then that's a lot less taxing for the computer...

Perhaps I should mention that this doesn't seem to be a strace bug per se 
since this happened while writing my own ptrace-based utility (also does 
stdio output, but way less that strace, although it seems to crash faster) 
and I've since verified that strace crashes in exactly the same manner.

The minimum case I've managed to get to crash:

processes: init + kernel threads + mingetty * 9 + login + bash + X + xterm
command: strace /bin/ls -lR / 2>/dev/null
no pcmcia/usb etc modules loaded
with minimal mounted file systems (rootfs,tmpfs,proc,devfs,ext3 (and 
vfat)) (have seen crash during ls on vfat and seperately on ext3, only 
during ide disk access, doesn't seem to crash when running out of cache)

As far as I can tell it only happens when video screen output, ide hard 
disk access and ptrace are happening at the same time...

Any ideas?

I'm about to embark on a bug binsearch (I know RH 2.4.20-18.9 doesn't 
freeze) and I'm hoping someone will save me the trouble... :)

Cheers,
MaZe.




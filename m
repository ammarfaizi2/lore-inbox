Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130836AbRBGBIC>; Tue, 6 Feb 2001 20:08:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130909AbRBGBHy>; Tue, 6 Feb 2001 20:07:54 -0500
Received: from ns2.arlut.utexas.edu ([129.116.174.1]:11279 "EHLO
	ns2.arlut.utexas.edu") by vger.kernel.org with ESMTP
	id <S130836AbRBGBHn>; Tue, 6 Feb 2001 20:07:43 -0500
Date: Tue, 6 Feb 2001 19:07:32 -0600 (CST)
Message-Id: <200102070107.TAA13197@csdsun1.arlut.utexas.edu>
From: Jonathan Abbey <jonabbey@arlut.utexas.edu>
To: linux-kernel@vger.kernel.org
Subject: Hard system freeze in 2.2.17, 2.2.18, 2.4.1-AC3 VIA Athlon
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am having terribly frustrating system stability problems, and I
can't figure out whether I should suspect hardware or the kernel.

Software:

Any of Linux 2.2.17, 2.2.18, 2.4.1-AC3

Hardware:

Athlon Thunderbird 750mhz, running at rated speed
EPoX 8KTA2 VIA Athlon motherboard with VT82C686B Southbridge, VT8363 Northbridge

My system boots fine, and once it gets past the mandatory fsck, it
proceeds up to X just fine.  I can pretty much log in, do web
browsing, play Unreal Tournament with accelerated OpenGL, burn cd's,
play music, whatever.

What I can't do is run XEmacs, either in X Windows or on a command
line window over ssh or mingetty.  9 times out of 10, as soon as I run
'xemacs', the system locks tight.  No responsiveness to any keyboard
activity, no alt-SysRq, nothing.  One time the system locked when I
was playing an mp3 with XMMS and after it locked the sound card kept
looping the same quarter-second of sound it had been playing when the
system locked.  I have also seen what looks like this system hang
occur often when compiling a new kernel, and it has happened when my
housemate was running Netscape once, both of those under 2.2.17.

About a week ago, I decided to see about a BIOS update, and while I
went about getting my BIOS flashed, I also installed an IDE CD-RW
drive and updated my kernel to 2.2.18.  All of this gave my system a
couple of hours of rest with the power off.

After I got everything back together and got the BIOS flashed,
everything seemed to work great.  I built myself a 2.2.18 kernel with
the IDE-SCSI driver to support cdrecord on my new CDRW drive.  For 5
days my system ran with excellent stability.  I took to running
'xemacs' frequently, just to enjoy the thrill of not having to fsck my
drives.

Until a couple of nights ago.  My friend the hard system freeze has
returned, with all of the old symptoms.  I run xemacs, I lock, nearly
every time.

I have tried to check certain things.  I set my system's BIOS up so
that it does the full POST check, including three passes over the RAM.
No problems reported at any time.  I have tried running my PC133 RAM
clocked at 100mhz.  I have commented out my hdparm lines in my boot
scripts.  No effect.

I am really confused by this one.  The fact that running xemacs can
reliably lock the system makes me think it is a kernel problem.
There's nothing about running xemacs that I would expect to be
particularly stressfull on the system.  Running Unreal Tournament with
heavy 3d acceleration and sound I would expect to be much more
stressful on my system's power supply and RAM, but that's pretty safe
to do.  XEmacs does do a funky unexec() thing to create its exec
image, and I imagine it does some things with pty's and the like that
many pieces of software does not.. plenty of opportunities to tickle
different parts of the kernel.

On the other hand, having the problem go away after a couple of hours
of down time for my system's components, and to have the problem come
back after five days usage and to then stay across several system
hangs and reboots makes me think it is a hardware problem.

So.. how in the world do I go about isolating this?  When it hangs, it
hangs tight enough that alt-SysRq is of no use, so I can't get any
kind of kernel oops message or anything like that.  The memory test
that the BIOS does seems to work fine.  The video, ethernet, and sound
cards shouldn't be connected to this since I can run xemacs from
single user mode on the console and get this lock-up.

I have tried doing an strace on xemacs from the console, but the
system freeze and the resulting file system corruption and fsck on
reboot makes any snapshot of the strace output unreliable.

I have tried futzing with various BIOS settings in the hope of making
the system more stable, to no effect.

I'm wondering if there is a problem with how the kernel is interacting
with the VIA chipset, but that five day grace period really makes me
think of hardware.

-- 
-------------------------------------------------------------------------------
Jonathan Abbey 				              jonabbey@arlut.utexas.edu
Applied Research Laboratories                 The University of Texas at Austin
Ganymede, a GPL'ed metadirectory for UNIX     http://www.arlut.utexas.edu/gash2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

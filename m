Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264258AbTKZRMV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 12:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264239AbTKZRMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 12:12:21 -0500
Received: from out001pub.verizon.net ([206.46.170.140]:47829 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S264258AbTKZRML
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 12:12:11 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: amanda vs 2.6
Date: Wed, 26 Nov 2003 12:12:10 -0500
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311261212.10166.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [151.205.54.127] at Wed, 26 Nov 2003 11:12:10 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings everybody, scsi folks in particular;

I don't know if I've got a bad, miss-set link thats effecting the 
build of amanda, or ???

Preconditions:
tape drive has magazine, magazine ejected and reloaded, but all tapes 
still reside in the magazine carrier.

Under a 2.4.22-pre10 boot, a run of amcheck will load the last loaded 
slot of the magazine and proceed to search the magazine for the next, 
correct tape.

Under a 2.6.0test9 or 10 boot, it loads a tape, but then gets a signal 
11 and exits.  A re-run from that point, where it does have a loaded 
tape from the first run, proceeds 100% normally in searching the 
magazine.

Preset the magazine again and run it with gdb, and get this only if 
booted to a 2.6 kernel:

[amanda@coyote DailySet1]$ gdb /usr/local/libexec/chg-scsi
GNU gdb Red Hat Linux (5.2.1-4)
Copyright 2002 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and 
you are
welcome to change it and/or distribute copies of it under certain 
conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for 
details.
This GDB was configured as "i386-redhat-linux"...
(gdb) run -info
Starting program: /usr/local/libexec/chg-scsi -info
0 4 1 0

Program exited normally.
(gdb) bt
No stack.
(gdb) run -slot 1
Starting program: /usr/local/libexec/chg-scsi -slot 1

[several minutes elapse]

Program received signal SIGSEGV, Segmentation fault.
0x4011f453 in strchr () from /lib/libc.so.6
(gdb) bt
#0  0x4011f453 in strchr () from /lib/libc.so.6
#1  0x00000001 in ?? ()
#2  0x40034899 in tape_open (filename=0x0, mode=0, mask=2) at 
tapeio.c:540
#3  0x40034e4f in tape_rewind (devname=0x0) at tapeio.c:734
#4  0x0804f372 in GenericRewind (DeviceFD=2) at 
scsi-changer-driver.c:2583
#5  0x0804d637 in Tape_Ready (fd=2, wait_time=63) at 
scsi-changer-driver.c:1459
#6  0x0804b2a2 in main (argc=3, argv=0xbffff5c4) at chg-scsi.c:1581
#7  0x400c154d in __libc_start_main () from /lib/libc.so.6
(gdb) quit
The program is running.  Exit anyway? (y or n) y

Additional data:  /usr/src/linux-2.6 points at the 2.6.0-test10 src 
tree, but /usr/src/linux points at the 2.4.22-pre10 src tree.  I have 
NDI if this has any effects, good or bad, on the configure and build 
of amanda, which is itself the latest 2.4.4p1 snapshot dated 
20031120.

And ANAICT, nothing else amanda related is effected.  Bug, feature, 
miss-configuration?  Hints?

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265130AbTBJUd6>; Mon, 10 Feb 2003 15:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265134AbTBJUd6>; Mon, 10 Feb 2003 15:33:58 -0500
Received: from chaos.analogic.com ([204.178.40.224]:3456 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265130AbTBJUd5>; Mon, 10 Feb 2003 15:33:57 -0500
Date: Mon, 10 Feb 2003 15:43:48 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: linux-2.5.59 kills ld.so.cache and some shared libraries.
Message-ID: <Pine.LNX.3.95.1030210152059.250A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,
I retrieved, compiled, booted linux-2.5.59. Seemed to work
okay. I have the following modules installed.

Module                  Size  Used by
ipchains               33624   7 
ipx                    18724   0  (unused)
3c59x                  27968   1  (autoclean)
nls_cp437               4472   4  (autoclean)
isofs                  17264   0  (unused)
loop                    8536   0  (unused)
sr_mod                 11996   0  (unused)
cdrom                  27872   0  [sr_mod]
BusLogic               35832   7 
sd_mod                 10168  14 
scsi_mod               51808   3  [sr_mod BusLogic sd_mod]

However, after running it for an hour, I tried to reboot. The
root file-system was permanently busy so it didn't get un-mounted.

Upon re-boot, there was a very long fsck in which a lot of
stuff had to be "fixed", much more than simply a bad dismount.

Then, fsck failed (stopped) in the middle. I waited about 15 minutes
and hit the reset switch. After than, no executable files could
execute. Booting and mounting an alternate root, I found that
/etc/ld.so.cache had been destroyed as well as several of the
important runtime files. I have retrieved the bad ld.so.cache file
if anyone wants it. Fortunately I have several copies of the
runtime libraries.

Currently, I'm back using 2.4.18 (which works). I have about
40 files in lost+found that I'm reviewing to see if they are
important. There are several pieces of many library files that
were mmapped. I find libc.so.6, libtermcap, etc. These memory-
mapped files should have never been written to, however I
think that a corrupted memory image can get written back to
the file(s). I'm currently building another root file-system to
destroy and I think that if I do `cp /dev/zero /dev/mem` the
underlying memory-mapped files can get written in spite of
that fact that they are read/exec only.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.



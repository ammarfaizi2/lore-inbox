Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266434AbSKGJuO>; Thu, 7 Nov 2002 04:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266440AbSKGJuO>; Thu, 7 Nov 2002 04:50:14 -0500
Received: from cibs9.sns.it ([192.167.206.29]:2826 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id <S266434AbSKGJuM>;
	Thu, 7 Nov 2002 04:50:12 -0500
Date: Thu, 7 Nov 2002 10:56:51 +0100 (CET)
From: venom@sns.it
To: linux-kernel@vger.kernel.org
Subject: hard loockup with 2.5.46 and high network load (no logs), at reboot
  reiserFS troubles, and network card not seen anymore till poweroff.
Message-ID: <Pine.LNX.4.43.0211071041570.5656-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


HI,
I was making some test for fun and I incurred in this strange behaviour.

I was making an eavy NFS I/O (some GB) with nfs3 and the server:
a PIII 512 MB RAM
i810 chipset (ATA 66 disks)
3Com 3c905C-TX/TX-M [Tornado] network card

simply loocked up while I was doing an arping from it to the client.

Kernel is 2.5.46, compiled with gcc 3.2, binutils 2.13.90.0.10, glibc
2.3.1.
nfsutils are 1.0.1.

There was nothing in the log files, except:

Nov  7 09:34:18 Blackdeath icmplogd: destination unreachable from Blackdeath.adm.epiclink.it
Nov  7 09:44:11 Blackdeath kernel: Warning: null TTY for (88:08) in tty_fasync
Nov  7 09:47:08 Blackdeath gpm[255]: imps2: Auto-detected intellimouse PS/2
Nov  7 09:47:12 Blackdeath modprobe: modprobe: Can't locate module char-major-10-134
Nov  7 09:49:18 Blackdeath icmplogd: destination unreachable from Blackdeath.adm.epiclink.it

[and HERE there was the loock up]

Nov  7 09:52:13 Blackdeath syslogd 1.4.1: restart.
Nov  7 09:52:14 Blackdeath kernel: klogd 1.4.1, log source = /proc/kmsg
started.
Nov  7 09:52:14 Blackdeath kernel: Cannot open map file: -x.


During reboot Reiserfs had to:

Nov  7 09:52:35 Blackdeath kernel: ReiserFS version 3.6.25
Nov  7 09:52:35 Blackdeath kernel: reiserfs: checking transaction log (device 16
:03) ...
Nov  7 09:52:35 Blackdeath kernel: reiserfs: replayed 13 transactions in 2 seconds
Nov  7 09:52:35 Blackdeath kernel: Using r5 hash to sort names
Nov  7 09:52:35 Blackdeath kernel: Removing [936 1063 0x0 SD]..done
Nov  7 09:52:35 Blackdeath kernel: Removing [936 1062 0x0 SD]..done
Nov  7 09:52:35 Blackdeath kernel: Removing [936 1061 0x0 SD]..done
Nov  7 09:52:36 Blackdeath kernel: Removing [936 1057 0x0 SD]..done
Nov  7 09:52:36 Blackdeath kernel: Removing [48588 936 0x0 SD]..done
Nov  7 09:52:36 Blackdeath kernel: There were 5 uncompleted
unlinks/truncates. Completed

on the exported filesystem. (this is the first time I have something
wrong with reiserFS since the corruptions in early 2.5 kernels)

What really surprised me is that after i pressed the reset button, booting
a 2.4.19 kernel, the network card was not seen anymore, nor I could find
it in /proc/pci. I had to power off the computer for some second, then
(after I checked power saving is disable in bios) at
reboot, with 2.4.19 kernel, the card was seen again.

I hope this helps

Luigi Genoni



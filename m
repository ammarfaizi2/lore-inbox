Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbUCBU7P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 15:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbUCBU7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 15:59:14 -0500
Received: from chaos.analogic.com ([204.178.40.224]:22912 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261769AbUCBU7F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 15:59:05 -0500
Date: Tue, 2 Mar 2004 15:59:48 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: poll 2.6 and beyond
Message-ID: <Pine.LNX.4.53.0403021550320.2150@chaos>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1678434306-278847438-1078261188=:2150"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1678434306-278847438-1078261188=:2150
Content-Type: TEXT/PLAIN; charset=US-ASCII


Hello all,
The provided driver and test code clearly shows that
poll_wait is returning to the driver as soon as it is
called, therefore not able to return the correct status.

It must remain sleeping until awakened by the driver so
that the driver can provide the correct return status.

This driver code doesn't even provide a method of waking
up poll_wait().  There is no wake_up_interruptible() in
the code at all!!!

The first

	Linux Thingy : poll() called
	Linux Thingy : poll() returned

... group occurred when the user-mode code called poll(). The
second identical group occurred when ^C was used to signal
termination.


Script started on Tue Mar  2 15:46:50 2004
# make clean
rm -f *.o THINK tester
# make
gcc -Wall -O2 -D__KERNEL__ -DMODULE -DMAJOR_NR=199  -I/usr/src/linux-2.4.24/include -c -o thingy.o thingy.c
gcc -Wall -o tester -O2 tester.c
rm -f THING
mknod THING c 199 0
# insmod thingy.o
# strace ./tester
execve("./tester", ["./tester"], [/* 32 vars */]) = 0
brk(0)                                  = 0x8049710
open("/etc/ld.so.preload", O_RDONLY)    = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
old_mmap(NULL, 0, PROT_READ|PROT_WRITE, MAP_PRIVATE, 3, 0) = 0
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
old_mmap(NULL, 4096, PROT_READ, MAP_PRIVATE, 3, 0) = 0x4000c000
munmap(0x4000c000, 4096)                = 0
old_mmap(NULL, 644232, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4000c000
mprotect(0x40097000, 74888, PROT_NONE)  = 0
old_mmap(0x40097000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x8b000) = 0x40097000
old_mmap(0x4009d000, 50312, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4009d000
close(3)                                = 0
mprotect(0x4000c000, 569344, PROT_READ|PROT_WRITE) = 0
mprotect(0x4000c000, 569344, PROT_READ|PROT_EXEC) = 0
personality(PER_LINUX)                  = 0
getpid()                                = 2122
open("THING", O_RDONLY)                 = 3
poll(
 <unfinished ...>
# dmesg | tail
Linux Thingy : module removed
Linux Thingy : initialization complete
Linux Thingy : poll() called
Linux Thingy : poll() returned
Linux Thingy : poll() called
Linux Thingy : poll() returned
# exit
exit

Script done on Tue Mar  2 15:47:48 2004


Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


--1678434306-278847438-1078261188=:2150
Content-Type: APPLICATION/octet-stream; name="module.tar.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.53.0403021559480.2150@chaos>
Content-Description: 
Content-Disposition: attachment; filename="module.tar.gz"

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

--1678434306-278847438-1078261188=:2150--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312956AbSC0CVM>; Tue, 26 Mar 2002 21:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312970AbSC0CVB>; Tue, 26 Mar 2002 21:21:01 -0500
Received: from p-nya.swiftel.com.au ([202.154.76.83]:9485 "EHLO
	mail.robres.com.au") by vger.kernel.org with ESMTP
	id <S312956AbSC0CUm>; Tue, 26 Mar 2002 21:20:42 -0500
Message-Id: <200203270220.g2R2K7t32470@mail.robres.com.au>
Content-Type: text/plain; charset=US-ASCII
From: Franco Broi <franco@robres.com.au>
To: linux-kernel@vger.kernel.org
Subject: Process hangs
Date: Wed, 27 Mar 2002 10:22:23 +0800
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

I'm running 2.4.18-rc4 on Alpha SMP. I'm experiencing problems with processes
which don't exit properly leaving an entry in the /proc filesystem that hangs any
process that tries to read it, ie top, ps etc.  I've seen this exact problem mentioned
on the mailing list for Intel machines so it doesn't look like an Alpha specific problem.

Strace of ps

stat("/proc/4019", {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0
open("/proc/4019/stat", O_RDONLY)       = 7
read(7, "4019 (tcsh) S 4017 4019 4019 348"..., 511) = 215
close(7)                                = 0
open("/proc/4019/statm", O_RDONLY)      = 7
read(7, "253 107 106 0 106 1 0\n", 511) = 22
close(7)                                = 0
open("/proc/4019/status", O_RDONLY)     = 7
read(7, "Name:\ttcsh\nState:\tS (sleeping)\nT"..., 511) = 456
close(7)                                = 0
open("/proc/4019/cmdline", O_RDONLY)    = 7
read(7, "-csh\0", 2047)                 = 5
close(7)                                = 0
open("/proc/4019/environ", O_RDONLY)    = -1 EACCES (Permission denied)
stat("/proc/10577", {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0
open("/proc/10577/stat", O_RDONLY)      = 7
read(7, 

hangs here.

I traced the offending process to a user program which had done a divide by zero. When I
ran the program with gdb I got a floating exception, when I ran it without gdb it hung.
I then did a few more tests using different shells and different user accounts, the results
were inconclusive. It soemtimes worked and sometimes failed.

The kernel is patched to run GFS but I don't think this is a factor.

Regards
Franco

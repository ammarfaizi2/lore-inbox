Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261765AbSIXRfo>; Tue, 24 Sep 2002 13:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261738AbSIXRed>; Tue, 24 Sep 2002 13:34:33 -0400
Received: from d12lmsgate-2.de.ibm.com ([195.212.91.200]:49102 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S261739AbSIXRWs> convert rfc822-to-8bit; Tue, 24 Sep 2002 13:22:48 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.38 s390 fixes.
Date: Tue, 24 Sep 2002 19:26:02 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209241914.14579.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
I put together a set of patches for s/390 again. There are 24 patches, each
starting with a small description. To get a useful s390/s390x kernel at
least the first 5 patches are needed.

The list of patches and some comments:

01_minimal:    Minimal patch to get the kernel without any device drivers 
               compiled and working again.
02_syscalls:   Add the new system calls.
03_partition:  Get the bloody ibm partition code to work.
04_config:     I removed some unnecessary config options and restructure
               the configuration menu a bit.
05_dasd:       I picked up Al Viros changes to the dasd driver and made
               it even better.
06_xpram:      No comment.
07_tasklet:    Get rid of the bottom halves in the s/390 device drivers.
08_bitops:     A bug fix for the (unused) option ALIGN_CS == 1.
09_emu31:      Latest 31 bit emulation fixes.
10_vmlinux:    Unify the two linker scripts.
11_preempt:    Add preemption support. It still complains about about
               "scheduling while atomic" though.
12_inline:     Inline all tcpip checksum functions and optimize xchg.
13_diag44:     Make use of the diag 0x44 in 64 bit spinlock code. The diag 0x44
               yields a virtual cpu under VM and LPAR.
14_time:       I removed the dependency on the boot cpu in the timer interrupt.
               This makes it easier with the timer patch and with switching
               cpus on and off.
15_beauty:     Some beautification.
16_fpu:        Optimization for loading/storing of fpu registers. Got rid
               of another stupid file in arch/s390/kernel.
17_ptrace:     Make ptrace readable.
18_quiesce:    Add signal quiesce support.
19_syncisc:    Fix and simplify synchronous i/o functions.
20_ending:     Simplify s390_process_IRQ.
21_chpid:      Do the right thing if channel paths are not available.
22_boot:       Reworked boot sequence.
23_boot_common:Remove s390 specific init call from init/main.c. 22_boot
               and 23_boot_common are related.
24_proc_misc:  /proc/interrupts does not make sense on s390. There are
               65536 i/o and 65536 external interrupts. We do not really
               want to have a file with #cpus * 128K zeros.

blue skies,
  Martin.



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261875AbSJDOmU>; Fri, 4 Oct 2002 10:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261849AbSJDOk1>; Fri, 4 Oct 2002 10:40:27 -0400
Received: from d06lmsgate-5.uk.ibm.com ([195.212.29.5]:22450 "EHLO
	d06lmsgate-5.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S261851AbSJDOh1> convert rfc822-to-8bit; Fri, 4 Oct 2002 10:37:27 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.40 s390.
Date: Fri, 4 Oct 2002 16:24:17 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210041624.17373.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
the 27th patch has joint the patch set for s/390. Minimum set for something
useful is again the first 7 patches. 

The list of patches and some comments:

01: arch/s390 and arch/s390x part of the minimal patch to get the kernel
    compiled again (without any device drivers).
02: include/asm-s390 and include/asm-s390x part of the minimal patch.
03: drivers/s390 part of the minimal patch.
04: Add new system calls.
05: Get the bloody ibm partition code to work.
06: I removed some unnecessary config options and restructured the
    configuration menu a bit.
07: Fixes and more cleanup for the dasd driver. Thanks to Al Viro we
    got rid of the ugly things in the dasd driver. The only big thing
    left is big minors. In preparation we removed kdev_t where possible.
08: Fixes for the xpram driver.
09: Get rid of some of the bottom halves in the s/390 device drivers. Yet
    to be are ctrlchar, tape, 3270 and lcs.
10: A bug fix for the (unused) option ALIGN_CS == 1.
11: Latest 31 bit emulation fixes.
12: Unify the two linker scripts and let the preprocessor deal with
    CONFIG_SHARED_KERNEL.
13: Add preemption support. It still complains about about "scheduling
    while atomic" though.
14: Inline all tcpip checksum functions and optimize xchg.
15: Make use of the diag 0x44 in 64 bit spinlock code. The diag 0x44 yields
    a virtual cpu under VM and LPAR is the lock is taken.
16: I removed the dependency on the boot cpu in the timer interrupt.
    This makes it easier with the timer patch and with switching
    cpus on and off.
17: Some code beautification.
18: Optimization for loading/storing of fpu registers. Got rid
    of another stupid file in arch/s390/kernel.
19: Make ptrace readable.
20: Add signal quiesce support to shut down the system on demand.
21: Fix and simplify synchronous i/o functions.
22: Simplify s390_process_IRQ.
23: Do the right thing if channel paths are not available.
24: Reworked boot sequence.
25: Remove s390 specific init call from init/main.c. 24 and 25 are related.
26: /proc/interrupts does not make sense on s390. There are
    65536 i/o and 65536 external interrupts. We do not really
    want to have a file with #cpus * 128K zeros.
27: Get rid of the bottom half in the helper functions for console control
    characters. Fixes a race condition as well and the ctrlchar code looks
    nicer now.

blue skies,
  Martin.



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264819AbUEaWRt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264819AbUEaWRt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 18:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264820AbUEaWRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 18:17:49 -0400
Received: from aun.it.uu.se ([130.238.12.36]:46524 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S264819AbUEaWRq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 18:17:46 -0400
Date: Tue, 1 Jun 2004 00:17:39 +0200 (MEST)
Message-Id: <200405312217.i4VMHdHW012262@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][0/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: summary
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This set of patches add perfctr-2.7.3, the performance-monitoring
counters driver, to kernel 2.6.7-rc1-mm1.

Based on comments from Andrew Morton, Andi Kleen, Tom Rini,
the main change since the previous version is that the single
multiplexing system call has been replaced by several separate
system calls.

Extract from the change log:

- Replaced the single system call by six system calls: one
  for getting CPU information, and 5 for per-process perfctrs.
- Removed marshalling of system call parameters. Conventional
  copying is now done.
- Temporarily removed global-mode perfctrs, while the API
  to the per-process perfctrs is being redesigned.
- Changed x86-64 to use the x86 code. Simplifies maintenance,
  and, in theory, adds support for IA32e/EM64T.
- Moved detailed CPU type detection on x86 from the driver
  to the library. This is both a cleanup and a bug fix.
- Some changes to prepare the ppc32 data structures for
  potential G5/970 support, in both 32 and 64-bit kernels.
- PowerPC 750GX support added.
- Moved ppc32 #define:s to <asm-ppc/reg.h>.
- Lots of code cleanups. Converted NR_CPUS arrays to per_cpu().
  Changed spacing in if/while/switch to be "normal".

Summary: perfctr drives the performance counters in i386,
x86_64, and PowerPC processors. It supports virtualised
per-process counters with low-overhead user-space sampling.

The set of patches that follow are:

1/6: core driver files and kernel changes
2/6: i386 driver and arch changes
3/6: x86_64 arch changes
4/6: PowerPC driver and arch changes
5/6: driver for virtualised (per-process) performance counters
6/6: remaining small changes

/Mikael Pettersson

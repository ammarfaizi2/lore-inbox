Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262224AbTIMWYx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 18:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262232AbTIMWYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 18:24:53 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:57851 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262224AbTIMWYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 18:24:51 -0400
Date: Sun, 14 Sep 2003 00:24:43 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-kernel@vger.kernel.org
Subject: [0/4] [2.6 patch] better i386 CPU selection
Message-ID: <20030913222443.GN27368@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch is now splitted into the following four patches:

[1/4]
- changed the i386 CPU selection from a choice to single options for
  every cpu
- renamed the M* variables to CPU_*, this is needed to ask the users
  upgrading from older kernels instead of silently changing the
  semantics
- X86_GOOD_APIC -> X86_BAD_APIC
- AMD Elan is a different subarch, you can't configure a kernel that
  runs on both the AMD Elan and other i386 CPUs
- added optimizing CFLAGS for the AMD Elan
- gcc 2.95 supports -march=k6 (no need for check_gcc)
- help text changes/updates

[2/4]
move "struct movsl_mask movsl_mask" to usercopy.c 
(CONFIG_X86_INTEL_USERCOPY is used on non-Intel CPUs)

[3/4]
- made arch/i386/kernel/cpu/Makefile CPU specific

[4/4]
- made arch/i386/kernel/cpu/mtrr/Makefile CPU specific

Dependencies between these patches:
- patch 3 requires 1+2
- patch 4 requires 1

The main part is patch 1.

Patch 2 fixes a small issue that only shows up with patch 3.

Patches 3+4 add some space optimizations by omitting unneeded code. They 
are _not_ required, the main part is patch 1.


TODO:
- which CPUs exactly need X86_ALIGNMENT_16?
- change include/asm-i386/module.h to use some kind of bitmask


cu
Adrian

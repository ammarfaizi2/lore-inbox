Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751326AbWCHP5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbWCHP5R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 10:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbWCHP5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 10:57:16 -0500
Received: from palrel10.hp.com ([156.153.255.245]:41621 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S1751326AbWCHP5P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 10:57:15 -0500
Date: Wed, 8 Mar 2006 07:53:11 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: linux-kernel@vger.kernel.org
Cc: perfmon@napali.hpl.hp.com, perfctr-devel@lists.sourceforge.net,
       linux-ia64@vger.kernel.org
Subject: 2.6.16-rc5 perfmon2 new code base + libpfm with Montecito support
Message-ID: <20060308155311.GD13168@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have released another version of the perfmon new base package.
This release is relative to 2.6.16-rc5

Due to the addition of a few system calls since 2.6.16-rc1, the
system call base number for all perfmon calls has changed yet again
on all architectures. As such you need to use the new version of
libpfm: libpfm-3.2-060308. 

This new kernel patch includes several important changes:

	- migrated all of /proc perfmon interface to /sys. The information
	  is split between general and per-cpu. As such it is located in
	  /sys/kernel/perfmon and /sys/devices/system/cpu*/perfmon/

	- all data structures exchanged with the kernel now use fixed size
	  data types. As such they can be used without any changes by a 32-bit
	  application running on top on a 64-bit OS. The following changes took
	  place:
		* all bitvectors use u64 and have fixed number of bits
		* size_t is now u64
		* struct timespec (set timeout) replaced by u32 (unit in micro-seconds)
		* default format sampling buffer IP (instruction pointer) is u64

	- added 32-bit ABI support for x86-64 arch. As a consequence, it is now
	  possible to run a 32-bit P4 tool on a 64-bit EM64T processor, assuming the
	  tool know the specifics of EM64T PMU. That goes also for PEBS support.

	- Simplified the PMU description data structures. The structure pfm_pmu_config
	  is now split between a perfmon internal and PMU description version providing
	  further isolation between the core and module-provided support. There is
	  a simplification also in the struct pfm_reg_desc tables describing the mappings.
	  Tables are much smaller because they only contain the actual register mappings
	  for a particular PMU model as opposed to a fixed size table of 320 elements. The
	  perfmon core now builds its internal representation based on this information as
	  opposed to using it directly.

	- removed extraneous locking and interrupt masking for the PMU interrupt handler

	- split kernel perfmon headers files based on functionality

	- added experimental support for smp_call_single() on i386. If the implementation
	  is satisfactory, I'll push it as a separate patch to lkml.

There was not update to the MIPS specific patch. As such it is currently broken and
cannot be used with the new libpfm.

The new version of the library, libpfm, includes the following changes:

	- preliminary support for Dual-Core Itanium 2 (Montecito) based on
	  publicly available documentation

	- update to match 2.6.16-rc5 kernel patch

	- renamed all *gen_x86_64* files to *amd_x86_64* to avoid confusion
	  with EM64T.

	- incorporated AMD provided event table for Opteron (Ray Bryant)


The two packages can be downloaded from the SourceForge website at:

	http://www.sf.net/projects/perfmon2

Enjoy,

-- 
-Stephane

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758252AbWK0OjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758252AbWK0OjW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 09:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758249AbWK0OjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 09:39:22 -0500
Received: from madara.hpl.hp.com ([192.6.19.124]:19666 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S1758248AbWK0OjU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 09:39:20 -0500
Date: Mon, 27 Nov 2006 06:37:05 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: perfmon@napali.hpl.hp.com
Cc: linux-ia64@vger.kernel.org, perfctr-devel@lists.sourceforge.net,
       oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: 2.6.19-rc6-git10 new perfmon code base + libpfm + pfmon
Message-ID: <20061127143705.GC24980@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have released another version of the perfmon new code base package.
This version of the kernel patch is relative to 2.6.19-rc6-git10.

This is a major update because it completes the changes requested 
during the code review on LKML. As a consequence, the kernel interface
is NOT backward compatible with previous v2.2 versions. This release has
the v2.3 version number. Backward compatibility with v2.0 is maintained
on Itanium processors.

The kernel patch is split between infrastructure work and perfmon2 proper.
The infrastructure contains the following changes which will be integrated
into mainline before perfmon2 is. Those changes should appear in 2.6.20.
They are provided in the base.diff file.

The infrastructure changes include:
	- x86_64: fix idle_notifier to cover all interrupts entry/exit for idle thread
	- i386  : add idle notifier (copy of x86_64 notifier)
	- ia64  : idle notifier (copy of x86_64 notifier)
	- i386  : add X86_FEATURE_ceforge.net, linux-kernel@vger.kernel.orgq,X86_FEATURE_PEBS to cpufeature.h
	- x86_64:  add X86_FEATURE_BTS,X86_FEATURE_PEBS to cpufeature.h
	- i386  : add PMU related MSR definitions to msr.h
	- x86_64: NMI watchdog uses PERFCTR1 to allow PEBS on Intel Core (requires PERFCTR0)
	- all   : remove unused carta_random32.h


The perfmon2 kernel changes the release to v2.3 and includes the following changes:
	- updated to 2.6.19-rc6-git10 
	- sampling format identified with clear text string, not UUID anymore
	- pfm_create_context() returns file descriptor
	- sampling format name passed as argument
	- struct pfarg_ctx_t simplified
	- using random32() instead of carta_random32() (now obsolete)
	- in struct pfarg_pmd, reg_random_seed is obsolete
	- added support for Intel Core processors (Core 2 Duo)
	- unified PEBS support between P4 and Intel Core
	- fix bugs with munmap() of sampling buffer
	- changed sysfs to handle new naming for sampling formats
	- change rsvd_mask logic in PMU description modules
	- make idle notifier registration lazy (only when needed)
	- rewritten NMI integration using die_notifier()
	- NMI watchdog support and auto-detection for AMD K8, Intel Core
	- fix potential issues with locking/irq masking using LockDep checker
	- cleaned MIPS PMU description table setup
	- various MIPS bugs fixes (Phil Mucci, Manoj Ekbote)
	- various PowerPC updates  include PPC32 description table (Phil Mucci)

Due to problems with the git10 tree, the MIPS kernel does not compile regardless of
perfmon2. A new patch will be generated once this problem is removed.

I have also released a new libpfm, libpfm-3.2-061127, with lots of
changes. Here are some of the most important ones:

	- added support for Intel Core (Core 2 Duo)
	- updated all example, header files to perfmon v2.3
	- updated man pages
	- Intel Core PEBS example
	- fixed rtop on 32-bit platforms
	- various MIPS updates (Phil Mucci)
	- big-endian support for MIPS
	- various Makefile improvements

Also a new version of pfmon, pfmon-3.2-061127, with a lot
of changes as well:
	- updated to perfmon v2.3 interface
	- support for Intel Core processors (Core 2 Duo)
	- support for Intel Core PEBS as a sampling format
	- complete rewrite of system-wide  core loops to avoid race conditions with signals
	- added --print-interval to print intermediate deltas in system-wide mode
	- better handling of perfmon errors
	- corrected Montecito checks for L2D_CANCEL events
	- factorized 'detailed' sampling format for all arch
	- inst-hist default formats for all arch
	- corrected sampling buffer auto-sizing based on resource limit constraints
	- updated online documentation
	
This version of pfmon requires libpfm-3.2-061127.

You can get a more detailed log of changes the the CVS tree.

You can grab the new packages at our web site:

	 http://perfmon2.sf.net

Enjoy,

PS: I will post a kernel patch to LKML and a diffstat on the perfmon mailing list.
-- 

-Stephane

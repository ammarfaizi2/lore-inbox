Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964824AbVKRRBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbVKRRBT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 12:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbVKRRBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 12:01:19 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:27054 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S964815AbVKRRBS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 12:01:18 -0500
Date: Fri, 18 Nov 2005 09:00:55 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: perfctr-devel@lists.sourceforge.net
Cc: perfmon@napali.hpl.hp.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: 2.6.15-rc1-git6 perfmon new code base package available
Message-ID: <20051118170055.GF30262@frankl.hpl.hp.com>
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

I have released a new version of the perfmon base package.
This release is relative to 2.6.15-rc1-git6. We are now
following Linus' GIT snapshots rather than Andrew's -mm tree.

I have also updated the library, libpfm-3.2, to match the kernel
level changes.

Kernel-package features:
------------------------

        - major update to the EM64T support. It is now up to the
          level of the 32-bit P4/Xeon support

        - support for EM64T PEBS sampling

        - EM64T/P4/Xeon ESCR.active_thread now under user's control

        - fixed broken PMU context switch code for UP kernels

        - implemented PFM_REGFL_NO_EMUL64 (disable counter 64-bit
	  virtualization) flag on EM64T/P4/Xeon to support PEBS sampling.

        - restored restriction which mandates that a PMD cannot be read
          before the user has declared it is using it via pfm_write_pmcs()
          or reg_smpl_pmds[]. This is in official 2.6 but got dropped by
          mistake in the new code base.

        - added pt_regs as an argument to the sampling format module handler
          callback

	- lots of cleanups and bug fixes

The patch has been tested on Pentium M, Xeon 32-bit, AMD X86-64, Xeon 64-bit
and on Itanium2. The code is known to compile for PPC and MIPS but I could
not test it.

For MIPS, the patch is still relative to 2.6.14-rc2 from www.linux-mips.org
GIT tree as they still maintain a separate tree. To simplify
the setup, the entire MIPS patch is included in the -mips file.
You do not need to apply the common patch.

For libpfm-3.2, the P4/Xeon (32 and 64 bits) PEBS examples have
been updated. Make sure you look at them as there were some
important changes on how registers must be setup, especially
with the PFM_REGFL_NO_EMUL64 flag and the active_thread settings.
PEBS does not work when HyperThreading is enabled. Among
the other changes, I have added a few more events for P6
and AMD X86-64. If you want full coverage, please contribute!

Somehow the project's summary page at SourceForge appears
broken. Until I find out what is wrong, you can grab the packages
directly from the download page at:
 
	http://sf.net/project/showfiles.php?group_id=144822

You must download:
     - 2.6.15-rc1-git6
     - libpfm-3.2-051118

Enjoy,

-- 
-Stephane

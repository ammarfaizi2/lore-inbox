Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266533AbUGVPPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266533AbUGVPPe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 11:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266124AbUGVPP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 11:15:27 -0400
Received: from cfcafwp.SGI.COM ([192.48.179.6]:48659 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S266533AbUGVPOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 11:14:50 -0400
From: Pat Gefre <pfg@sgi.com>
Message-Id: <200407221514.i6MFEVag084696@fsgi900.americas.sgi.com>
Subject: Altix I/O code re-org
To: linux-ia64@vger.kernel.org
Date: Thu, 22 Jul 2004 10:14:31 -0500 (CDT)
Cc: hch@infradead.org, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have redone the I/O layer in the Altix code.

We are posting this code for review before submitting for
inclusion in the 2.5 tree.

The code can be seen at:
ftp://oss.sgi.com/projects/sn2/sn2-update/

The general changes are:
o added new hardware support
o ran all code thru Lindent
o code cleanup (typedefs, include files, etc.)
o simplified the directory structure (all files under arch/ia64/sn/io/
  are deleted, new files are under arch/ia64/sn/ioif/)
o code size reduced by >50%
o major reorg of the code itself
o copyright updates



The code is organized in the following manner:

diffs_of_common_c_files - this has the diffs of 'C' files that were changed
                          but not renamed.
diffs_of_common_h_files - this has the diffs of include files that were changed
                          but not renamed.
diffs_of_renamed_files  - this has the diffs of all files that were renamed.


source_code.tar.gz      - tarball of new source files.
Source_code_tree/       - directory of new source files.

The diffstats are:

=> diffstat diffs_of_common_c_files
 irq.c   |  438 ++++++++++++++++++++++++++++++----------------------------------
 setup.c |  296 ++++++++++++++++++++-----------------------
 2 files changed, 349 insertions(+), 385 deletions(-)

=> diffstat diffs_of_common_h_files
 addrs.h           |   23 
 arch.h            |    5 
 geo.h             |   31 -
 hcl.h             |   52 -
 intr.h            |    2 
 io.h              |    2 
 iograph.h         |   26 
 klconfig.h        |   34 -
 ksys/l1.h         |    4 
 module.h          |   55 -
 nodepda.h         |   60 -
 pci/pic.h         |  725 ++++++++++++++---------
 pda.h             |    3 
 router.h          |    7 
 sgi.h             |   23 
 sn2/addrs.h       |   58 +
 sn2/arch.h        |    3 
 sn2/geo.h         |    7 
 sn2/intr.h        |   26 
 sn2/shub.h        |    3 
 sn2/shubio.h      | 1669 ++++++++++++++++++++++++------------------------------
 sn_cpuid.h        |    1 
 sn_sal.h          |   59 -
 sndrv.h           |    1 
 types.h           |    2 
 xtalk/xbow.h      |  456 +-------------
 xtalk/xbow_info.h |    2 
 27 files changed, 1479 insertions(+), 1860 deletions(-)

=> diffstat diffs_of_renamed_files
 bte_error.c                                         |   53 
 iomv.c                                              |    2 
 klconflib.c                                         |  545 +----
 local.tree/arch/ia64/sn/ioif/pci/pcibr_err.c        | 1870 --------------------
 local.tree/arch/ia64/sn/ioif/topology/shubmon_dvr.c |  171 -
 pci_dma.c                                           |  375 +---
 pcibr_ate.c                                         |  339 ++-
 pcibr_intr.c                                        |  710 -------
 8 files changed, 586 insertions(+), 3479 deletions(-)

-- 

Patrick Gefre
Silicon Graphics, Inc.                     (E-Mail)  pfg@sgi.com
2750 Blue Water Rd                         (Voice)   (651) 683-3127
Eagan, MN 55121-1400                       (FAX)     (651) 683-3054

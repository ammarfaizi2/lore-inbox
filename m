Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965083AbWD0KpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965083AbWD0KpO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 06:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965088AbWD0KpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 06:45:14 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:48581 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP id S965083AbWD0KpM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 06:45:12 -0400
Message-ID: <4450B378.9000705@de.ibm.com>
Date: Thu, 27 Apr 2006 14:05:12 +0200
From: Heiko J Schick <schihei@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, openib-general@openib.org,
       linuxppc-dev@ozlabs.org, Marcus Eder <MEDER@de.ibm.com>,
       Christoph Raisch <RAISCH@de.ibm.com>,
       Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, schickhj@de.ibm.com
Subject: [PATCH 00/16] ehca: IBM eHCA InfiniBand Device Driver
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

many thanks for your comments. They are very helpful for us. All
17 patches have to be applied, otherwise the driver won't compile.

We added an initial version to support large pages. At the moment
we verified it only for 4K pages, because we're struggling to get
a Linux kernel with 64K pages running properly on our system.

We would appreciate for any comments and feedbacks.

Signed-off-by: Heiko J Schick <schickhj@de.ibm.com>
Changelog-by:  Heiko J Schick <schickhj@de.ibm.com>

Changelog:

Differences to PatchSet http://openib.org/pipermail/openib-general/2006-March/018144.html
Differences to PatchSet http://openib.org/pipermail/openib-general/2006-March/017412.html

- Renamed module param tracelevel to debug_level
- Reformated MODULE_PARAM_DESC in ehca_main.c
- Removed EHCA_CACHE_CREATE / EHCA_CACHE_DESTROY macros
- Renamed debug_level sysfs entry to debug_mask
- debug_mask sysfs entry has now only one value
- Added LARGEPAGE support (EXPERIMENTAL)
- Changed locking for internal IDRs (for CQs and QPs)
- ehca_poll_eqs uses now mod_timer instead of add_timer
- Removed compile warnings in libehca because of missing header files
- Added function ibv_read_sysfs_file to be compatible with libibverbs 1.0
- Removed libsysfs usage in libehca
- Rename HCALLs defines from StudlyCaps to SHUTTING_CAPS
- Improve scaling code for completion queue
- Remove use of struct ib_gid in firmware bridge
- Improve coding style in firmware bridge
- Rework static rate encoding
- Removed ehca_kv_to_g()
- Splitted remaining shared kernel/userspace files
- Removed defines in user space to reuse kernel files
- Removed struct ehca_qp_core, ehca_cq_core
- Removed all trailing blanks found
- Fixed sparse warnings
- Improved eq SMP scaling
- Added fork access protection to queue entries

  Kconfig                |    6
  Makefile               |   29
  ehca_av.c              |  309 ++++++
  ehca_classes.h         |  314 ++++++
  ehca_classes_pSeries.h |  253 ++++
  ehca_cq.c              |  445 ++++++++
  ehca_eq.c              |  225 ++++
  ehca_hca.c             |  286 +++++
  ehca_irq.c             |  712 ++++++++++++++
  ehca_irq.h             |   79 +
  ehca_iverbs.h          |  183 +++
  ehca_kernel.h          |  162 +++
  ehca_main.c            |  973 +++++++++++++++++++
  ehca_mcast.c           |  198 +++
  ehca_mrmw.c            | 2492 +++++++++++++++++++++++++++++++++++++++++++++++++
  ehca_mrmw.h            |  145 ++
  ehca_pd.c              |  122 ++
  ehca_qes.h             |  278 +++++
  ehca_qp.c              | 1592 +++++++++++++++++++++++++++++++
  ehca_reqs.c            |  685 +++++++++++++
  ehca_sqp.c             |  126 ++
  ehca_tools.h           |  387 +++++++
  ehca_uverbs.c          |  409 ++++++++
  hcp_if.c               | 2028 +++++++++++++++++++++++++++++++++++++++
  hcp_if.h               |  398 +++++++
  hcp_phyp.c             |   97 +
  hcp_phyp.h             |   97 +
  hipz_fns.h             |   73 +
  hipz_fns_core.h        |  126 ++
  hipz_hw.h              |  398 +++++++
  ipz_pt_fn.c            |  184 +++
  ipz_pt_fn.h            |  258 +++++
  32 files changed, 14069 insertions(+)




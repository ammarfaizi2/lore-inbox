Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937027AbWLEWtl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937027AbWLEWtl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 17:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937030AbWLEWtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 17:49:41 -0500
Received: from hancock.steeleye.com ([71.30.118.248]:57090 "EHLO
	hancock.sc.steeleye.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S937026AbWLEWtj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 17:49:39 -0500
Subject: [GIT PATCH] scsi updates for 2.6.19
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 05 Dec 2006 16:49:33 -0600
Message-Id: <1165358973.2785.33.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is quite a mixed bag.  The usual driver updates, plus asynchronous
scanning and the new target infrastructure.

The patch is available here:

master.kernel.org:/pub/scm/linux/kernel/git/jejb/scsi-misc-2.6.git

the shortlog is:

Adrian Bunk:
       ipr: Make ipr_ioctl static
       megaraid_sas: make 2 functions static
       qla2xxx: make some functions static

Alan Stern:
       Reduce polling in sd.c

Andrew Morton:
       tgt: fix undefined flush_dcache_page() problem
       ips: fix soft lockup during reset initialization
       revert "[SCSI] ips soft lockup during reset/initialization"

Andrew Vasquez:
       qla2xxx: add asynchronous scsi scanning support.
       qla2xxx: defer topology discovery to DPC thread during initialization.

Brian King:
       ipr: Driver version 2.3.0
       ipr: Reduce default error log size
       ipr: Add support for logging SAS fabric errors
       ipr: Remove debug trace points from dump code
       ipr: Remove ipr_scsi_timed_out
       ipr: Set default ipr Kconfig values
       ipr: PCI IDs for new SAS adapters
       ipr: Stop issuing cancel all to disk arrays
       ipr: SATA reset - wait for host reset completion

Christoph Hellwig:
       kill scsi_assign_lock
       untangle scsi_prep_fn
       use one-element sg list in scsi_send_eh_cmnd

Darrick J. Wong:
      aic94xx: delete ascb timers when freeing queues
      aic94xx: handle REQ_DEVICE_RESET
       aic94xx: handle REQ_TASK_ABORT
       libsas: add sas_abort_task
       libsas: modify error handler to use scsi_eh_* functions

David C Somayajulu:
       qla4xxx: fix for timing issue for nvram accesses.
       qla4xxx: add support for qla4032
      qla4xxx: bug fix: driver hardware semaphore needs to be grabbed before soft reset

Ed Lin:
       stex: version update
       stex: change wait loop code
       stex: add new device type support
       stex: update device id info
       stex: adjust default queue length
       stex: add value check in hard reset routine
       stex: fix controller_info command handling
       stex: fix biosparam calculation

FUJITA Tomonori:
       scsi tgt: IBM eServer i/pSeries virtual SCSI target driver
       scsi tgt: SCSI RDMA Protocol library functions
       scsi-ml: Makefile and Kconfig changes for tgt
       scsi tgt: scsi target user and kernel communication interface
       scsi tgt: scsi target lib functionality
       export scsi-ml functions needed by tgt_scsi_lib and its LLDs

Hannes Reinecke:
       block: convert jiffies to msecs in scsi_ioctl()

Henne:
       scsi: t128 scsi_cmnd convertion

Ingo Molnar:
       fix module unload induced compile warning

James Bottomley:
       libsas: better error handling in sas_expander.c
       53c700: brown paper bag fix for auto request sense
       aic94xx: fix pointer to integer conversion warning

James Smart:
       lpfc 8.1.11 : Change version number to 8.1.11
       lpfc 8.1.11 : Misc Fixes
       lpfc 8.1.11 : Add soft_wwnn sysfs attribute, rename soft_wwn_enable
       lpfc 8.1.11 : Removed decoding of PCI Subsystem Id
       lpfc 8.1.11 : Add MSI (Message Signalled Interrupts) support
       lpfc 8.1.11 : Adjust LOG_FCP logging
       lpfc 8.1.11 : Fix Memory leaks
       lpfc 8.1.11 : Fix lpfc_multi_ring_support
       lpfc 8.1.11 : Discovery Fixes

Jeff Garzik:
       megaraid: fix MMIO casts
       minor bug fixes and cleanups
       SCSI/aha1740: handle SCSI API errors

Kai Makisara:
       st: log message changes

Luben Tuikov:
       sd: clearer output of disk cache state

Mark Haverkamp:
       aacraid: Driver version update
       aacraid: Abort management FIBs
       aacraid: Detect Blinkled at startup

Matthew Wilcox:
       Make scsi_scan_host work for drivers which find their own targets
       fix missing check for no scanning
       Add Kconfig option for asynchronous SCSI scanning
       Add ability to scan scsi busses asynchronously

Randy Dunlap:
       qla2xxx: use NULL instead of 0
       initio: fix section mismatches with HOTPLUG=n

Salyzyn, Mark:
       aic79xx: Add ASC-29320LPE ids to driver


and the diffstat:

 Documentation/kernel-parameters.txt     |    5 
 Documentation/scsi/scsi_mid_low_api.txt |   31 -
 block/scsi_ioctl.c                      |    2 
 drivers/scsi/53c700.c                   |    7 
 drivers/scsi/BusLogic.c                 |   12 
 drivers/scsi/Kconfig                    |   59 +
 drivers/scsi/Makefile                   |    7 
 drivers/scsi/NCR53c406a.c               |    5 
 drivers/scsi/aacraid/aacraid.h          |    4 
 drivers/scsi/aacraid/commsup.c          |   23 
 drivers/scsi/aha1740.c                  |   10 
 drivers/scsi/aic7xxx/aic79xx_osm_pci.c  |    1 
 drivers/scsi/aic7xxx/aic79xx_pci.c      |    8 
 drivers/scsi/aic7xxx/aic79xx_pci.h      |    1 
 drivers/scsi/aic94xx/aic94xx_init.c     |    9 
 drivers/scsi/aic94xx/aic94xx_scb.c      |  120 +++-
 drivers/scsi/fd_mcs.c                   |    2 
 drivers/scsi/hosts.c                    |    8 
 drivers/scsi/ibmvscsi/Makefile          |    2 
 drivers/scsi/ibmvscsi/ibmvstgt.c        |  958 ++++++++++++++++++++++++++++++++
 drivers/scsi/initio.c                   |    2 
 drivers/scsi/ipr.c                      |  313 ++++++++--
 drivers/scsi/ipr.h                      |   83 ++
 drivers/scsi/ips.c                      |   28 
 drivers/scsi/ips.h                      |    9 
 drivers/scsi/libsas/sas_expander.c      |   36 -
 drivers/scsi/libsas/sas_init.c          |    4 
 drivers/scsi/libsas/sas_scsi_host.c     |   90 ++-
 drivers/scsi/libsrp.c                   |  441 ++++++++++++++
 drivers/scsi/lpfc/lpfc.h                |    6 
 drivers/scsi/lpfc/lpfc_attr.c           |  118 +++
 drivers/scsi/lpfc/lpfc_ct.c             |   24 
 drivers/scsi/lpfc/lpfc_els.c            |   34 -
 drivers/scsi/lpfc/lpfc_hbadisc.c        |  229 +------
 drivers/scsi/lpfc/lpfc_hw.h             |   35 -
 drivers/scsi/lpfc/lpfc_init.c           |  136 +---
 drivers/scsi/lpfc/lpfc_logmsg.h         |    2 
 drivers/scsi/lpfc/lpfc_nportdisc.c      |    9 
 drivers/scsi/lpfc/lpfc_scsi.c           |   56 +
 drivers/scsi/lpfc/lpfc_sli.c            |   42 +
 drivers/scsi/lpfc/lpfc_sli.h            |    2 
 drivers/scsi/lpfc/lpfc_version.h        |    2 
 drivers/scsi/megaraid.c                 |   13 
 drivers/scsi/megaraid.h                 |    3 
 drivers/scsi/megaraid/megaraid_sas.c    |    4 
 drivers/scsi/ncr53c8xx.c                |   19 
 drivers/scsi/qla2xxx/qla_attr.c         |    2 
 drivers/scsi/qla2xxx/qla_init.c         |   94 ---
 drivers/scsi/qla2xxx/qla_os.c           |   66 +-
 drivers/scsi/qla2xxx/qla_sup.c          |    8 
 drivers/scsi/qla4xxx/ql4_dbg.c          |    4 
 drivers/scsi/qla4xxx/ql4_def.h          |  105 +--
 drivers/scsi/qla4xxx/ql4_fw.h           |    7 
 drivers/scsi/qla4xxx/ql4_glbl.h         |    3 
 drivers/scsi/qla4xxx/ql4_init.c         |   47 -
 drivers/scsi/qla4xxx/ql4_inline.h       |    4 
 drivers/scsi/qla4xxx/ql4_iocb.c         |    6 
 drivers/scsi/qla4xxx/ql4_isr.c          |    1 
 drivers/scsi/qla4xxx/ql4_nvram.c        |   70 +-
 drivers/scsi/qla4xxx/ql4_nvram.h        |    4 
 drivers/scsi/qla4xxx/ql4_os.c           |  117 ---
 drivers/scsi/qla4xxx/ql4_version.h      |    7 
 drivers/scsi/scsi.c                     |   45 -
 drivers/scsi/scsi_error.c               |   33 -
 drivers/scsi/scsi_lib.c                 |  346 ++++++-----
 drivers/scsi/scsi_priv.h                |    3 
 drivers/scsi/scsi_scan.c                |  225 +++++++
 drivers/scsi/scsi_tgt_if.c              |  352 +++++++++++
 drivers/scsi/scsi_tgt_lib.c             |  742 ++++++++++++++++++++++++
 drivers/scsi/scsi_tgt_priv.h            |   25 
 drivers/scsi/scsi_wait_scan.c           |   31 +
 drivers/scsi/sd.c                       |   29 
 drivers/scsi/st.c                       |   16 
 drivers/scsi/stex.c                     |  130 ++--
 drivers/scsi/t128.h                     |   39 -
 include/scsi/libsas.h                   |   14 
 include/scsi/libsrp.h                   |   77 ++
 include/scsi/scsi_cmnd.h                |   10 
 include/scsi/scsi_device.h              |   30 -
 include/scsi/scsi_host.h                |   69 ++
 include/scsi/scsi_tgt.h                 |   19 
 include/scsi/scsi_tgt_if.h              |   90 +++
 include/scsi/scsi_transport_sas.h       |    2 
 83 files changed, 4760 insertions(+), 1126 deletions(-)

James



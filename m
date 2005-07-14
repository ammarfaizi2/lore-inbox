Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261621AbVGNRaM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbVGNRaM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 13:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbVGNRaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 13:30:12 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:28857 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261607AbVGNR24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 13:28:56 -0400
Subject: [GIT PATCH] SCSI updates for 2.6.13-rc3
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 14 Jul 2005 13:28:43 -0400
Message-Id: <1121362124.5117.23.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is actually the accumulation of everything we've been saving for
2.6.12, but I was away for a bit and missed 2.6.12 when it came out ...

The patch is available from

http://www.kernel.org/pub/scm/linux/kernel/git/jejb/scsi-for-
linus-2.6.git/

The short changelog is:

Andrew Morton:
  o dpt_i2o warning fix
  o aic79xx: ahd_linux_dev_reset() cleanup

Andrew Vasquez:
  o qla2xxx: Cleanup FC remote port registration
  o qla2xxx: Consolidate ISP24xx chip reset logic
  o qla2xxx: Add firmware version number to qla24xx_fw_version_str()
  o qla2xxx: Update version number to 8.01.00b5-k
  o qla2xxx: Correct maximum supported lun and target-id definitions
  o qla2xxx: Update copyright banner
  o qla2xxx: Firmware updates
  o qla2xxx: Code scrubbing
  o qla2xxx: NVRAM id-list updates
  o qla2xxx: Add OS initialization codes for ISP24xx recognition
  o qla2xxx: Add ISP24xx initialization routines
  o qla2xxx: Add ISP24xx ISR routines
  o qla2xxx: Add ISP24xx IOCB manipulation routines
  o qla2xxx: Add ISP24xx flash-manipulation routines
  o qla2xxx: Add MBX command routines for ISP24xx support
  o qla2xxx: Generalize SNS generic-services routines
  o qla2xxx: Add ISP24xx diagnostic routines
  o qla2xxx: Add ISP24xx definitions
  o qla2xxx: Add pci ids for new ISP types
  o qla2xxx: Factor-out ISP specific functions to method-based call tables

Christoph Hellwig:
  o aic7xxx: remove ahc_tailq
  o aic7xxx: sane pci probing
  o ifdef out broken fc4 EH code
  o use list_for_each_entry_safe in scsi_error.c
  o remove scsi_eh_eflags_ macros
  o remove scsi_cmnd->state
  o remove scsi_cmnd->owner
  o remove scsi_cmnd->abort_reason
  o remove scsi_cmnd.eh_state
  o remove scsi_set_device

Eric Moore:
  o mptfusion - convert to new change_queue_depth API

James Bottomley:
  o fix function prototype warning
  o SPI transport class, don't negotiate options not supported
  o add TYPE_RBC to our type table
  o aic7xxx: fix boot hang with Fujitsu drives
  o aic7xxx: correct target valid check in aic7xxx_proc.c
  o megaraid: fix compilation after eh locking changes

James Smart:
  o add int_to_scsilun() function
  o lpfc: Change version to 8.0.29
  o lpfc: Update copyright notices
  o lpfc: Remove $Id$ keyword strings
  o lpfc: Fix ADISC completion incorrectly putting initiators on mapped list
  o lpfc: Add completion handler to the abort iocbs
  o lpfc: Fix LS_RJT never sent by lpfc_els_unsol_event()
  o lpfc: Add LP6000 PCI ID
  o lpfc: Set max_sectors in host template
  o lpfc: Fix error loading on sparc
  o lpfc: Fixes in mbox_timeout_handler
  o Fix issue where all hosts log nodev message for other initiators
  o lpfc: hgp/pgp cleanups

Kenneth W. Chen:
  o Redundant this_count check in sd_init_command()
  o Redundant memset in scsi_alloc_sgtable

Linda Xie:
  o IBM VSCSI Client: sending client info to server

Mark Haverkamp:
  o aacraid: Fix sgmap error
  o aacraid: New products patch

Nishanth Aravamudan:
  o scsi/qla1280: replace schedule_timeout() with ssleep()


And the diffstat (sorry qla fw update again):

 Documentation/scsi/scsi_mid_low_api.txt |   15 
 drivers/fc4/fc.c                        |    6 
 drivers/message/fusion/mptfc.c          |   19 
 drivers/message/fusion/mptscsih.c       |   47 
 drivers/message/fusion/mptscsih.h       |    2 
 drivers/message/fusion/mptspi.c         |   19 
 drivers/scsi/aacraid/README             |    8 
 drivers/scsi/aacraid/TODO               |    2 
 drivers/scsi/aacraid/aachba.c           |   44 
 drivers/scsi/aacraid/aacraid.h          |   24 
 drivers/scsi/aacraid/commctrl.c         |    2 
 drivers/scsi/aacraid/linit.c            |   81 
 drivers/scsi/advansys.c                 |    6 
 drivers/scsi/aic7xxx/aic7770.c          |    9 
 drivers/scsi/aic7xxx/aic7770_osm.c      |    3 
 drivers/scsi/aic7xxx/aic79xx_osm.c      |    4 
 drivers/scsi/aic7xxx/aic7xxx.h          |    7 
 drivers/scsi/aic7xxx/aic7xxx_core.c     |   59 
 drivers/scsi/aic7xxx/aic7xxx_osm.c      |  223 
 drivers/scsi/aic7xxx/aic7xxx_osm.h      |   29 
 drivers/scsi/aic7xxx/aic7xxx_osm_pci.c  |    7 
 drivers/scsi/aic7xxx/aic7xxx_pci.c      |    8 
 drivers/scsi/aic7xxx/aic7xxx_proc.c     |    4 
 drivers/scsi/aic7xxx_old.c              |    1 
 drivers/scsi/cpqfcTSinit.c              |    1 
 drivers/scsi/dpt_i2o.c                  |    6 
 drivers/scsi/eata.c                     |   10 
 drivers/scsi/eata_pio.c                 |    4 
 drivers/scsi/fdomain.c                  |    1 
 drivers/scsi/gdth.c                     |    4 
 drivers/scsi/hosts.c                    |    5 
 drivers/scsi/ibmvscsi/ibmvscsi.c        |    4 
 drivers/scsi/ibmvscsi/rpa_vscsi.c       |   51 
 drivers/scsi/ibmvscsi/srp.h             |    2 
 drivers/scsi/ips.h                      |    2 
 drivers/scsi/libata-core.c              |    4 
 drivers/scsi/lpfc/Makefile              |   28 
 drivers/scsi/lpfc/lpfc.h                |   31 
 drivers/scsi/lpfc/lpfc_attr.c           |   31 
 drivers/scsi/lpfc/lpfc_compat.h         |   28 
 drivers/scsi/lpfc/lpfc_crtn.h           |   33 
 drivers/scsi/lpfc/lpfc_ct.c             |   28 
 drivers/scsi/lpfc/lpfc_disc.h           |   30 
 drivers/scsi/lpfc/lpfc_els.c            |   47 
 drivers/scsi/lpfc/lpfc_hbadisc.c        |   55 
 drivers/scsi/lpfc/lpfc_hw.h             |   50 
 drivers/scsi/lpfc/lpfc_init.c           |   40 
 drivers/scsi/lpfc/lpfc_logmsg.h         |   30 
 drivers/scsi/lpfc/lpfc_mbox.c           |   38 
 drivers/scsi/lpfc/lpfc_mem.c            |   31 
 drivers/scsi/lpfc/lpfc_nportdisc.c      |   40 
 drivers/scsi/lpfc/lpfc_scsi.c           |   33 
 drivers/scsi/lpfc/lpfc_scsi.h           |   30 
 drivers/scsi/lpfc/lpfc_sli.c            |  125 
 drivers/scsi/lpfc/lpfc_sli.h            |   30 
 drivers/scsi/lpfc/lpfc_version.h        |   33 
 drivers/scsi/megaraid.c                 |   47 
 drivers/scsi/megaraid.h                 |    2 
 drivers/scsi/megaraid/megaraid_mbox.c   |    1 
 drivers/scsi/ncr53c8xx.c                |    1 
 drivers/scsi/nsp32.c                    |    4 
 drivers/scsi/qla1280.c                  |    2 
 drivers/scsi/qla2xxx/Makefile           |    3 
 drivers/scsi/qla2xxx/ql2100.c           |    2 
 drivers/scsi/qla2xxx/ql2100_fw.c        | 3206 +++---
 drivers/scsi/qla2xxx/ql2200.c           |    2 
 drivers/scsi/qla2xxx/ql2200_fw.c        |10484 +++++++++++----------
 drivers/scsi/qla2xxx/ql2300.c           |    2 
 drivers/scsi/qla2xxx/ql2300_fw.c        |14387 +++++++++++++++---------------
 drivers/scsi/qla2xxx/ql2322.c           |    2 
 drivers/scsi/qla2xxx/ql2322_fw.c        |15252 ++++++++++++++++----------------
 drivers/scsi/qla2xxx/ql6312.c           |    2 
 drivers/scsi/qla2xxx/ql6312_fw.c        |12649 +++++++++++++-------------
 drivers/scsi/qla2xxx/qla_attr.c         |   86 
 drivers/scsi/qla2xxx/qla_dbg.c          | 1102 ++
 drivers/scsi/qla2xxx/qla_dbg.h          |   34 
 drivers/scsi/qla2xxx/qla_def.h          |  389 
 drivers/scsi/qla2xxx/qla_devtbl.h       |   46 
 drivers/scsi/qla2xxx/qla_fw.h           | 1073 ++
 drivers/scsi/qla2xxx/qla_gbl.h          |   68 
 drivers/scsi/qla2xxx/qla_gs.c           |  192 
 drivers/scsi/qla2xxx/qla_init.c         | 1315 ++
 drivers/scsi/qla2xxx/qla_inline.h       |  141 
 drivers/scsi/qla2xxx/qla_iocb.c         |  331 
 drivers/scsi/qla2xxx/qla_isr.c          |  622 -
 drivers/scsi/qla2xxx/qla_mbx.c          | 1006 +-
 drivers/scsi/qla2xxx/qla_os.c           |  619 -
 drivers/scsi/qla2xxx/qla_rscn.c         |   34 
 drivers/scsi/qla2xxx/qla_settings.h     |   27 
 drivers/scsi/qla2xxx/qla_sup.c          |  558 +
 drivers/scsi/qla2xxx/qla_version.h      |   10 
 drivers/scsi/qlogicfc.c                 |    1 
 drivers/scsi/qlogicisp.c                |    1 
 drivers/scsi/scsi.c                     |   14 
 drivers/scsi/scsi_error.c               |  104 
 drivers/scsi/scsi_lib.c                 |   11 
 drivers/scsi/scsi_priv.h                |   20 
 drivers/scsi/scsi_scan.c                |   32 
 drivers/scsi/scsi_transport_spi.c       |   13 
 drivers/scsi/sd.c                       |    3 
 drivers/scsi/u14-34f.c                  |    9 
 include/linux/pci_ids.h                 |    9 
 include/scsi/scsi.h                     |    4 
 include/scsi/scsi_cmnd.h                |    5 
 include/scsi/scsi_device.h              |    3 
 include/scsi/scsi_host.h                |    6 
 106 files changed, 34991 insertions(+), 30459 deletions(-)

James


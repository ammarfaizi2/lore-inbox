Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030341AbWGTPQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030341AbWGTPQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 11:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030335AbWGTPQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 11:16:58 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:48549 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1030333AbWGTPQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 11:16:57 -0400
Subject: [GIT PATCH] SCSI bug fixes and updates for 2.6.18-rc2
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 20 Jul 2006 11:16:44 -0400
Message-Id: <1153408604.4754.7.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is mainly bug fixes, but also a few driver updates (which are also
primarily bug fixes).  The main non bug fix change is that the final set
of updates to remove some obsolete command fields from the driver (which
is the end point begun in several prior sets of changes) is in this.

The patch is here:

master.kernel.org:/pub/scm/linux/kernel/git/jejb/scsi-rc-fixes-2.6.git

The short changelog is:

Adrian Bunk:
  o aic79xx: make ahd_done_with_status() static

Christoph Hellwig:
  o More buffer->request_buffer changes
  o hide EH backup data outside the scsi_cmnd
  o aha152x: stop poking at saved scsi_cmnd members

Dave C Boutcher:
  o ibmvscsi: handle inactive SCSI target during probe
  o ibmvscsi: allocate lpevents for ibmvscsi on iseries

Douglas Gilbert:
  o update additional sense codes and some opcode names

Eric Moore:
  o mptfusion: bump version to 3.04.01
  o mptfusion: misc fix's
  o mptfusion: firmware download boot fix's
  o mptfusion: task abort fix's
  o mptfusion: sas nexus loss support
  o mptfusion: sas loginfo update
  o mptfusion: mptctl panic when loading
  o mptfusion: sas enclosures with smart drive
  o mptsas: use unnumbered port API and remove driver porttracking

James Bottomley:
  o NCR_D700: misc fixes (section and argument ordering)
  o scsi_transport_sas: kill the use of channel
  o scsi_transport_sas: add expander backlink
  o scsi_transport_sas: add unindexed ports

James Smart:
  o lpfc 8.1.7: Change version number to 8.1.7
  o lpfc 8.1.7: Misc Fixes
  o lpfc 8.1.7: Add lpfc_sli_flush_mbox_queue() function
  o lpfc 8.1.7: Correct the wait in attachment that delays for topology discovery
  o lpfc 8.1.7: Remove depricated sysfs attribute board_online
  o lpfc 8.1.7: Adding new issue_reset sysfs attribute
  o lpfc 8.1.7: Fix panic in lpfc_sli_validate_fcp_iocb
  o lpfc 8.1.7: Consolidate dma buf cleanup into a separate function
  o lpfc 8.1.7: Correct bogus nodev_tmo message on NPort that changes its NPort Id
  o lpfc 8.1.7: Fix txcmplq related panics on heavy IO while downloading firmware
  o lpfc 8.1.7: Issue DOWN_LINK prior to INIT_LINK to work around link failure issue
  o lpfc 8.1.7: Fixed infinite retry of REG_LOGIN mailbox failed due to MBXERR_RPI_FULL
  o lpfc 8.1.7: Fix memory leak and cleanup code related to per ring lookup array
  o lpfc 8.1.7: Standardize the driver on a single define for the maximum supported targets
  o lpfc 8.1.7: Use mod_timer instead of add_timer in lpfc_els_timeout_handler

Luben Tuikov:
  o st.c: Improve sense output

Matthew Wilcox:
  o aic7[9x]xx: Remove last vestiges of reverse_scan

Randy Dunlap:
  o scsi_debug: must_check fixes

And the diffstat:

 drivers/fc4/fc.c                      |    4 
 drivers/message/fusion/Kconfig        |    2 
 drivers/message/fusion/Makefile       |    1 
 drivers/message/fusion/mptbase.c      |   99 ++++++++++------
 drivers/message/fusion/mptbase.h      |   13 --
 drivers/message/fusion/mptctl.c       |    4 
 drivers/message/fusion/mptctl.h       |    5 
 drivers/message/fusion/mptfc.c        |   14 --
 drivers/message/fusion/mptsas.c       |  109 ++++++-----------
 drivers/message/fusion/mptscsih.c     |  118 ++++++++++++++++---
 drivers/message/fusion/mptspi.c       |   10 -
 drivers/scsi/53c7xx.c                 |    8 -
 drivers/scsi/NCR53C9x.c               |    2 
 drivers/scsi/NCR_D700.c               |   14 +-
 drivers/scsi/aha152x.c                |   43 +++++-
 drivers/scsi/aic7xxx/aic79xx_core.c   |    2 
 drivers/scsi/aic7xxx/aic79xx_osm.c    |   21 ---
 drivers/scsi/aic7xxx/aic7xxx_osm.c    |    1 
 drivers/scsi/atari_NCR5380.c          |    2 
 drivers/scsi/constants.c              |  126 ++++++++++++++------
 drivers/scsi/esp.c                    |    4 
 drivers/scsi/ibmvscsi/iseries_vscsi.c |    2 
 drivers/scsi/ibmvscsi/rpa_vscsi.c     |    1 
 drivers/scsi/jazz_esp.c               |    2 
 drivers/scsi/lpfc/lpfc.h              |    9 -
 drivers/scsi/lpfc/lpfc_attr.c         |   89 ++++++++------
 drivers/scsi/lpfc/lpfc_crtn.h         |    1 
 drivers/scsi/lpfc/lpfc_els.c          |   65 +++++-----
 drivers/scsi/lpfc/lpfc_hbadisc.c      |    4 
 drivers/scsi/lpfc/lpfc_init.c         |   59 ++++++---
 drivers/scsi/lpfc/lpfc_mem.c          |    5 
 drivers/scsi/lpfc/lpfc_nportdisc.c    |   11 +
 drivers/scsi/lpfc/lpfc_scsi.c         |   64 +++++-----
 drivers/scsi/lpfc/lpfc_sli.c          |   55 +++-----
 drivers/scsi/lpfc/lpfc_sli.h          |    2 
 drivers/scsi/lpfc/lpfc_version.h      |    2 
 drivers/scsi/mac53c94.c               |    2 
 drivers/scsi/mesh.c                   |    2 
 drivers/scsi/pluto.c                  |    2 
 drivers/scsi/qlogicpti.c              |    4 
 drivers/scsi/scsi.c                   |   11 -
 drivers/scsi/scsi_debug.c             |   72 ++++++++---
 drivers/scsi/scsi_error.c             |  210 ++++++++++++++--------------------
 drivers/scsi/scsi_lib.c               |   88 --------------
 drivers/scsi/scsi_priv.h              |    1 
 drivers/scsi/scsi_transport_sas.c     |   64 +++++++++-
 drivers/scsi/sd.c                     |    3 
 drivers/scsi/seagate.c                |    2 
 drivers/scsi/sr.c                     |    5 
 drivers/scsi/st.c                     |    7 -
 drivers/scsi/sun3_NCR5380.c           |    2 
 drivers/scsi/sun3x_esp.c              |    2 
 drivers/scsi/wd33c93.c                |    2 
 include/scsi/scsi_cmnd.h              |    9 -
 include/scsi/scsi_transport_sas.h     |    7 -
 55 files changed, 796 insertions(+), 672 deletions(-)

James



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261526AbUL0SSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261526AbUL0SSP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 13:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbUL0SSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 13:18:15 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:44246 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261526AbUL0SRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 13:17:54 -0500
Subject: [BK PATCH] SCSI updates for 2.6.10
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 27 Dec 2004 12:17:37 -0600
Message-Id: <1104171457.7447.5.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a dump of everything I've had in my pending but not applicable
to -rc queue for the last few months.  There's nothing earthshattering,
but I'm afraid we have another qla2xxx firmware update making the whole
thing rather big.

The patch is available here:

bk://linux-scsi.bkbits.net/scsi-for-linus-2.6

The short changelog is:

Adrian Bunk:
  o SCSI NCR53C9x.c: some cleanups
  o SCSI mca_53c9x.c: make 2 functions static
  o SCSI ibmmca.c: make a struct static
  o remove bouncing email address of Deanna Bonds
  o SCSI aic7xxx_old.c: make a function static
  o kill scsi_syms.c

Andrew Morton:
  o iscsi_transport build fix

Andrew Vasquez:
  o ipr: PCI-X capabilities setup fix
  o qla2xxx: Update driver version
  o qla2xxx: 23xx/63xx firmware updates
  o qla2xxx: Consolidate ISP63xx support
  o qla2xxx: Code scrubbing
  o qla2xxx: ISR fixes
  o qla2xxx: Small fixes
  o qla2xxx: NVRAM id-list updates
  o qla2xxx: NVRAM updates
  o qla2xxx: Tx/Rx Sensitivity additions

Brian King:
  o ipr: Bump driver version to 2.0.12
  o ipr: whitespace fixes
  o ipr: Remove dead code
  o ipr: new RAID error
  o ipr: Allow Query Resource State adapter command to

Christoph Hellwig:
  o qla2xxx: Dead code removal
  o convert eata to pass pointers around
  o feed eata.c through Lindent

Dave Boutcher:
  o ibmvscsi: replace schedule_timeout() with msleep()

Douglas Gilbert:
  o SCSI: descriptor sense format, mid-level
  o SCSI: updates to constants.c
  o scsi_debug v 1.75

Eric Moore:
  o LSI Logic - SAS and FC PCI ID's

James Bottomley:
  o SCSI: fix compile warning in fc transport class
  o SCSI: Add FC transport host attributes
  o SCSI: update 53c700 to use the change_queue_type API
  o SCSI: add queue_type entry in sysfs
  o SCSI: convert 53c700 driver to use change_queue_depth API
  o SCSI:add change_queue_depth API to scsi host template
  o SCSI: Add FC transport host statistics
  o SCSI: Add basic infrastructure for transport host statistics
  o SCSI: Quieten the incorrect state change message
  o Rename SCSI ChangeLog to reflect its venarability
  o fixup dynamic scan aids EXPORT_SYMBOL mismerge
  o scsi:   LLDD dynamic scan aids
  o SCSI: Add missing state transition BLOCK->OFFLINE
  o SCSI: Add transport destructors
  o update the fc_transport_class to use a workqueue instead of a timeout

Jens Axboe:
  o kill locking around scsi_done()

Mark Haverkamp:
  o aacraid 2.6: Support for new cards

Mike Christie:
  o iSCSI transport class

Paul Gortmaker:
  o scsi/advansys.c fix !CONFIG_PCI

And the diffstat:

 Documentation/scsi/ChangeLog              | 2023 ----
 b/Documentation/scsi/ChangeLog.1992-1997  | 2023 ++++
 b/Documentation/scsi/scsi_mid_low_api.txt |    4 
 b/drivers/scsi/53c700.c                   |   99 
 b/drivers/scsi/53c700.h                   |   22 
 b/drivers/scsi/Kconfig                    |    8 
 b/drivers/scsi/Makefile                   |    4 
 b/drivers/scsi/NCR53C9x.c                 |   15 
 b/drivers/scsi/NCR53C9x.h                 |    1 
 b/drivers/scsi/aacraid/README             |    2 
 b/drivers/scsi/aacraid/aacraid.h          |   19 
 b/drivers/scsi/aacraid/linit.c            |  124 
 b/drivers/scsi/advansys.c                 |   10 
 b/drivers/scsi/aic7xxx_old.c              |    2 
 b/drivers/scsi/aic7xxx_old/aic7xxx_proc.c |    2 
 b/drivers/scsi/constants.c                |  926 +
 b/drivers/scsi/dpt/dpti_ioctl.h           |    1 
 b/drivers/scsi/dpt_i2o.c                  |    1 
 b/drivers/scsi/dpti.h                     |    1 
 b/drivers/scsi/eata.c                     | 3369 +++----
 b/drivers/scsi/hosts.c                    |   23 
 b/drivers/scsi/ibmmca.c                   |    2 
 b/drivers/scsi/ibmvscsi/ibmvscsi.c        |    4 
 b/drivers/scsi/ipr.c                      |    9 
 b/drivers/scsi/ipr.h                      |   42 
 b/drivers/scsi/mca_53c9x.c                |    4 
 b/drivers/scsi/qla2xxx/Kconfig            |   14 
 b/drivers/scsi/qla2xxx/Makefile           |    2 
 b/drivers/scsi/qla2xxx/ql2300.c           |    2 
 b/drivers/scsi/qla2xxx/ql2300_fw.c        |13924 +++++++++++++++---------------
 b/drivers/scsi/qla2xxx/ql2322_fw.c        |13219 ++++++++++++++--------------
 b/drivers/scsi/qla2xxx/ql6312.c           |   14 
 b/drivers/scsi/qla2xxx/ql6312_fw.c        |13577 ++++++++++++++---------------
 b/drivers/scsi/qla2xxx/qla_def.h          |   50 
 b/drivers/scsi/qla2xxx/qla_devtbl.h       |   96 
 b/drivers/scsi/qla2xxx/qla_gbl.h          |   44 
 b/drivers/scsi/qla2xxx/qla_init.c         |  607 -
 b/drivers/scsi/qla2xxx/qla_iocb.c         |   97 
 b/drivers/scsi/qla2xxx/qla_isr.c          |   25 
 b/drivers/scsi/qla2xxx/qla_mbx.c          |  503 -
 b/drivers/scsi/qla2xxx/qla_os.c           |  162 
 b/drivers/scsi/qla2xxx/qla_rscn.c         |    2 
 b/drivers/scsi/qla2xxx/qla_sup.c          |   93 
 b/drivers/scsi/qla2xxx/qla_version.h      |    6 
 b/drivers/scsi/scsi.c                     |   13 
 b/drivers/scsi/scsi_debug.c               |  479 -
 b/drivers/scsi/scsi_error.c               |   53 
 b/drivers/scsi/scsi_ioctl.c               |   33 
 b/drivers/scsi/scsi_lib.c                 |   50 
 b/drivers/scsi/scsi_scan.c                |   71 
 b/drivers/scsi/scsi_sysfs.c               |  113 
 b/drivers/scsi/scsi_transport_fc.c        |  563 +
 b/drivers/scsi/scsi_transport_iscsi.c     |  355 
 b/drivers/scsi/scsicam.c                  |    3 
 b/include/linux/pci_ids.h                 |   10 
 b/include/scsi/scsi_host.h                |   29 
 b/include/scsi/scsi_tcq.h                 |   52 
 b/include/scsi/scsi_transport.h           |    6 
 b/include/scsi/scsi_transport_fc.h        |  243 
 b/include/scsi/scsi_transport_iscsi.h     |  178 
 drivers/scsi/qla2xxx/ql6322.c             |  108 
 drivers/scsi/qla2xxx/ql6322_fw.c          | 7433 ----------------
 drivers/scsi/scsi_syms.c                  |   97 
 63 files changed, 27355 insertions(+), 33711 deletions(-)

James



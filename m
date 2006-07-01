Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751473AbWGADJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbWGADJv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 23:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751685AbWGADJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 23:09:50 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:36530 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751545AbWGADJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 23:09:49 -0400
Subject: [GIT PATCH] final SCSI updates for 2.6.17
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 30 Jun 2006 22:09:27 -0500
Message-Id: <1151723367.8921.68.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the final 2.6.17 scsi updates.  It contains the port API for SAS
that we held off on; quite a slew of driver updates and some
miscellaneous bug fixes.

The patch is available here:

master.kernel.org:/pub/scm/linux/kernel/git/jejb/scsi-misc-2.6.git

The short changelog is:

Adrian Bunk:
  o qla2xxx: make some more functions static

Alan Cox:
  o Bogus disk geometry on large disks

Alan Stern:
  o core: Allow QUIESCE -> CANCEL sdev transition

Andrew Vasquez:
  o qla2xxx: Update version number to 8.01.05-k3
  o qla2xxx: Correctly set the firmware NOS/OLS timeout during initialization
  o qla2xxx: Convert from pci_module_init() to pci_register_driver()
  o qla2xxx: Correct 'loop-down' determination logic in qla2x00_fw_ready()
  o qla2xxx: Add support for extended error logging
  o qla2xxx: Cleanup DEBUG macro usage
  o qla2xxx: Remove no-op IOCTL codes and macros
  o qla2xxx: Create an VPD sysfs entry for supported ISPs only
  o qla2xxx: Add DMI (Diagnostics Monitoring Interface) support
  o qla2xxx: Honour 'skip process-login' option during fabric-login IOCB
  o qla2xxx: Add NVRAM 'Disable Serdes' bit support
  o qla2xxx: Resync with latest HBA SSID specification -- 2.2j
  o qla2xxx: Rework firmware-trace facilities

Brian King:
  o scsi: Device scanning oops for offlined devices (resend)
  o scsi: Add allow_restart sysfs class attribute

Dave C Boutcher:
  o ibmvscsi: treat busy and error conditions separately

Dave Jones:
  o kmalloc argument switcheroo in recent 53c700 change

Douglas Gilbert:
  o scsi_debug version 1.79

Eric Moore:
  o mptbase: mpt_interrupt should return IRQ_NONE
  o mptsas: make two functions static
  o mptsas: Adding 1078 ROC support
  o mptsas: wide port support
  o fusion : mpi header update

Hannes Reinecke:
  o aic79xx: remove slave_destroy
  o HP XP devinfo update

Ishai Rabinovitz:
  o sg.c: Fix bad error handling in

James Bottomley:
  o mptsas: eliminate ghost devices
  o 53c700: fix breakage caused by the autosense update
  o Merge ../linux-2.6/
  o scsi_transport_sas: introduce a sas_port entity

James Smart:
  o fc transport: bug fix: correct references
  o update max sdev block limit
  o fc transport: resolve scan vs delete deadlocks
  o Block I/O while SG reset operation in progress - lpfc portion
  o Block I/O while SG reset operation in progress - the midlayer patch

Jesper Juhl:
  o small whitespace cleanup for qlogic driver

Luben Tuikov:
  o sd/scsi_lib simplify sd_rw_intr and scsi_io_completion

Mark Salyzyn:
  o aacraid: remove x86_64 IOMMU dependent code

Martin Habets:
  o st: remove unused st_buffer.in_use

Masanori GOTO:
  o Add scsi_add_host() failure handling for nsp32

Matt Mackall:
  o random: remove redundant SA_SAMPLE_RANDOM from NinjaSCSI

Mike Christie:
  o iscsi: add async notification of session events
  o iscsi: pass target nr to session creation
  o iscsi: break up session creation into two stages
  o iscsi: rm channel usage from iscsi
  o iscsi: fix session refcouting
  o iscsi: convert iscsi_tcp to new set/get param fns
  o iscsi: convert iser to new set/get param fns
  o iscsi: fixup set/get param functions
  o iscsi: add target discvery event to transport class

Randy Dunlap:
  o qla1280: fix section mismatch warnings
  o atp870u: reduce huge stack usage
  o lpfc: sparse NULL warnings

Sumant Patro:
  o megaraid_sas: zcr with fix

And the diffstat:

 b/Documentation/scsi/ChangeLog.megaraid_sas  |   16 
 b/drivers/infiniband/ulp/iser/iscsi_iser.c   |  138 ---
 b/drivers/message/fusion/Makefile            |    5 
 b/drivers/message/fusion/lsi/mpi.h           |    5 
 b/drivers/message/fusion/lsi/mpi_cnfg.h      |  158 +++
 b/drivers/message/fusion/lsi/mpi_history.txt |   76 +
 b/drivers/message/fusion/lsi/mpi_init.h      |    4 
 b/drivers/message/fusion/lsi/mpi_ioc.h       |  154 ++-
 b/drivers/message/fusion/lsi/mpi_log_sas.h   |   82 +
 b/drivers/message/fusion/lsi/mpi_sas.h       |   13 
 b/drivers/message/fusion/lsi/mpi_targ.h      |    5 
 b/drivers/message/fusion/mptbase.c           |   75 +
 b/drivers/message/fusion/mptbase.h           |   19 
 b/drivers/message/fusion/mptfc.c             |   16 
 b/drivers/message/fusion/mptsas.c            |  996 +++++++++++++++------
 b/drivers/message/fusion/mptspi.c            |    4 
 b/drivers/scsi/53c700.c                      |   56 -
 b/drivers/scsi/53c700.h                      |   34 
 b/drivers/scsi/aacraid/comminit.c            |   26 
 b/drivers/scsi/aic7xxx/aic79xx.h             |    1 
 b/drivers/scsi/aic7xxx/aic79xx_core.c        |   24 
 b/drivers/scsi/aic7xxx/aic79xx_osm.c         |   62 -
 b/drivers/scsi/aic7xxx/aic79xx_osm.h         |   11 
 b/drivers/scsi/aic7xxx/aic79xx_proc.c        |   19 
 b/drivers/scsi/atp870u.c                     |  157 +--
 b/drivers/scsi/ibmvscsi/ibmvscsi.c           |   64 +
 b/drivers/scsi/ibmvscsi/rpa_vscsi.c          |    5 
 b/drivers/scsi/iscsi_tcp.c                   |  152 ---
 b/drivers/scsi/libiscsi.c                    |  187 ++++
 b/drivers/scsi/lpfc/lpfc.h                   |    1 
 b/drivers/scsi/lpfc/lpfc_els.c               |    6 
 b/drivers/scsi/lpfc/lpfc_init.c              |    5 
 b/drivers/scsi/lpfc/lpfc_scsi.c              |   20 
 b/drivers/scsi/megaraid/megaraid_sas.c       |   32 
 b/drivers/scsi/megaraid/megaraid_sas.h       |   21 
 b/drivers/scsi/nsp32.c                       |   12 
 b/drivers/scsi/pcmcia/nsp_cs.c               |    2 
 b/drivers/scsi/qla1280.c                     |    2 
 b/drivers/scsi/qla2xxx/qla_attr.c            |  120 +-
 b/drivers/scsi/qla2xxx/qla_dbg.c             |  925 ++++----------------
 b/drivers/scsi/qla2xxx/qla_dbg.h             |  155 +--
 b/drivers/scsi/qla2xxx/qla_def.h             |   19 
 b/drivers/scsi/qla2xxx/qla_devtbl.h          |   17 
 b/drivers/scsi/qla2xxx/qla_fw.h              |    4 
 b/drivers/scsi/qla2xxx/qla_gbl.h             |   26 
 b/drivers/scsi/qla2xxx/qla_init.c            |  145 ++-
 b/drivers/scsi/qla2xxx/qla_iocb.c            |    3 
 b/drivers/scsi/qla2xxx/qla_isr.c             |   24 
 b/drivers/scsi/qla2xxx/qla_mbx.c             |  280 +++---
 b/drivers/scsi/qla2xxx/qla_os.c              |  125 +-
 b/drivers/scsi/qla2xxx/qla_version.h         |    2 
 b/drivers/scsi/scsi_debug.c                  | 1223 ++++++++++++++++++++++-----
 b/drivers/scsi/scsi_devinfo.c                |    2 
 b/drivers/scsi/scsi_error.c                  |   22 
 b/drivers/scsi/scsi_lib.c                    |  112 +-
 b/drivers/scsi/scsi_priv.h                   |    2 
 b/drivers/scsi/scsi_sas_internal.h           |   10 
 b/drivers/scsi/scsi_scan.c                   |    1 
 b/drivers/scsi/scsi_transport_fc.c           |   42 
 b/drivers/scsi/scsi_transport_iscsi.c        |  658 ++++++++------
 b/drivers/scsi/scsi_transport_sas.c          |  371 +++++++-
 b/drivers/scsi/scsicam.c                     |    3 
 b/drivers/scsi/sd.c                          |  169 +--
 b/drivers/scsi/sg.c                          |   10 
 b/drivers/scsi/sr.c                          |    2 
 b/drivers/scsi/st.c                          |    1 
 b/drivers/scsi/st.h                          |    1 
 b/include/scsi/iscsi_if.h                    |   24 
 b/include/scsi/libiscsi.h                    |   15 
 b/include/scsi/scsi_cmnd.h                   |    2 
 b/include/scsi/scsi_host.h                   |    6 
 b/include/scsi/scsi_transport_iscsi.h        |   48 -
 b/include/scsi/scsi_transport_sas.h          |   37 
 drivers/message/fusion/lsi/fc_log.h          |   89 -
 74 files changed, 4500 insertions(+), 2860 deletions(-)

James



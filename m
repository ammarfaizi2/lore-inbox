Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbVKKVtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbVKKVtQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 16:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbVKKVtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 16:49:16 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:45213 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751100AbVKKVtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 16:49:15 -0500
Subject: [GIT PATCH] final pre -rc pieces of SCSI for 2.6.14
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 11 Nov 2005 15:49:01 -0600
Message-Id: <1131745742.3505.47.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This should be the final round of updates that I've been doing a few
integration tests on.

The patch should be available here (checked the permissions this time)

master.kernel.org:/pub/scm/linux/kernel/git/jejb/scsi-for-linus-2.6.git

The short changelog is:

Adrian Bunk:
  o remove the obsolete SCSI qlogicisp driver

Alan Stern:
  o Fix refcount leak in scsi_report_lun_scan

Andrew Vasquez:
  o qla2xxx: Update version number to 8.01.03-k
  o qla2xxx: Correct ISP24xx soft-reset handling
  o qla2xxx: Correct additional posting issues during NVRAM accesses

Brian King:
  o ipr: Driver version 2.1.0
  o ipr: Better handle failure of adapter bringup commands
  o ipr: Increase ipr device scanning limits
  o ipr: New PCI Ids
  o pci: PCI ids for new ipr adapters
  o ipr: Support device reset to RAID disks
  o ipr: Support new device queueing model
  o ipr: New adapter error types
  o ipr: Handle device autosense
  o ipr: Module parm to disable RAID 0 auto create
  o ipr: Runtime reset
  o ipr: handle new adapter errors
  o ipr: Provide reset_adapter retry method for offlined adapters
  o ipr: Runtime debugging options
  o ipr: Fix adapter microcode update DMA mapping leak
  o ipr: Convert to use kzalloc
  o ipr: Write caching state host attribute
  o ipr: slave_alloc optimization
  o ipr: Prevent upper layer driver binding
  o ipr: Include all disks in supported list
  o ipr: Error logging cleanup
  o ipr: Handle unknown errors
  o ipr: Generic adapter error cleaup
  o ipr: Physical resource error logging macro
  o ipr: Cleanup error structures
  o ipr: Disk array rescanning fix

Christoph Hellwig:
  o remove Scsi_Device typedef
  o remove Scsi_Pointer typedef
  o remove Scsi_Host_Template typedef
  o aic79xx: remove scsi_assign_lock usage
  o aic7xxx: remove scsi_assign_lock usage
  o megaraid (legacy): remove scsi_assign_lock usage
  o megaraid_mbox: remove scsi_assign_lock usage
  o megaraid_sas: fix EH locking
  o use a completion in scsi_send_eh_cmnd
  o remove scsi_wait_req
  o remove Scsi_Host.eh_active
  o tidy up scsi_error_handler

edward goggin:
  o fix usb storage oops

Jack Hammer:
  o ips: remove "Version Matching"

James Bottomley:
  o Merge by hand (whitespace conflicts in libata.h)
  o sd: fix issue_flush
  o Merge by hand (conflicts between pending drivers and kfree cleanups)
  o raid class update
  o Fix transport class oops

Mark Haverkamp:
  o aacraid: Fix read capacity 16 return data

Mike Miller:
  o cciss: scsi error handling

Ravi Anand:
  o qla2xxx: Correct abort issue during loop-down state
  o qla2xxx: Correct loop-in-transition issues

Stefan Richter:
  o Documentation: typo in scsi/scsi_eh.txt

Willem Riede:
  o ide-scsi fails to call idescsi_check_condition for things like
"Medium not present"

The diffstat is:

 Documentation/scsi/qlogicisp.txt          |   30 
 b/Documentation/cciss.txt                 |   29 
 b/Documentation/scsi/00-INDEX             |    2 
 b/Documentation/scsi/qlogicfas.txt        |    3 
 b/Documentation/scsi/scsi_eh.txt          |    8 
 b/Documentation/scsi/scsi_mid_low_api.txt |    4 
 b/drivers/block/acsi.c                    |    1 
 b/drivers/block/cciss.c                   |  188 ++
 b/drivers/block/cciss.h                   |   11 
 b/drivers/block/cciss_scsi.c              |   82 +
 b/drivers/scsi/53c7xx.c                   |    6 
 b/drivers/scsi/53c7xx.h                   |    2 
 b/drivers/scsi/Kconfig                    |   29 
 b/drivers/scsi/Makefile                   |    1 
 b/drivers/scsi/NCR53C9x.c                 |   10 
 b/drivers/scsi/NCR53C9x.h                 |    6 
 b/drivers/scsi/NCR53c406a.c               |    4 
 b/drivers/scsi/a2091.c                    |    4 
 b/drivers/scsi/a2091.h                    |    2 
 b/drivers/scsi/a3000.c                    |    4 
 b/drivers/scsi/a3000.h                    |    2 
 b/drivers/scsi/aacraid/aachba.c           |   23 
 b/drivers/scsi/aacraid/commsup.c          |    4 
 b/drivers/scsi/advansys.c                 |    6 
 b/drivers/scsi/advansys.h                 |    2 
 b/drivers/scsi/aha152x.c                  |    4 
 b/drivers/scsi/aha1542.c                  |    4 
 b/drivers/scsi/aha1542.h                  |    2 
 b/drivers/scsi/aha1740.c                  |    2 
 b/drivers/scsi/aic7xxx/aic79xx_osm.c      |   37 
 b/drivers/scsi/aic7xxx/aic7xxx_osm.c      |   39 
 b/drivers/scsi/aic7xxx_old.c              |   18 
 b/drivers/scsi/amiga7xx.c                 |    8 
 b/drivers/scsi/amiga7xx.h                 |    2 
 b/drivers/scsi/arm/acornscsi.c            |    6 
 b/drivers/scsi/arm/acornscsi.h            |    2 
 b/drivers/scsi/arm/arxescsi.c             |    8 
 b/drivers/scsi/arm/cumana_1.c             |    2 
 b/drivers/scsi/arm/cumana_2.c             |    8 
 b/drivers/scsi/arm/ecoscsi.c              |    2 
 b/drivers/scsi/arm/eesox.c                |    8 
 b/drivers/scsi/arm/fas216.c               |   10 
 b/drivers/scsi/arm/fas216.h               |    8 
 b/drivers/scsi/arm/oak.c                  |    2 
 b/drivers/scsi/arm/powertec.c             |    6 
 b/drivers/scsi/arm/scsi.h                 |    8 
 b/drivers/scsi/atari_NCR5380.c            |    2 
 b/drivers/scsi/atari_scsi.c               |    4 
 b/drivers/scsi/atari_scsi.h               |    2 
 b/drivers/scsi/blz1230.c                  |    4 
 b/drivers/scsi/blz2060.c                  |    4 
 b/drivers/scsi/bvme6000.c                 |    4 
 b/drivers/scsi/bvme6000.h                 |    2 
 b/drivers/scsi/cyberstorm.c               |    4 
 b/drivers/scsi/cyberstormII.c             |    4 
 b/drivers/scsi/dec_esp.c                  |    2 
 b/drivers/scsi/dpti.h                     |    2 
 b/drivers/scsi/dtc.c                      |    6 
 b/drivers/scsi/dtc.h                      |    2 
 b/drivers/scsi/fastlane.c                 |    4 
 b/drivers/scsi/fcal.c                     |    8 
 b/drivers/scsi/fcal.h                     |    4 
 b/drivers/scsi/fd_mcs.c                   |    4 
 b/drivers/scsi/g_NCR5380.c                |    6 
 b/drivers/scsi/g_NCR5380.h                |    2 
 b/drivers/scsi/gdth.c                     |   12 
 b/drivers/scsi/gdth.h                     |    4 
 b/drivers/scsi/gdth_proc.c                |   10 
 b/drivers/scsi/gvp11.c                    |    4 
 b/drivers/scsi/gvp11.h                    |    2 
 b/drivers/scsi/ibmmca.c                   |    8 
 b/drivers/scsi/ibmmca.h                   |    2 
 b/drivers/scsi/ide-scsi.c                 |    2 
 b/drivers/scsi/in2000.c                   |    4 
 b/drivers/scsi/in2000.h                   |    2 
 b/drivers/scsi/ipr.c                      |  904 ++++++++++---
 b/drivers/scsi/ipr.h                      |  243 ++-
 b/drivers/scsi/ips.c                      |  150 --
 b/drivers/scsi/ips.h                      |    4 
 b/drivers/scsi/jazz_esp.c                 |    4 
 b/drivers/scsi/mac_esp.c                  |    4 
 b/drivers/scsi/mac_scsi.c                 |    6 
 b/drivers/scsi/mca_53c9x.c                |    4 
 b/drivers/scsi/megaraid.c                 |   34 
 b/drivers/scsi/megaraid.h                 |   10 
 b/drivers/scsi/megaraid/mega_common.h     |    2 
 b/drivers/scsi/megaraid/megaraid_mbox.c   |   81 -
 b/drivers/scsi/megaraid/megaraid_sas.c    |    5 
 b/drivers/scsi/mvme147.c                  |    4 
 b/drivers/scsi/mvme147.h                  |    2 
 b/drivers/scsi/mvme16x.c                  |    4 
 b/drivers/scsi/mvme16x.h                  |    2 
 b/drivers/scsi/nsp32.c                    |    6 
 b/drivers/scsi/oktagon_esp.c              |    4 
 b/drivers/scsi/pas16.c                    |    6 
 b/drivers/scsi/pas16.h                    |    2 
 b/drivers/scsi/pci2000.h                  |    2 
 b/drivers/scsi/pcmcia/nsp_cs.c            |    8 
 b/drivers/scsi/pcmcia/nsp_cs.h            |    6 
 b/drivers/scsi/pcmcia/qlogic_stub.c       |    4 
 b/drivers/scsi/pluto.c                    |    8 
 b/drivers/scsi/pluto.h                    |    4 
 b/drivers/scsi/psi240i.c                  |    4 
 b/drivers/scsi/qla1280.c                  |    8 
 b/drivers/scsi/qla2xxx/qla_dbg.c          |    8 
 b/drivers/scsi/qla2xxx/qla_init.c         |   28 
 b/drivers/scsi/qla2xxx/qla_mbx.c          |   10 
 b/drivers/scsi/qla2xxx/qla_sup.c          |    5 
 b/drivers/scsi/qla2xxx/qla_version.h      |    4 
 b/drivers/scsi/qlogicfas.c                |    6 
 b/drivers/scsi/qlogicfc.c                 |    4 
 b/drivers/scsi/raid_class.c               |   96 +
 b/drivers/scsi/scsi_debug.c               |    2 
 b/drivers/scsi/scsi_error.c               |  157 --
 b/drivers/scsi/scsi_lib.c                 |   58 
 b/drivers/scsi/scsi_priv.h                |    1 
 b/drivers/scsi/scsi_scan.c                |   54 
 b/drivers/scsi/scsi_sysfs.c               |    9 
 b/drivers/scsi/scsi_typedefs.h            |    3 
 b/drivers/scsi/sd.c                       |   22 
 b/drivers/scsi/seagate.c                  |    4 
 b/drivers/scsi/seagate.h                  |    2 
 b/drivers/scsi/sgiwd93.c                  |    6 
 b/drivers/scsi/sun3_NCR5380.c             |    2 
 b/drivers/scsi/sun3_scsi.c                |    6 
 b/drivers/scsi/sun3_scsi.h                |    2 
 b/drivers/scsi/sun3_scsi_vme.c            |    6 
 b/drivers/scsi/sun3x_esp.c                |    4 
 b/drivers/scsi/sym53c416.c                |    4 
 b/drivers/scsi/sym53c416.h                |    2 
 b/drivers/scsi/t128.c                     |    6 
 b/drivers/scsi/t128.h                     |    2 
 b/drivers/scsi/u14-34f.c                  |    2 
 b/drivers/scsi/ultrastor.c                |    8 
 b/drivers/scsi/ultrastor.h                |    2 
 b/drivers/usb/image/microtek.c            |    2 
 b/include/linux/libata.h                  |    2 
 b/include/linux/pci_ids.h                 |    2 
 b/include/linux/raid_class.h              |   32 
 b/include/scsi/scsi_host.h                |    7 
 b/include/scsi/scsi_request.h             |    3 
 drivers/scsi/qlogicisp.c                  | 1934 ----------------------------
 drivers/scsi/qlogicisp_asm.c              | 2034 ------------------------------
 143 files changed, 1733 insertions(+), 5102 deletions(-)

James



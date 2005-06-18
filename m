Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262119AbVFROH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbVFROH2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 10:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbVFROH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 10:07:28 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:2267 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262119AbVFROGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 10:06:38 -0400
Subject: [GIT PATCH] SCSI updates for 2.6.12
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sat, 18 Jun 2005 09:06:26 -0500
Message-Id: <1119103586.4984.5.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is several driver updates (aic7xxx and fusion are the big reworks)
with some infrastructure fixups.  Note: The fusion update reworks the
driver to begin separating out the transports (so SPI, SAS and FC no
longer have a single module driving them).

The patch is available from

rsync://www.parisc-linux.org/~jejb/git/scsi-for-linus-2.6.git

or

http://www.kernel.org/pub/scm/linux/kernel/git/jejb/scsi-for-linus-2.6.git/

The Short log is:

Adrian Bunk:
  o drivers/scsi/sym53c416.c: fix a wrong check
  o drivers/scsi/aacraid/: make some functions static
  o drivers/scsi/NCR53C9x.c: make a struct static
  o drivers/scsi/atp870u.c: make a function static

Alexander Viro:
  o TYPE_RBC cache fixes (sbp2.c affected)
  o qla trivial iomem annotation

Andreas Herrmann:
  o zfcp: fix handling of port boxed and lun boxed fsf states
  o zfcp: fix module parameter parsing
  o zfcp: fix bug during adapter shutdown
  o zfcp: fix: problem in send_els_handler when D_ID assignment changes
  o zfcp: fix: mark fsf request failed when receiving unknown status qualifier
  o zfcp: fix: reopen port only if link-test fails
  o zfcp: fix: allow more time for adapter initialization
  o zfcp: fix wrong handling of failed requests for GID_PN command
  o zfcp: remove flags_dump feature

Andrew Morton:
  o git-scsi-misc-sbp2-warning-fix

Andrew Vasquez:
  o qla2xxx: Pull-down scsi-host-addition to follow board initialization
  o remove some dead code in qla2xxx

Benoit Boissinot:
  o drivers/scsi/dpt_i2o.c: fix compile warnings
  o drivers/scsi/dpt_i2o.c: cleanup useless code

Brian King:
  o sg: Command completion after remove oops
  o ipr: Fix ipr PCI hotplug hang with CDROM attach
  o ipr: Driver version 2.0.14
  o ipr: Array error logging fix

Christoph Hellwig:
  o aic7xxx: clean up eisa support
  o aic7xxx: remove some dead wood
  o aic7xxx: remove ahc_find_softc
  o aic7xxx: do not check for duplicate pci ids
  o aic7xxx/aic79xx: remove useless byte order macro cruft
  o remove Documentation/DocBook/scsidrivers.tmpl

Eric Moore:
  o fusion - bump driver version to 3.03.02
  o fusion - mpi headers version 1.5.9
  o fusion-kconfig-cleanup
  o fusion-kfree-cleanup
  o fusion - Adding pci recog support for Fibre 949X and 939X chips
  o mptfusion: fix panic loading driver statically compiled
  o mptfusion: mptfc Adding Stub Driver - Fiber Channel
  o mptfusion: mptspi Adding Stub Driver - SCSI Parallel
  o mptfusion: mptscsih Split driver support
  o mptfusion: mptlan Remove credits and update copyright
  o mptfusion: mptctl Remove credits and update copyright
  o mptfusion: mptbase cleanup, split driver support, DMA 32_BIT_MASK
  o mptfusion: Kconfig Adding new bus type drivers for fusion drivers

Gerd Knorr:
  o convert scsi changer driver from class simple
  o add scsi changer driver

James Bottomley:
  o merge by hand (qla_os.c mismerge)
  o merge by hand (fix up qla_os.c merge error)
  o aic7xxx: fix the BIOS limits setting routines
  o update spi transport class so that u320 Domain Validation works
  o fix aic7xxx coupled parameter problem
  o aic7xxx: remove separate target and device allocations
  o Automatic merge of ../scsi-misc-2.6-old/
  o allow the HBA to reserve target and device private areas
  o Add target alloc/destroy callbacks to the host template
  o merge by hand - fix up rejections in Documentation/DocBook/Makefile
  o ultrastor: fix compile failure
  o drivers/scsi/FlashPoint.c: cleanups
  o mptfusion: correct Kconfig problem
  o remove PCI2000 and PCI2220i drivers
  o qla1280: update firmware

Jeff Garzik:
  o allow sleeping in ->eh_host_reset_handler()
  o allow sleeping in ->eh_bus_reset_handler()
  o allow sleeping in ->eh_device_reset_handler()
  o allow sleeping in ->eh_abort_handler()
  o Remove no-op implementations of SCSI EH hooks
  o Remove unnecessary locking around completion function calls

Jeremy Higdon:
  o qla1280.c - fix result for device Busy and Queue Full

Kai Mäkisara:
  o tape: fix permissions for SG_IO, etc

Lee Revell:
  o Add DMA mask constants other than 32 and 64 bit

Mark Haverkamp:
  o aacraid: regression fix
  o 2.6 aacraid: updated sysfs files
  o 2.6 aacraid: Variable FIB size (updated patch)
  o aacraid: remove sparse warnings

Matthew Wilcox:
  o sym2 version 2.2.1

Mike Miller:
  o cciss 2.6 DMA mapping

Patrick Mansfield:
  o saved and restore result for timed out commands

Seokmann Ju:
  o megaraid version 2.20.4.6

Tejun Heo:
  o remove a timer race in scsi_queue_insert()
  o remove spurious if tests from scsi_eh_{times_out|done}
  o remove unnecessary scsi_delete_timer() call in scsi_reset_provider()
  o make scsi_queue_insert() use blk_requeue_request()
  o make scsi_requeue_request() use blk_requeue_request()
  o remove requeue feature from blk_insert_request()
  o remove REQ_SPECIAL in scsi_init_io()
  o make blk layer set REQ_SOFTBARRIER on defer and requeue

And the diffstat (sorry qla1280 firmware this time):

 Documentation/DocBook/scsidrivers.tmpl       |  193 
 b/Documentation/DocBook/Makefile             |    2 
 b/Documentation/scsi/ChangeLog.megaraid      |   66 
 b/Documentation/scsi/scsi-changer.txt        |  180 
 b/Documentation/scsi/scsi_mid_low_api.txt    |   12 
 b/drivers/block/cciss.c                      |   12 
 b/drivers/block/elevator.c                   |   13 
 b/drivers/block/ll_rw_blk.c                  |   20 
 b/drivers/block/paride/pd.c                  |    2 
 b/drivers/block/sx8.c                        |    4 
 b/drivers/fc4/fc.c                           |   26 
 b/drivers/fc4/fc_syms.c                      |    1 
 b/drivers/fc4/fcp_impl.h                     |    1 
 b/drivers/ieee1394/sbp2.c                    |  151 
 b/drivers/ieee1394/sbp2.h                    |    4 
 b/drivers/message/fusion/Kconfig             |   56 
 b/drivers/message/fusion/Makefile            |   44 
 b/drivers/message/fusion/lsi/mpi.h           |   70 
 b/drivers/message/fusion/lsi/mpi_cnfg.h      | 1005 +++-
 b/drivers/message/fusion/lsi/mpi_fc.h        |    7 
 b/drivers/message/fusion/lsi/mpi_history.txt |  451 +-
 b/drivers/message/fusion/lsi/mpi_inb.h       |    7 
 b/drivers/message/fusion/lsi/mpi_init.h      |   88 
 b/drivers/message/fusion/lsi/mpi_ioc.h       |  254 -
 b/drivers/message/fusion/lsi/mpi_lan.h       |    6 
 b/drivers/message/fusion/lsi/mpi_raid.h      |   17 
 b/drivers/message/fusion/lsi/mpi_sas.h       |  171 
 b/drivers/message/fusion/lsi/mpi_targ.h      |  160 
 b/drivers/message/fusion/lsi/mpi_tool.h      |   57 
 b/drivers/message/fusion/lsi/mpi_type.h      |   11 
 b/drivers/message/fusion/mptbase.c           |  343 -
 b/drivers/message/fusion/mptbase.h           |   52 
 b/drivers/message/fusion/mptctl.c            |   68 
 b/drivers/message/fusion/mptctl.h            |   15 
 b/drivers/message/fusion/mptfc.c             |  431 +
 b/drivers/message/fusion/mptlan.c            |   37 
 b/drivers/message/fusion/mptlan.h            |   48 
 b/drivers/message/fusion/mptscsih.c          |  795 ---
 b/drivers/message/fusion/mptscsih.h          |   43 
 b/drivers/message/fusion/mptspi.c            |  486 ++
 b/drivers/s390/scsi/zfcp_aux.c               |   37 
 b/drivers/s390/scsi/zfcp_def.h               |   25 
 b/drivers/s390/scsi/zfcp_erp.c               |  121 
 b/drivers/s390/scsi/zfcp_ext.h               |    4 
 b/drivers/s390/scsi/zfcp_fsf.c               |  324 -
 b/drivers/s390/scsi/zfcp_qdio.c              |   68 
 b/drivers/s390/scsi/zfcp_scsi.c              |   24 
 b/drivers/scsi/3w-9xxx.c                     |    3 
 b/drivers/scsi/3w-xxxx.c                     |    3 
 b/drivers/scsi/53c700.c                      |   26 
 b/drivers/scsi/BusLogic.c                    |    8 
 b/drivers/scsi/FlashPoint.c                  | 5872 ++++-----------------------
 b/drivers/scsi/Kconfig                       |   40 
 b/drivers/scsi/Makefile                      |    3 
 b/drivers/scsi/NCR5380.c                     |   42 
 b/drivers/scsi/NCR5380.h                     |    2 
 b/drivers/scsi/NCR53C9x.c                    |    6 
 b/drivers/scsi/NCR53c406a.c                  |   23 
 b/drivers/scsi/a2091.c                       |    7 
 b/drivers/scsi/a3000.c                       |    7 
 b/drivers/scsi/aacraid/aachba.c              |  165 
 b/drivers/scsi/aacraid/aacraid.h             |  470 +-
 b/drivers/scsi/aacraid/commctrl.c            |  228 -
 b/drivers/scsi/aacraid/comminit.c            |   92 
 b/drivers/scsi/aacraid/commsup.c             |  100 
 b/drivers/scsi/aacraid/dpcsup.c              |    6 
 b/drivers/scsi/aacraid/linit.c               |  179 
 b/drivers/scsi/aacraid/rkt.c                 |   43 
 b/drivers/scsi/aacraid/rx.c                  |   46 
 b/drivers/scsi/aacraid/sa.c                  |   35 
 b/drivers/scsi/aha152x.c                     |    2 
 b/drivers/scsi/aha1542.c                     |   22 
 b/drivers/scsi/aha1542.h                     |    1 
 b/drivers/scsi/aic7xxx/aic7770_osm.c         |  191 
 b/drivers/scsi/aic7xxx/aic79xx_osm.c         |   20 
 b/drivers/scsi/aic7xxx/aic79xx_osm.h         |   17 
 b/drivers/scsi/aic7xxx/aic7xxx.h             |    2 
 b/drivers/scsi/aic7xxx/aic7xxx_core.c        |   16 
 b/drivers/scsi/aic7xxx/aic7xxx_osm.c         |  662 +--
 b/drivers/scsi/aic7xxx/aic7xxx_osm.h         |   64 
 b/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c     |   46 
 b/drivers/scsi/aic7xxx/aic7xxx_proc.c        |   31 
 b/drivers/scsi/aic7xxx_old.c                 |   33 
 b/drivers/scsi/arm/cumana_1.c                |    2 
 b/drivers/scsi/arm/ecoscsi.c                 |    2 
 b/drivers/scsi/arm/fas216.c                  |    3 
 b/drivers/scsi/arm/oak.c                     |    2 
 b/drivers/scsi/atp870u.c                     |    4 
 b/drivers/scsi/ch.c                          | 1026 ++++
 b/drivers/scsi/dc395x.c                      |   12 
 b/drivers/scsi/dmx3191d.c                    |    2 
 b/drivers/scsi/dpt_i2o.c                     |   65 
 b/drivers/scsi/dpti.h                        |    2 
 b/drivers/scsi/dtc.c                         |    2 
 b/drivers/scsi/dtc.h                         |    4 
 b/drivers/scsi/eata.c                        |   11 
 b/drivers/scsi/eata_pio.c                    |    5 
 b/drivers/scsi/fcal.c                        |    1 
 b/drivers/scsi/fd_mcs.c                      |   17 
 b/drivers/scsi/fdomain.c                     |    6 
 b/drivers/scsi/g_NCR5380.c                   |    2 
 b/drivers/scsi/g_NCR5380.h                   |    4 
 b/drivers/scsi/gdth.c                        |   23 
 b/drivers/scsi/gvp11.c                       |    8 
 b/drivers/scsi/ibmmca.c                      |   28 
 b/drivers/scsi/ibmvscsi/ibmvscsi.c           |    4 
 b/drivers/scsi/ide-scsi.c                    |   11 
 b/drivers/scsi/imm.c                         |    9 
 b/drivers/scsi/in2000.c                      |   31 
 b/drivers/scsi/in2000.h                      |    2 
 b/drivers/scsi/initio.c                      |    4 
 b/drivers/scsi/ipr.c                         |   55 
 b/drivers/scsi/ipr.h                         |    4 
 b/drivers/scsi/ips.c                         |   21 
 b/drivers/scsi/lpfc/lpfc_scsi.c              |   36 
 b/drivers/scsi/mac53c94.c                    |   11 
 b/drivers/scsi/mac_scsi.c                    |    2 
 b/drivers/scsi/mac_scsi.h                    |    2 
 b/drivers/scsi/megaraid.c                    |   14 
 b/drivers/scsi/megaraid/mega_common.h        |    1 
 b/drivers/scsi/megaraid/megaraid_mbox.c      |  156 
 b/drivers/scsi/megaraid/megaraid_mbox.h      |   64 
 b/drivers/scsi/megaraid/megaraid_mm.c        |    9 
 b/drivers/scsi/megaraid/megaraid_mm.h        |    4 
 b/drivers/scsi/mesh.c                        |    4 
 b/drivers/scsi/mvme147.c                     |    7 
 b/drivers/scsi/nsp32.c                       |    7 
 b/drivers/scsi/pas16.c                       |    2 
 b/drivers/scsi/pas16.h                       |    4 
 b/drivers/scsi/pcmcia/nsp_cs.c               |   15 
 b/drivers/scsi/pcmcia/qlogic_stub.c          |    2 
 b/drivers/scsi/pcmcia/sym53c500_cs.c         |    2 
 b/drivers/scsi/pluto.c                       |    1 
 b/drivers/scsi/ppa.c                         |    5 
 b/drivers/scsi/ql1040_fw.h                   | 4021 +++++++++---------
 b/drivers/scsi/ql12160_fw.h                  | 3046 +++++++-------
 b/drivers/scsi/ql1280_fw.h                   | 3653 ++++++++--------
 b/drivers/scsi/qla1280.c                     |   41 
 b/drivers/scsi/qla2xxx/qla_dbg.c             |    3 
 b/drivers/scsi/qla2xxx/qla_def.h             |   60 
 b/drivers/scsi/qla2xxx/qla_gbl.h             |   14 
 b/drivers/scsi/qla2xxx/qla_init.c            |   33 
 b/drivers/scsi/qla2xxx/qla_iocb.c            |    3 
 b/drivers/scsi/qla2xxx/qla_isr.c             |   18 
 b/drivers/scsi/qla2xxx/qla_mbx.c             |    6 
 b/drivers/scsi/qla2xxx/qla_os.c              |  149 
 b/drivers/scsi/qlogicfas.c                   |    2 
 b/drivers/scsi/qlogicfas408.c                |   26 
 b/drivers/scsi/qlogicfas408.h                |    2 
 b/drivers/scsi/scsi.c                        |   10 
 b/drivers/scsi/scsi_error.c                  |   42 
 b/drivers/scsi/scsi_lib.c                    |   40 
 b/drivers/scsi/scsi_scan.c                   |   25 
 b/drivers/scsi/scsi_transport_spi.c          |   77 
 b/drivers/scsi/sd.c                          |   36 
 b/drivers/scsi/seagate.c                     |   15 
 b/drivers/scsi/seagate.h                     |    2 
 b/drivers/scsi/sg.c                          |    2 
 b/drivers/scsi/sgiwd93.c                     |    7 
 b/drivers/scsi/st.c                          |   19 
 b/drivers/scsi/sun3x_esp.c                   |    2 
 b/drivers/scsi/sym53c416.c                   |   23 
 b/drivers/scsi/sym53c416.h                   |    3 
 b/drivers/scsi/sym53c8xx_2/sym_defs.h        |    2 
 b/drivers/scsi/sym53c8xx_2/sym_glue.c        |  152 
 b/drivers/scsi/sym53c8xx_2/sym_glue.h        |   27 
 b/drivers/scsi/sym53c8xx_2/sym_hipd.c        |   65 
 b/drivers/scsi/sym53c8xx_2/sym_hipd.h        |   22 
 b/drivers/scsi/sym53c8xx_2/sym_nvram.c       |    7 
 b/drivers/scsi/t128.c                        |    2 
 b/drivers/scsi/t128.h                        |    4 
 b/drivers/scsi/tmscsim.c                     |    6 
 b/drivers/scsi/u14-34f.c                     |    8 
 b/drivers/scsi/ultrastor.c                   |    4 
 b/drivers/scsi/wd7000.c                      |    9 
 b/drivers/usb/storage/scsiglue.c             |    9 
 b/include/linux/blkdev.h                     |    2 
 b/include/linux/chio.h                       |  168 
 b/include/linux/dma-mapping.h                |    5 
 b/include/linux/major.h                      |    1 
 b/include/scsi/scsi.h                        |    4 
 b/include/scsi/scsi_device.h                 |    4 
 b/include/scsi/scsi_host.h                   |   25 
 b/include/scsi/scsi_transport.h              |   38 
 drivers/scsi/pci2000.c                       |  836 ---
 drivers/scsi/pci2220i.c                      | 2915 -------------
 drivers/scsi/pci2220i.h                      |   39 
 drivers/scsi/psi_dale.h                      |  564 --
 drivers/scsi/psi_roy.h                       |  331 -
 189 files changed, 13552 insertions(+), 19322 deletions(-)

James




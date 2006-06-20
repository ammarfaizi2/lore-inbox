Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbWFTVMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbWFTVMt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 17:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWFTVMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 17:12:49 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:29413 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751057AbWFTVMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 17:12:48 -0400
Subject: [GIT PATCH] SCSI updates for 2.6.17
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 20 Jun 2006 16:12:27 -0500
Message-Id: <1150837947.2531.27.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This represents the almost complete SCSI pending list apart from a SAS
port update which we're still trying to beat into shape.  The patch can
be pulled from here:

master.kernel.org:/pub/scm/linux/kernel/git/jejb/scsi-misc-2.6.git

The short changelog is:

Achim Leubner:
  o remove the scsi_request interface from the gdth driver
  o Signed-off-by: Andrew Morton <akpm@osdl.org>

Amit Arora:
  o Return -EINVAL when "id == max_id" in scsi_scan_host_selected()

Andreas Herrmann:
  o zfcp: bump up version number
  o zfcp: make use of fc_remote_port_delete when target port is unavailable
  o zfcp: (cleanup) removed superfluous macros, struct members, typedefs
  o zfcp: (cleanup) kmalloc/kzalloc replacement
  o zfcp: (cleanup) remove useless comments
  o zfcp: (cleanup) shortened copyright and author information

Andrew Morton:
  o scsi_lib.c: fix warning in scsi_kmap_atomic_sg
  o scsi_scan.c: fix compile warnings

Andrew Vasquez:
  o qla2xxx: Update version number to 8.01.05-k2
  o qla2xxx: Correct issue where driver improperly issued SNS commands in N2N topologies
  o qla2xxx: Consolidate firmware-dump handling across ISPs
  o qla2xxx: Consolidate "qla2xxx" string usage to a #define
  o qla2xxx: Use PCI_DEVICE() for pci_device_id definition
  o qla2xxx: Remove obsolete firmware-loader-module support
  o qla2xxx: Remove unused port-type RSCN handling code
  o qla2xxx: Drop unused driver cruft
  o qla2xxx: Add support for alternate WWN NVRAM setting
  o qla2xxx: Correct endianess comparisons during ISP24xx NVRAM configuration
  o qla2xxx: ABBA lock ordering fix
  o qla2xxx: Update ISP24xx firwmare loading heuristics

Arthur Othieno:
  o scsi: remove Documentation/scsi/cpqfc.txt

Christoph Hellwig:
  o remove RQ_SCSI_* flags
  o remove scsi_request infrastructure
  o fix up request buffer reference in various scsi drivers

Guennadi Liakhovetski:
  o Remove last page_address from dc395x.c
  o dc395x: dynamically map scatter-gather for PIO

Hannes Reinecke:
  o audit drivers for incorrect max_id use

HighPoint Linux Team:
  o hptiop: HighPoint RocketRAID 3xxx controller driver
  o hptiop: HighPoint RocketRAID 3xxx controller driver

James Bottomley:
  o 53c700: remove reliance on deprecated cmnd fields
  o hptiop: don't use cmnd->bufflen
  o scsi_transport_sas: fix panic in sas_free_rphy
  o Merge ../linux-2.6
  o spi transport: don't allow dt to be set on SE or HVD buses
  o aic7xxx: expose the bus setting to sysfs
  o fix proc_scsi_write to return "length" on success with remove-single-device case
  o Merge ../scsi-rc-fixes-2.6

Jesper Juhl:
  o fix (unlikely) memory leak in DAC960 driver

Kurt Garloff:
  o BLIST_ATTACH_PQ3 flags
  o Better log messages for PQ3 devs
  o Try LUN 1 and use bflags

Mark Haverkamp:
  o aacraid: small misc. cleanups
  o aacraid: Update supported product information
  o aacraid: Fix return code interpretation
  o aacraid: remove unneeded list
  o aacraid: sa race condition fix
  o aacraid: adjustable timeouts
  o aacraid: optimize sg alloc
  o aacraid: remove unneeded locking

Michael Reed:
  o mptfusion: change driver revision to 3.03.10
  o mptfc: abort of board reset leaves port dead requiring reboot
  o mptfc: fix fibre channel infinite request/response loop
  o mptfc: set fibre channel fw target missing timers to one second
  o mptfusion: move fc event/reset handling to mptfc

Mike Christie:
  o iscsi: update version to 1.0-595
  o iscsi: fix writepsace race
  o iscsi: return task found during search
  o iscsi: fix run list corruption
  o iscsi: don't switch states when just cleaning up
  o iscsi: update version
  o iscsi: fix command requeues during iscsi recovery
  o iscsi: support mutiple daemons
  o iscsi: kill dtask mempools
  o iscsi: only preallocate login buffer
  o iscsi: dont use sendpage for iscsi headers
  o iscsi: dequeue all buffers from queue
  o iscsi: increment expstatsn during login
  o iscsi: fix manamgement task oops
  o iscsi: convert iscsi tcp to libiscsi
  o iscsi: add libiscsi
  o iscsi: fix up iscsi eh
  o iscsi: add sysfs attrs for uspace sync up
  o iscsi: rm kernel iscsi handles usage for session and connection

Or Gerlitz:
  o iscsi: align printks
  o iscsi: add transport end point callbacks

Ralph Wuerthner:
  o zfcp: evaluate plogi payload to set maxframe_size, supported_classes of rports
  o zfcp: print bit error threshold data human readable

Randy Dunlap:
  o imm: no need for unchecked_isa_dma

Ravi Anand:
  o qla2xxx: Use FW calculated residual count for underrun handling
  o qla2xxx: Add support for new flash part
  o qla2xxx: Don't wait for loop transition to complete if LOOP_DEAD state is attained

Sumant Patro:
  o megaraid_sas: switch fw_outstanding to an atomic_t

Tobias Klauser:
  o drivers/scsi: Use ARRAY_SIZE macro

Tomonori FUJITA:
  o ibmvscsi: convert kmalloc + memset to kcalloc

Vivek Goyal:
  o kdump: mpt fusion driver initialization failure fix


And the diffstat:

 Documentation/scsi/cpqfc.txt                |  272 
 b/Documentation/scsi/00-INDEX               |    2 
 b/Documentation/scsi/ChangeLog.megaraid_sas |   13 
 b/Documentation/scsi/aacraid.txt            |    8 
 b/Documentation/scsi/hptiop.txt             |   92 
 b/MAINTAINERS                               |    6 
 b/drivers/block/DAC960.c                    |   13 
 b/drivers/block/cciss_scsi.c                |    6 
 b/drivers/message/fusion/mptbase.c          |  230 
 b/drivers/message/fusion/mptbase.h          |   16 
 b/drivers/message/fusion/mptfc.c            |  394 
 b/drivers/message/fusion/mptscsih.c         |   23 
 b/drivers/message/i2o/i2o_scsi.c            |    4 
 b/drivers/s390/scsi/zfcp_aux.c              |   91 
 b/drivers/s390/scsi/zfcp_ccw.c              |   14 
 b/drivers/s390/scsi/zfcp_dbf.c              |   10 
 b/drivers/s390/scsi/zfcp_def.h              |   68 
 b/drivers/s390/scsi/zfcp_erp.c              |  273 
 b/drivers/s390/scsi/zfcp_ext.h              |   19 
 b/drivers/s390/scsi/zfcp_fsf.c              |  142 
 b/drivers/s390/scsi/zfcp_fsf.h              |   38 
 b/drivers/s390/scsi/zfcp_qdio.c             |   19 
 b/drivers/s390/scsi/zfcp_scsi.c             |   89 
 b/drivers/s390/scsi/zfcp_sysfs_adapter.c    |   14 
 b/drivers/s390/scsi/zfcp_sysfs_driver.c     |   14 
 b/drivers/s390/scsi/zfcp_sysfs_port.c       |   15 
 b/drivers/s390/scsi/zfcp_sysfs_unit.c       |   15 
 b/drivers/scsi/3w-9xxx.c                    |    2 
 b/drivers/scsi/3w-xxxx.c                    |    8 
 b/drivers/scsi/53c700.c                     |  107 
 b/drivers/scsi/53c700.h                     |    2 
 b/drivers/scsi/53c7xx.c                     |   18 
 b/drivers/scsi/Kconfig                      |   10 
 b/drivers/scsi/Makefile                     |    3 
 b/drivers/scsi/NCR5380.c                    |    2 
 b/drivers/scsi/NCR53c406a.c                 |    8 
 b/drivers/scsi/aacraid/aachba.c             |   34 
 b/drivers/scsi/aacraid/aacraid.h            |   10 
 b/drivers/scsi/aacraid/commctrl.c           |    2 
 b/drivers/scsi/aacraid/comminit.c           |    3 
 b/drivers/scsi/aacraid/commsup.c            |    6 
 b/drivers/scsi/aacraid/dpcsup.c             |    6 
 b/drivers/scsi/aacraid/linit.c              |   18 
 b/drivers/scsi/aacraid/rkt.c                |    4 
 b/drivers/scsi/aacraid/rx.c                 |    4 
 b/drivers/scsi/aacraid/sa.c                 |    8 
 b/drivers/scsi/aha1542.c                    |   31 
 b/drivers/scsi/aic7xxx/aic7770.c            |    2 
 b/drivers/scsi/aic7xxx/aic79xx.h            |    2 
 b/drivers/scsi/aic7xxx/aic79xx_core.c       |   14 
 b/drivers/scsi/aic7xxx/aic79xx_osm.c        |   20 
 b/drivers/scsi/aic7xxx/aic79xx_pci.c        |    2 
 b/drivers/scsi/aic7xxx/aic79xx_proc.c       |    4 
 b/drivers/scsi/aic7xxx/aic7xxx.h            |    3 
 b/drivers/scsi/aic7xxx/aic7xxx_core.c       |   12 
 b/drivers/scsi/aic7xxx/aic7xxx_osm.c        |   29 
 b/drivers/scsi/aic7xxx/aic7xxx_pci.c        |   83 
 b/drivers/scsi/aic7xxx/aic7xxx_proc.c       |    4 
 b/drivers/scsi/aic7xxx_old.c                |    2 
 b/drivers/scsi/atp870u.c                    |    4 
 b/drivers/scsi/constants.c                  |   45 
 b/drivers/scsi/dc395x.c                     |  280 
 b/drivers/scsi/dtc.c                        |   18 
 b/drivers/scsi/fd_mcs.c                     |    2 
 b/drivers/scsi/fdomain.c                    |   10 
 b/drivers/scsi/g_NCR5380.c                  |   19 
 b/drivers/scsi/gdth.c                       |  517 -
 b/drivers/scsi/gdth.h                       |    8 
 b/drivers/scsi/gdth_kcompat.h               |   14 
 b/drivers/scsi/gdth_proc.c                  |  245 
 b/drivers/scsi/gdth_proc.h                  |   16 
 b/drivers/scsi/hptiop.c                     | 1493 +++
 b/drivers/scsi/hptiop.h                     |  465 +
 b/drivers/scsi/ibmmca.c                     |   16 
 b/drivers/scsi/ibmvscsi/ibmvscsi.c          |    3 
 b/drivers/scsi/imm.c                        |    8 
 b/drivers/scsi/in2000.c                     |    4 
 b/drivers/scsi/initio.c                     |    3 
 b/drivers/scsi/ipr.c                        |    1 
 b/drivers/scsi/ips.c                        |    4 
 b/drivers/scsi/iscsi_tcp.c                  | 3012 ++----
 b/drivers/scsi/iscsi_tcp.h                  |  190 
 b/drivers/scsi/libata-scsi.c                |    6 
 b/drivers/scsi/libiscsi.c                   | 1702 +++
 b/drivers/scsi/megaraid.c                   |    4 
 b/drivers/scsi/megaraid/megaraid_sas.c      |   26 
 b/drivers/scsi/megaraid/megaraid_sas.h      |    3 
 b/drivers/scsi/ncr53c8xx.c                  |    6 
 b/drivers/scsi/nsp32.c                      |    2 
 b/drivers/scsi/osst.c                       |    4 
 b/drivers/scsi/pas16.c                      |    8 
 b/drivers/scsi/pluto.c                      |    3 
 b/drivers/scsi/qla1280.c                    |    7 
 b/drivers/scsi/qla2xxx/Kconfig              |   45 
 b/drivers/scsi/qla2xxx/Makefile             |   16 
 b/drivers/scsi/qla2xxx/qla_attr.c           |   12 
 b/drivers/scsi/qla2xxx/qla_dbg.c            |   54 
 b/drivers/scsi/qla2xxx/qla_def.h            |  188 
 b/drivers/scsi/qla2xxx/qla_fw.h             |    3 
 b/drivers/scsi/qla2xxx/qla_gbl.h            |   15 
 b/drivers/scsi/qla2xxx/qla_init.c           |  241 
 b/drivers/scsi/qla2xxx/qla_iocb.c           |    2 
 b/drivers/scsi/qla2xxx/qla_isr.c            |   81 
 b/drivers/scsi/qla2xxx/qla_os.c             |  168 
 b/drivers/scsi/qla2xxx/qla_settings.h       |    1 
 b/drivers/scsi/qla2xxx/qla_sup.c            |   93 
 b/drivers/scsi/qla2xxx/qla_version.h        |    4 
 b/drivers/scsi/qlogicpti.c                  |    3 
 b/drivers/scsi/raid_class.c                 |    4 
 b/drivers/scsi/scsi.c                       |  157 
 b/drivers/scsi/scsi.h                       |    1 
 b/drivers/scsi/scsi_devinfo.c               |    2 
 b/drivers/scsi/scsi_error.c                 |   15 
 b/drivers/scsi/scsi_ioctl.c                 |    2 
 b/drivers/scsi/scsi_lib.c                   |  140 
 b/drivers/scsi/scsi_logging.h               |    8 
 b/drivers/scsi/scsi_priv.h                  |   10 
 b/drivers/scsi/scsi_proc.c                  |    9 
 b/drivers/scsi/scsi_scan.c                  |   68 
 b/drivers/scsi/scsi_sysfs.c                 |    8 
 b/drivers/scsi/scsi_transport_fc.c          |    6 
 b/drivers/scsi/scsi_transport_iscsi.c       |  703 +
 b/drivers/scsi/scsi_transport_sas.c         |   18 
 b/drivers/scsi/scsi_transport_spi.c         |   13 
 b/drivers/scsi/scsi_typedefs.h              |    1 
 b/drivers/scsi/sd.c                         |    4 
 b/drivers/scsi/seagate.c                    |    4 
 b/drivers/scsi/sg.c                         |    6 
 b/drivers/scsi/sr.c                         |    2 
 b/drivers/scsi/st.c                         |    2 
 b/drivers/scsi/sym53c8xx_2/sym_glue.c       |    6 
 b/drivers/scsi/sym53c8xx_2/sym_hipd.c       |    3 
 b/drivers/scsi/t128.c                       |   10 
 b/drivers/scsi/wd33c93.c                    |    2 
 b/drivers/scsi/wd7000.c                     |   12 
 b/drivers/usb/image/microtek.c              |   10 
 b/include/linux/blkdev.h                    |    3 
 b/include/scsi/iscsi_if.h                   |  127 
 b/include/scsi/iscsi_proto.h                |    2 
 b/include/scsi/libiscsi.h                   |  282 
 b/include/scsi/scsi_cmnd.h                  |   10 
 b/include/scsi/scsi_dbg.h                   |    2 
 b/include/scsi/scsi_devinfo.h               |    1 
 b/include/scsi/scsi_eh.h                    |    3 
 b/include/scsi/scsi_transport_iscsi.h       |  119 
 drivers/scsi/qla2xxx/ql2100.c               |   91 
 drivers/scsi/qla2xxx/ql2100_fw.c            | 4848 ----------
 drivers/scsi/qla2xxx/ql2200.c               |   91 
 drivers/scsi/qla2xxx/ql2200_fw.c            | 5333 ------------
 drivers/scsi/qla2xxx/ql2300.c               |  114 
 drivers/scsi/qla2xxx/ql2300_fw.c            | 7746 -----------------
 drivers/scsi/qla2xxx/ql2322.c               |  119 
 drivers/scsi/qla2xxx/ql2322_fw.c            | 8376 ------------------
 drivers/scsi/qla2xxx/ql2400.c               |  138 
 drivers/scsi/qla2xxx/ql2400_fw.c            |12346 ----------------------------
 drivers/scsi/qla2xxx/qla_rscn.c             | 1426 ---
 include/scsi/scsi_request.h                 |   54 
 include/scsi/sg_request.h                   |   26 
 158 files changed, 7629 insertions(+), 46291 deletions(-)

James


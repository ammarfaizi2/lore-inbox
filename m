Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbVKEQSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbVKEQSg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 11:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbVKEQSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 11:18:36 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:55497 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1750853AbVKEQSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 11:18:35 -0500
Subject: [GIT PATCH] SCSI updates for 2.6.14
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sat, 05 Nov 2005 10:18:11 -0600
Message-Id: <1131207491.3614.5.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is Part I of the pending SCSI patches (I still need to go over all
the flood that came in after 2.6.14 was declared).

This patch is available from:

master.kernel.org:/pub/scm/linux/kernel/git/jejb/scsi-for-linus-2.6.git

The short changelog is

Alan Stern:
  o sd: Fix refcounting

Alex Aizman:
  o open-iscsi/linux-iscsi-5 Initiator: Initiator code
  o open-iscsi/linux-iscsi-5 Initiator: Kconfig update
  o open-iscsi/linux-iscsi-5 Initiator: Transport class update for iSCSI
  o open-iscsi/linux-iscsi-5 Initiator: Initiator header
  o open-iscsi/linux-iscsi-5 Initiator: Header files
  o open-iscsi/linux-iscsi-5 Initiator: Makefile Updates

Andrew Vasquez:
  o Add an 'Issue LIP' device attribute in fc_transport class
  o qla2xxx: fix compile warning
  o qla2xxx: remove eh_active checks in qla2xxx error handling
  o qla2xxx: Update license
  o qla2xxx: Use midlayer's int_to_scsilun() function
  o qla2xxx: Add support to dynamically enable/disable ZIO
  o qla2xxx: Correct issue where fcport is prematurely marked DEAD

Christoph Hellwig:
  o mptsas: white space fixes and version bump
  o mptsas: add support for PHY resets
  o sas: add support for PHY resets
  o sas: add flag for locally attached PHYs
  o mptsas: support link error attributes
  o scsi_transport_sas: support link error attributes

Guennadi Liakhovetski:
  o dc395x: atomic_kmap for PIO

Jack Hammer:
  o ips: Fix initialization bug with kdump
  o ips: Fix up for correct scatter/gather processing

James Bottomley:
  o Fix ips.c compile
  o Merge by Hand
  o lpfc: Fix for "command completion for iotax x?? not found"
  o remove broken driver cpqfc
  o fix up mismerge in osst
  o qla2xxx: put back label erroneously removed by eh_active patch
  o qla2xxx: fix unnecessary activation of blk tag queue
  o move the mid-layer printk's over to shost/starget/sdev_printk
  o avoid overflows in disk size calculations
  o qla2xxx: Resync with latest released ISP23xx/63xx firmware --
3.03.18
  o Merge HEAD from ../scsi-misc-2.6-old
  o aacraid: Use DMA mask defines
  o move iscsi to a better place in Kconfig
  o iscsi_tcp: make iscsi compile again after recent netlink changes
  o Merge HEAD from ../scsi-iscsi-2.6
  o Merge ../linux-2.6
  o iscsi: fix 64 bit compile warning

James Smart:
  o lpfc: Change version number to 8.1.0
  o lpfc 8.1.0 : Add owner field to struct pci_driver
  o lpfc: Fix eh_ return codes for commands
  o lpfc: Remove unneeded IOCB_t * cast
  o lpfc: Adjust lpfc_scsi_buf allocation
  o lpfc: Replace lpfc_sli_issue_iocb_wait_high_priority
  o lpfc: Remove RPI hash from the driver
  o lpfc: Restore HEX safe bahavior of the sysfs xxx_store functions
  o lpfc: Fix for "Unknown IOCB command Data: x0 x3 x0 x0"
  o lpfc: Fix comments for nodev_tmo
  o lpfc: Add range checking for attributes passed as options at load
time
  o lpfc: Return -EINVAL, -EPERM, and -EIO instead of 0 from sysfs
callbacks
  o lpfc: Update to Emulex hba model names
  o lpfc: Cleanup code in lpfc_get_stats()
  o update fc_transport for removal of block/unblock functions

Jayachandran C:
  o sr: remove dead code
  o Fix issue reported by coverity in drivers/scsi/scsi_ioctl.c

Jeff Garzik:
  o use scmd_id(), scmd_channel() throughout code
  o use sfoo_printk() in drivers
  o use {sdev,scmd,starget,shost}_printk in generic code
  o introduce sfoo_printk, sfoo_id, sfoo_channel helpers
  o kill unused scsi_scan_single_target()

Mark Haverkamp:
  o aacraid: Newer adapter communication iterface support
  o aacraid: remove compiler warning
  o aacraid: fix struct element cpu order
  o aacraid: fix inquiry page

Matthew Wilcox:
  o ncr53c8xx: Cleanup namespace collision with ktimers

Mike Christie:
  o iscsi: add module version
  o iscsi: fix nop-in handling
  o iscsi: rename some proto defs
  o iscsi: add newline to sysfs output
  o iscsi: fix ahs len
  o iscsi: update some iscsi proto defs
  o iscsi: handle nonlinear skbs
  o iscsi: preemt fix and cleanup
  o iscsi: nodelay fix

Ralf Bächle:
  o sgiwd93: small fixes
  o dec_esp: Use the right address space macro
  o dec_esp: Use physical addresses
  o dec_esp: Fix mapping of ESP

And the diffstat (large qla firmware update again, I'm afraid):

 b/Documentation/scsi/LICENSE.qla2xxx   |   45 
 b/drivers/message/fusion/mptbase.h     |   16 
 b/drivers/message/fusion/mptsas.c      |  323 
 b/drivers/scsi/3w-9xxx.c               |    4 
 b/drivers/scsi/3w-xxxx.c               |    4 
 b/drivers/scsi/53c700.c                |   89 
 b/drivers/scsi/53c700.h                |    8 
 b/drivers/scsi/Kconfig                 |   39 
 b/drivers/scsi/Makefile                |    4 
 b/drivers/scsi/NCR5380.c               |   21 
 b/drivers/scsi/NCR53C9x.c              |   16 
 b/drivers/scsi/NCR53c406a.c            |    2 
 b/drivers/scsi/a100u2w.c               |    2 
 b/drivers/scsi/aacraid/README          |    2 
 b/drivers/scsi/aacraid/TODO            |    1 
 b/drivers/scsi/aacraid/aachba.c        |   86 
 b/drivers/scsi/aacraid/aacraid.h       |   27 
 b/drivers/scsi/aacraid/commctrl.c      |    6 
 b/drivers/scsi/aacraid/comminit.c      |   25 
 b/drivers/scsi/aacraid/commsup.c       |   86 
 b/drivers/scsi/aacraid/dpcsup.c        |  115 
 b/drivers/scsi/aacraid/linit.c         |   37 
 b/drivers/scsi/aacraid/rkt.c           |  172 
 b/drivers/scsi/aacraid/rx.c            |  157 
 b/drivers/scsi/aacraid/sa.c            |   38 
 b/drivers/scsi/aha152x.c               |    3 
 b/drivers/scsi/aha1542.c               |    3 
 b/drivers/scsi/aha1740.c               |    2 
 b/drivers/scsi/aic7xxx/aic79xx_osm.c   |   39 
 b/drivers/scsi/aic7xxx/aic7xxx_osm.c   |   32 
 b/drivers/scsi/atp870u.c               |   29 
 b/drivers/scsi/ch.c                    |    4 
 b/drivers/scsi/constants.c             |    5 
 b/drivers/scsi/dc395x.c                |   13 
 b/drivers/scsi/dec_esp.c               |   21 
 b/drivers/scsi/eata.c                  |   56 
 b/drivers/scsi/eata_pio.c              |   21 
 b/drivers/scsi/fd_mcs.c                |    4 
 b/drivers/scsi/fdomain.c               |    4 
 b/drivers/scsi/hosts.c                 |   10 
 b/drivers/scsi/ibmmca.c                |    5 
 b/drivers/scsi/ide-scsi.c              |    2 
 b/drivers/scsi/imm.c                   |    2 
 b/drivers/scsi/in2000.c                |    2 
 b/drivers/scsi/ipr.h                   |    5 
 b/drivers/scsi/ips.c                   |  153 
 b/drivers/scsi/iscsi_tcp.c             | 3642 ++++++++
 b/drivers/scsi/iscsi_tcp.h             |  322 
 b/drivers/scsi/lpfc/lpfc.h             |    4 
 b/drivers/scsi/lpfc/lpfc_attr.c        |  201 
 b/drivers/scsi/lpfc/lpfc_crtn.h        |   21 
 b/drivers/scsi/lpfc/lpfc_ct.c          |   14 
 b/drivers/scsi/lpfc/lpfc_disc.h        |    1 
 b/drivers/scsi/lpfc/lpfc_els.c         |   36 
 b/drivers/scsi/lpfc/lpfc_hbadisc.c     |  124 
 b/drivers/scsi/lpfc/lpfc_init.c        |   69 
 b/drivers/scsi/lpfc/lpfc_mbox.c        |    7 
 b/drivers/scsi/lpfc/lpfc_nportdisc.c   |   21 
 b/drivers/scsi/lpfc/lpfc_scsi.c        |  399 
 b/drivers/scsi/lpfc/lpfc_sli.c         |  525 -
 b/drivers/scsi/lpfc/lpfc_sli.h         |   22 
 b/drivers/scsi/lpfc/lpfc_version.h     |    2 
 b/drivers/scsi/megaraid/megaraid_sas.c |    5 
 b/drivers/scsi/ncr53c8xx.c             |   30 
 b/drivers/scsi/nsp32.c                 |    8 
 b/drivers/scsi/osst.c                  |    6 
 b/drivers/scsi/pcmcia/nsp_cs.c         |   10 
 b/drivers/scsi/pcmcia/sym53c500_cs.c   |    2 
 b/drivers/scsi/ppa.c                   |    2 
 b/drivers/scsi/psi240i.c               |    2 
 b/drivers/scsi/qla2xxx/ql2100.c        |    9 
 b/drivers/scsi/qla2xxx/ql2100_fw.c     |   22 
 b/drivers/scsi/qla2xxx/ql2200.c        |    9 
 b/drivers/scsi/qla2xxx/ql2200_fw.c     |   22 
 b/drivers/scsi/qla2xxx/ql2300.c        |    9 
 b/drivers/scsi/qla2xxx/ql2300_fw.c     |13851 +++++++++++++++----------------
 b/drivers/scsi/qla2xxx/ql2322.c        |    7 
 b/drivers/scsi/qla2xxx/ql2322_fw.c     |14483 ++++++++++++++++-----------------
 b/drivers/scsi/qla2xxx/ql6312.c        |    7 
 b/drivers/scsi/qla2xxx/ql6312_fw.c     |13882 +++++++++++++++----------------
 b/drivers/scsi/qla2xxx/qla_attr.c      |  111 
 b/drivers/scsi/qla2xxx/qla_dbg.c       |   18 
 b/drivers/scsi/qla2xxx/qla_dbg.h       |   23 
 b/drivers/scsi/qla2xxx/qla_def.h       |   36 
 b/drivers/scsi/qla2xxx/qla_fw.h        |   30 
 b/drivers/scsi/qla2xxx/qla_gbl.h       |   31 
 b/drivers/scsi/qla2xxx/qla_gs.c        |   18 
 b/drivers/scsi/qla2xxx/qla_init.c      |   99 
 b/drivers/scsi/qla2xxx/qla_inline.h    |   19 
 b/drivers/scsi/qla2xxx/qla_iocb.c      |   63 
 b/drivers/scsi/qla2xxx/qla_isr.c       |   25 
 b/drivers/scsi/qla2xxx/qla_mbx.c       |   18 
 b/drivers/scsi/qla2xxx/qla_os.c        |  112 
 b/drivers/scsi/qla2xxx/qla_rscn.c      |   23 
 b/drivers/scsi/qla2xxx/qla_settings.h  |   22 
 b/drivers/scsi/qla2xxx/qla_sup.c       |   23 
 b/drivers/scsi/qla2xxx/qla_version.h   |   22 
 b/drivers/scsi/qlogicfas408.c          |    4 
 b/drivers/scsi/scsi.c                  |   26 
 b/drivers/scsi/scsi_debug.c            |   17 
 b/drivers/scsi/scsi_error.c            |   48 
 b/drivers/scsi/scsi_ioctl.c            |   14 
 b/drivers/scsi/scsi_lib.c              |   37 
 b/drivers/scsi/scsi_scan.c             |   37 
 b/drivers/scsi/scsi_transport_fc.c     |  476 -
 b/drivers/scsi/scsi_transport_iscsi.c  | 1394 ++-
 b/drivers/scsi/scsi_transport_sas.c    |   75 
 b/drivers/scsi/scsi_transport_spi.c    |   24 
 b/drivers/scsi/sd.c                    |  114 
 b/drivers/scsi/sg.c                    |   14 
 b/drivers/scsi/sgiwd93.c               |    5 
 b/drivers/scsi/sr.c                    |   17 
 b/drivers/scsi/st.c                    |    9 
 b/drivers/scsi/sym53c416.c             |    2 
 b/drivers/scsi/sym53c8xx_defs.h        |   13 
 b/drivers/scsi/tmscsim.c               |   12 
 b/drivers/scsi/u14-34f.c               |   47 
 b/include/scsi/iscsi_if.h              |  245 
 b/include/scsi/iscsi_proto.h           |  589 +
 b/include/scsi/scsi_device.h           |   22 
 b/include/scsi/scsi_host.h             |    6 
 b/include/scsi/scsi_transport_fc.h     |   33 
 b/include/scsi/scsi_transport_iscsi.h  |  202 
 b/include/scsi/scsi_transport_sas.h    |   27 
 drivers/scsi/cpqfcTS.h                 |   19 
 drivers/scsi/cpqfcTSchip.h             |  238 
 drivers/scsi/cpqfcTScontrol.c          | 2231 -----
 drivers/scsi/cpqfcTSi2c.c              |  493 -
 drivers/scsi/cpqfcTSinit.c             | 2096 ----
 drivers/scsi/cpqfcTSioctl.h            |   94 
 drivers/scsi/cpqfcTSstructs.h          | 1530 ---
 drivers/scsi/cpqfcTStrigger.c          |   33 
 drivers/scsi/cpqfcTStrigger.h          |    8 
 drivers/scsi/cpqfcTSworker.c           | 6516 --------------
 drivers/scsi/sgiwd93.h                 |   24 
 135 files changed, 29959 insertions(+), 37041 deletions(-)

James



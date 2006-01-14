Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750848AbWANTrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbWANTrI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 14:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbWANTrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 14:47:08 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:36764 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1750835AbWANTrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 14:47:06 -0500
Subject: [GIT PATCH] SCSI update for 2.6.15
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Content-Type: text/plain
Date: Sat, 14 Jan 2006 13:46:54 -0600
Message-Id: <1137268015.3579.14.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This should represent the final pieces of SCSI for the merge window.
After this, I'll divide the tree into the main one for post 2.6.16 and
the bugfix one.  The main change is that we've finally incorporated the
Adaptec aic79xx tree into this one.  The good news should be that we
have all the bug fixes and sequencer updates we can get (conversely, if
we still find bugs in the sequencer after this, there's nowhere really
left to go for an update).

The patch is here:

master.kernel.org:/pub/scm/linux/kernel/git/jejb/scsi-misc-2.6.git

The Short Changelog is:

Adrian Bunk:
  o lpfc_scsi.c: make lpfc_get_scsi_buf() static
  o scsi_transport_spi.c: make print_nego() static

Andreas Herrmann:
  o zfcp: transport class adaptations II
  o zfcp: transport class adaptations
  o fc transport: add permanent_port_name fc_host attribute

Andrew Vasquez:
  o qla2xxx: Update version number to 8.01.04-k
  o qla2xxx: Disable port-type RSCN handling via driver state-machine
  o qla2xxx: Kconfig update: Add URL to download firmware images
  o qla2xxx: Correct setting of FDMI supported/current port speed
  o qla2xxx: Correct execution-throttle setting for ISP24xx
  o qla2xxx: Collapse load RISC RAM implementations
  o qla2xxx: Correct swing/emphasis settings for ISP24XX
  o qla2xxx: Correct issue where portstate does not transition during loop-resync
  o qla2xxx: Update firmware-dump procedure for ISP24xx
  o qla2xxx: Re-enable flash-part write protection on ISP24xx boards
  o qla2xxx: Correct excessive delay during LOAD-RISC-RAM mailbox command
  o An OEM noticed that the U6 qla2200 driver would hang for
  o qla2xxx: Use msleep() as delay during ISP polling
  o qla2xxx: Drop noisy 'UNDERRUN' status message
  o qla2xxx: Correct FC4 feature assignment during RFF_ID
  o qla2xxx: Reference proper node/port names in fc_host class
  o qla2xxx: Kconfig: two fixes

Arjan van de Ven:
  o turn most scsi semaphores into mutexes

Christoph Hellwig:
  o remove target parent limitiation
  o fusion: kzalloc / kcalloc conversion
  o fusion: convert semaphores to mutexes
  o mptsas: support basic hotplug
  o sr: split sr_audio_ioctl into specific helpers
  o always handle REQ_BLOCK_PC requests in common code
  o sas: fix removal of devices behind expanders
  o sas: clear parent->rphy in sas_rphy_delete

Chuck Ebbert:
  o Mask capabilities for SCSI-1 CD drive

Eric Moore:
  o fusion - fix pci express bug
  o scsi_transport_sas: mapping the rphy channel equal to the port identifier
  o fusion - mpi header udpate
  o fusion - adding raid support in mptsas
  o fusion - adding support for FC949ES
  o raid_class.c - adding RAID10 and RAID10 defines

Hannes Reinecke:
  o aic79xx: Sequencer update
  o aic79xx: Sanitize inb/outb handling
  o aic79xx: Use struct map_node
  o aic7xxx/aic79xx: New device ids

Jack Hammer:
  o ips: Mode Sense (Caching Page ) fix

James Bottomley:
  o mptfc: need to select transport attrs
  o fix up message/i2o/pci.c
  o aic79xx: bump version to 3.0
  o aic7xxx: fix timer handling bug

Jes Sorensen:
  o sem2mutex 3w-[x9]xxx
  o sem2mutex: scsi_transport_spi.c

Mark Haverkamp:
  o aacraid: README update
  o aacraid: 17 element sg performance update
  o aacraid: better sysfs adapter information
  o aacraid: Fix default FIB size

Mark Salyzyn:
  o I2O: move pci_request_regions() just behind pci_enable_device()

Maxim Shchetynin:
  o zfcp: handle unsolicited status notification lost

Michael Reed:
  o mptfusion - fc transport attributes

Mike Christie:
  o iscsi: use pageslab
  o iscsi: fix 4k stack iscsi setups
  o iscsi: seperate iscsi interface from setup functions
  o iscsi: add high mem support

Petr Vandrovec:
  o Pass proper device from BusLogic to SCSI layer

Tomonori FUJITA:
  o iscsi: data digest page cache usage fix
  o iscsi: whitespace cleanup

Zhenyu Z. Wang:
  o iscsi: host locking fix
  o iscsi: data under/over flow fix


And the diffstat:

 b/Documentation/scsi/aacraid.txt                   |  108 +
 b/drivers/message/fusion/Kconfig                   |    1 
 b/drivers/message/fusion/lsi/mpi.h                 |   10 
 b/drivers/message/fusion/lsi/mpi_cnfg.h            |  158 +-
 b/drivers/message/fusion/lsi/mpi_history.txt       |   77 -
 b/drivers/message/fusion/lsi/mpi_init.h            |    8 
 b/drivers/message/fusion/lsi/mpi_ioc.h             |  122 ++
 b/drivers/message/fusion/lsi/mpi_log_fc.h          |   89 +
 b/drivers/message/fusion/lsi/mpi_log_sas.h         |  162 ++
 b/drivers/message/fusion/lsi/mpi_sas.h             |   30 
 b/drivers/message/fusion/mptbase.c                 |   48 
 b/drivers/message/fusion/mptbase.h                 |   34 
 b/drivers/message/fusion/mptctl.c                  |   12 
 b/drivers/message/fusion/mptfc.c                   |  579 +++++++++
 b/drivers/message/fusion/mptlan.c                  |   14 
 b/drivers/message/fusion/mptsas.c                  |  404 +++++-
 b/drivers/message/fusion/mptscsih.c                |   34 
 b/drivers/message/fusion/mptspi.c                  |   26 
 b/drivers/message/i2o/pci.c                        |   10 
 b/drivers/s390/scsi/zfcp_aux.c                     |    2 
 b/drivers/s390/scsi/zfcp_def.h                     |    4 
 b/drivers/s390/scsi/zfcp_erp.c                     |    2 
 b/drivers/s390/scsi/zfcp_fsf.c                     |   84 +
 b/drivers/s390/scsi/zfcp_fsf.h                     |   13 
 b/drivers/s390/scsi/zfcp_scsi.c                    |  188 ++-
 b/drivers/s390/scsi/zfcp_sysfs_adapter.c           |   15 
 b/drivers/s390/scsi/zfcp_sysfs_port.c              |    4 
 b/drivers/s390/scsi/zfcp_sysfs_unit.c              |    2 
 b/drivers/scsi/3w-9xxx.c                           |    7 
 b/drivers/scsi/3w-9xxx.h                           |    2 
 b/drivers/scsi/3w-xxxx.c                           |    7 
 b/drivers/scsi/3w-xxxx.h                           |    2 
 b/drivers/scsi/BusLogic.c                          |    3 
 b/drivers/scsi/Makefile                            |    2 
 b/drivers/scsi/aacraid/aacraid.h                   |    7 
 b/drivers/scsi/aacraid/commctrl.c                  |    4 
 b/drivers/scsi/aacraid/linit.c                     |   35 
 b/drivers/scsi/aic7xxx/Kconfig.aic7xxx             |    4 
 b/drivers/scsi/aic7xxx/aic79xx.h                   |   39 
 b/drivers/scsi/aic7xxx/aic79xx.reg                 |   60 -
 b/drivers/scsi/aic7xxx/aic79xx.seq                 |  241 +++-
 b/drivers/scsi/aic7xxx/aic79xx_core.c              |  775 ++++++-------
 b/drivers/scsi/aic7xxx/aic79xx_inline.h            |   38 
 b/drivers/scsi/aic7xxx/aic79xx_osm.c               |   62 -
 b/drivers/scsi/aic7xxx/aic79xx_osm.h               |    2 
 b/drivers/scsi/aic7xxx/aic79xx_pci.c               |   24 
 b/drivers/scsi/aic7xxx/aic79xx_pci.h               |    5 
 b/drivers/scsi/aic7xxx/aic79xx_reg.h_shipped       |  646 +++++-----
 b/drivers/scsi/aic7xxx/aic79xx_reg_print.c_shipped |  507 ++++----
 b/drivers/scsi/aic7xxx/aic79xx_seq.h_shipped       | 1250 ++++++++++-----------
 b/drivers/scsi/aic7xxx/aic7xxx_osm.c               |   28 
 b/drivers/scsi/aic7xxx/aic7xxx_osm.h               |   25 
 b/drivers/scsi/aic7xxx/aic7xxx_pci.c               |   24 
 b/drivers/scsi/aic7xxx/aic7xxx_pci.h               |    1 
 b/drivers/scsi/ch.c                                |   33 
 b/drivers/scsi/dpt_i2o.c                           |   45 
 b/drivers/scsi/hosts.c                             |    8 
 b/drivers/scsi/ips.c                               |    3 
 b/drivers/scsi/iscsi_tcp.c                         |  303 ++---
 b/drivers/scsi/iscsi_tcp.h                         |    6 
 b/drivers/scsi/lpfc/lpfc_scsi.c                    |    2 
 b/drivers/scsi/megaraid.c                          |    6 
 b/drivers/scsi/megaraid.h                          |    4 
 b/drivers/scsi/megaraid/megaraid_sas.c             |    7 
 b/drivers/scsi/qla2xxx/Kconfig                     |   24 
 b/drivers/scsi/qla2xxx/Makefile                    |    2 
 b/drivers/scsi/qla2xxx/qla_attr.c                  |    4 
 b/drivers/scsi/qla2xxx/qla_dbg.c                   |  105 -
 b/drivers/scsi/qla2xxx/qla_dbg.h                   |    4 
 b/drivers/scsi/qla2xxx/qla_gbl.h                   |    6 
 b/drivers/scsi/qla2xxx/qla_gs.c                    |    8 
 b/drivers/scsi/qla2xxx/qla_init.c                  |   24 
 b/drivers/scsi/qla2xxx/qla_isr.c                   |   14 
 b/drivers/scsi/qla2xxx/qla_mbx.c                   |  107 -
 b/drivers/scsi/qla2xxx/qla_os.c                    |    6 
 b/drivers/scsi/qla2xxx/qla_sup.c                   |    3 
 b/drivers/scsi/qla2xxx/qla_version.h               |    4 
 b/drivers/scsi/raid_class.c                        |    2 
 b/drivers/scsi/scsi.c                              |   13 
 b/drivers/scsi/scsi_lib.c                          |   16 
 b/drivers/scsi/scsi_priv.h                         |    6 
 b/drivers/scsi/scsi_proc.c                         |   17 
 b/drivers/scsi/scsi_scan.c                         |   32 
 b/drivers/scsi/scsi_sysfs.c                        |    9 
 b/drivers/scsi/scsi_transport_fc.c                 |   26 
 b/drivers/scsi/scsi_transport_iscsi.c              |  859 +++++++-------
 b/drivers/scsi/scsi_transport_sas.c                |   58 
 b/drivers/scsi/scsi_transport_spi.c                |   12 
 b/drivers/scsi/sd.c                                |   63 -
 b/drivers/scsi/sr.c                                |   43 
 b/drivers/scsi/sr_ioctl.c                          |  202 +--
 b/drivers/scsi/st.c                                |   42 
 b/include/linux/pci_ids.h                          |    1 
 b/include/linux/raid_class.h                       |    2 
 b/include/scsi/iscsi_if.h                          |    6 
 b/include/scsi/scsi.h                              |    6 
 b/include/scsi/scsi_cmnd.h                         |    1 
 b/include/scsi/scsi_host.h                         |    3 
 b/include/scsi/scsi_transport.h                    |    7 
 b/include/scsi/scsi_transport_fc.h                 |    4 
 b/include/scsi/scsi_transport_iscsi.h              |   75 +
 b/include/scsi/scsi_transport_spi.h                |    2 
 drivers/scsi/aacraid/README                        |   74 -
 103 files changed, 5111 insertions(+), 3238 deletions(-)

James



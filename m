Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264266AbUFPRcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264266AbUFPRcT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 13:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264271AbUFPRbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 13:31:45 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:60074 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S264266AbUFPRbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 13:31:03 -0400
Subject: [BK PATCH] SCSI updates for 2.6.7
From: James Bottomley <James.Bottomley@steeleye.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 16 Jun 2004 12:30:58 -0500
Message-Id: <1087407060.1747.35.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is mainly just a maintenance patch, with one new driver: the 3ware
9000 SATA RAID.

The patch is available from:

bk://linux-scsi.bkbits.net/scsi-for-linus-2.6

The short changelog is:

Adam Radford:
  o 3ware 9000 schedule_timeout fix
  o 3ware 9000 driver update
  o 2/2 3ware 9000 SATA-RAID driver v2.26.00.009
  o 1/2 3ware 9000 SATA-RAID driver v2.26.00.009

Adrian Bunk:
  o modular scsi/mca_53c9x doesn't work

Alan Cox:
  o Lost 2.4 change for BusLogic info
  o Stop megaraid trashing other i960 based devices

Alan Stern:
  o Make the scsi error handler bus settle delay a per template option

Andrew Morton:
  o scsi_transport_spi.c build fix

Arjan van de Ven:
  o SCSI: replace deprecated hosts.h file

Brian King:
  o ipr operational timeout oops
  o ipr driver version 2.0.8
  o ipr duplicate ioa reset fix
  o ipr scsi busy io hang

Christoph Hellwig:
  o avoid obsolete scsi APIs in eata_pio
  o clean up SCSI_TIMEOUT usage
  o kill dead compat code in advansys
  o update 53c700 to avoid obsolete headers
  o missing forward declarations in scsi_eh.h
  o scsi_dev_flags must be __initdata, not __init
  o remove obsolete API usage from dpt_i2o
  o fix sym53c416 check_region usage
  o fix check_region usage in eata_pio
  o handle NO_SENSE in sd
  o remove sleep_on_timeout usage in megaraid
  o fix dpt_i2o compilation for alpha and sparc
  o move scsi debugging helpers and give them sane names

Dave Jones:
  o SCSI: Correct BELKIN card reader whitelist entry
  o SCSI: more whitelist updates for usb card readers
  o USB / SCSI multi-card reader whitelist updates

Douglas Gilbert:
  o scsi_debug: num_parts, ptype and (re-)scans
  o sg update to 20040516

Eric Dean Moore:
  o MPT Fusion driver 3.01.07 update

Guennadi Liakhovetski:
  o tmscsim: 64-bit cleanup
  o tmscsim: Store pDCB in device->hostdata
  o tmscsim: convert to slave_
  o tmscsim: remove DeviceCnt
  o tmscsim: Update version after "new API"
  o Convert tmcscsim to new probing interfaces
  o SCSI: slave_detach -> slave_destory comment fix

James Bottomley:
  o SCSI: fix uninitialised variable warning
  o Fix endless loop in SCSI SPI transport class
  o Advansys: Add basic highmem/DMA support

Luiz Capitulino:
  o unchecked kmalloc in sr_audio_ioctl()
  o qla1280.c warning fix

Markus Lidel:
  o remove calls of obsolete scsi APIs in i2o_scsi
  o get I2O working with Adaptec's zero channel

Mika Kukkonen:
  o Comment out an unused function in drivers/scsi/wd7000.c

Mike Christie:
  o SCSI: remove extra queue unplug calls

Randy Dunlap:
  o fix check_region usage in eata_pio

Robert T. Johnson:
  o drivers/scsi/megaraid.c: user/kernel pointer bugs

And the diffstat:

 MAINTAINERS                           |   14 
 drivers/message/fusion/isense.c       |    8 
 drivers/message/fusion/linux_compat.h |  189 --
 drivers/message/fusion/mptbase.c      |   18 
 drivers/message/fusion/mptbase.h      |   10 
 drivers/message/fusion/mptctl.c       |   68 -
 drivers/message/fusion/mptlan.c       |   19 
 drivers/message/fusion/mptscsih.c     |   73 -
 drivers/message/fusion/mptscsih.h     |   71 -
 drivers/message/i2o/i2o_block.c       |    8 
 drivers/message/i2o/i2o_config.c      |    2 
 drivers/message/i2o/i2o_core.c        |  159 +-
 drivers/message/i2o/i2o_scsi.c        |   97 -
 drivers/scsi/3w-9xxx.c                | 2153
++++++++++++++++++++++++++++++++++
 drivers/scsi/3w-9xxx.h                |  704 +++++++++++
 drivers/scsi/3w-xxxx.c                |    2 
 drivers/scsi/53c700.c                 |  131 +-
 drivers/scsi/53c700.h                 |   23 
 drivers/scsi/53c7xx.c                 |    2 
 drivers/scsi/BusLogic.c               |    2 
 drivers/scsi/Kconfig                  |   17 
 drivers/scsi/Makefile                 |    1 
 drivers/scsi/NCR53C9x.c               |   13 
 drivers/scsi/NCR53c406a.c             |    2 
 drivers/scsi/NCR_D700.c               |    6 
 drivers/scsi/NCR_Q720.c               |    2 
 drivers/scsi/a2091.c                  |    2 
 drivers/scsi/a3000.c                  |    2 
 drivers/scsi/advansys.c               |  774 +++---------
 drivers/scsi/aha1542.c                |    2 
 drivers/scsi/aha1740.c                |    2 
 drivers/scsi/aic7xxx/aic79xx_osm.h    |    2 
 drivers/scsi/aic7xxx/aic7xxx_osm.h    |    2 
 drivers/scsi/aic7xxx/aiclib.c         |    2 
 drivers/scsi/aic7xxx_old.c            |    2 
 drivers/scsi/amiga7xx.c               |    2 
 drivers/scsi/atari_scsi.c             |    2 
 drivers/scsi/atp870u.c                |    2 
 drivers/scsi/blz1230.c                |    2 
 drivers/scsi/blz2060.c                |    2 
 drivers/scsi/bvme6000.c               |    2 
 drivers/scsi/constants.c              |   24 
 drivers/scsi/cpqfcTScontrol.c         |    2 
 drivers/scsi/cpqfcTSinit.c            |    4 
 drivers/scsi/cpqfcTSworker.c          |    2 
 drivers/scsi/cyberstorm.c             |    2 
 drivers/scsi/cyberstormII.c           |    2 
 drivers/scsi/dc390.h                  |   15 
 drivers/scsi/dc395x.c                 |    2 
 drivers/scsi/dec_esp.c                |    2 
 drivers/scsi/dmx3191d.c               |    2 
 drivers/scsi/dpt_i2o.c                |   57 
 drivers/scsi/dpti.h                   |   24 
 drivers/scsi/dtc.c                    |    2 
 drivers/scsi/eata.c                   |    2 
 drivers/scsi/eata_generic.h           |    2 
 drivers/scsi/eata_pio.c               |  229 +--
 drivers/scsi/fastlane.c               |    2 
 drivers/scsi/fcal.c                   |    2 
 drivers/scsi/fd_mcs.c                 |    2 
 drivers/scsi/fdomain.c                |    2 
 drivers/scsi/g_NCR5380.c              |    2 
 drivers/scsi/gvp11.c                  |    2 
 drivers/scsi/i60uscsi.c               |    2 
 drivers/scsi/ibmmca.c                 |    2 
 drivers/scsi/ide-scsi.c               |    2 
 drivers/scsi/imm.h                    |    2 
 drivers/scsi/in2000.c                 |    2 
 drivers/scsi/ini9100u.c               |    2 
 drivers/scsi/ipr.c                    |   13 
 drivers/scsi/ipr.h                    |    4 
 drivers/scsi/ips.c                    |    2 
 drivers/scsi/jazz_esp.c               |    2 
 drivers/scsi/lasi700.c                |    5 
 drivers/scsi/mac_esp.c                |    2 
 drivers/scsi/mac_scsi.c               |    2 
 drivers/scsi/mca_53c9x.c              |    2 
 drivers/scsi/megaraid.c               |   37 
 drivers/scsi/mvme147.c                |    2 
 drivers/scsi/mvme16x.c                |    2 
 drivers/scsi/ncr53c8xx.c              |    2 
 drivers/scsi/nsp32.c                  |    2 
 drivers/scsi/oktagon_esp.c            |    2 
 drivers/scsi/osst.c                   |    2 
 drivers/scsi/pas16.c                  |    2 
 drivers/scsi/pc980155.c               |    2 
 drivers/scsi/pci2000.c                |    2 
 drivers/scsi/pci2220i.c               |    2 
 drivers/scsi/pcmcia/aha152x_stub.c    |    2 
 drivers/scsi/pcmcia/fdomain_stub.c    |    2 
 drivers/scsi/pcmcia/qlogic_stub.c     |    2 
 drivers/scsi/pluto.c                  |    2 
 drivers/scsi/ppa.h                    |    2 
 drivers/scsi/psi240i.c                |    2 
 drivers/scsi/qla1280.c                |    6 
 drivers/scsi/qla2xxx/qla_os.h         |    2 
 drivers/scsi/qlogicfas.c              |    2 
 drivers/scsi/qlogicfas408.c           |    2 
 drivers/scsi/qlogicfc.c               |    5 
 drivers/scsi/qlogicisp.c              |    2 
 drivers/scsi/scsi.h                   |   63 
 drivers/scsi/scsi_debug.c             |  379 ++++-
 drivers/scsi/scsi_debug.h             |    5 
 drivers/scsi/scsi_devinfo.c           |   11 
 drivers/scsi/scsi_error.c             |   21 
 drivers/scsi/scsi_ioctl.c             |    2 
 drivers/scsi/scsi_lib.c               |    1 
 drivers/scsi/scsi_module.c            |    2 
 drivers/scsi/scsi_pc98.c              |    2 
 drivers/scsi/scsi_scan.c              |    5 
 drivers/scsi/scsi_syms.c              |   12 
 drivers/scsi/scsi_transport_spi.c     |    8 
 drivers/scsi/scsicam.c                |    2 
 drivers/scsi/scsiiom.c                |  104 -
 drivers/scsi/sd.c                     |   10 
 drivers/scsi/seagate.c                |    2 
 drivers/scsi/sg.c                     |   40 
 drivers/scsi/sgiwd93.c                |    2 
 drivers/scsi/sim710.c                 |    5 
 drivers/scsi/sr.c                     |    2 
 drivers/scsi/sr_ioctl.c               |    5 
 drivers/scsi/sr_vendor.c              |    2 
 drivers/scsi/st.c                     |    2 
 drivers/scsi/sun3_scsi.c              |    2 
 drivers/scsi/sun3_scsi_vme.c          |    2 
 drivers/scsi/sun3x_esp.c              |    2 
 drivers/scsi/sym53c416.c              |   85 -
 drivers/scsi/t128.c                   |    2 
 drivers/scsi/tmscsim.c                |  353 +++--
 drivers/scsi/tmscsim.h                |   13 
 drivers/scsi/u14-34f.c                |    2 
 drivers/scsi/ultrastor.c              |    2 
 drivers/scsi/wd33c93.c                |    2 
 drivers/scsi/wd7000.c                 |    5 
 drivers/scsi/zalon.c                  |    2 
 drivers/usb/storage/scsiglue.c        |    3 
 include/linux/i2o.h                   |   14 
 include/linux/pci_ids.h               |    2 
 include/scsi/scsi_dbg.h               |   18 
 include/scsi/scsi_eh.h                |    4 
 include/scsi/scsi_host.h              |    9 
 141 files changed, 4405 insertions(+), 1917 deletions(-)

James



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267516AbUH1SeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267516AbUH1SeU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 14:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267507AbUH1SeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 14:34:20 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:58581 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S267515AbUH1Sco convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 14:32:44 -0400
Subject: [BK PATCH] SCSI updates
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 28 Aug 2004 14:32:30 -0400
Message-Id: <1093717952.3681.23.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one is mainly driver updates and bug fixes, but it does include two
new drivers: the ibmvscsi which is used by the ppc64 hypervisor systems
and the megaraid rewrite.  Finally I've also included the i2o updates
that have been sitting in the mm tree for a while.

The patches are available at:

bk://linux-scsi.bkbits.net/scsi-for-linus-2.6

The short changelog is:

<christian:borntraeger.net>:
  o Add bus dependencies to two scsi drivers

<nacc:us.ibm.com>:
  o scsi/eata_pio: replace schedule_timeout() with msleep()

<praka:pobox.com>:
  o Re: 2.6.8-rc3-mm2:  Debug: sleeping function called from invalid

Adrian Bunk:
  o SCSI gdth: kill #define __devinitdata
  o SCSI nsp32.c: missing parts of inline removal patch
  o let AIC7{9,X}XX_BUILD_FIRMWARE depend on
  o SCSI nsp32.c: remove inlines
  o SCSI dc395x.c: fix inline compile errors
  o drivers/scsi/sg.c kill local jiffies functions
  o another small advansys cleanup
  o SCSI ips: remove inlines
  o update contact address for SCSI megaraid.c

Alan Cox:
  o ipr: Fix assorted dma_addr_t typing errors

Andi Kleen:
  o gcc-3.5 fixes to advansys

Andrew Morton:
  o ipr.c build fix
  o sym_requeue_awaiting_cmds() warning fix
  o eata_pio.c warning fix
  o megaraid build fix
  o sg.c: remove unused sg_jif_to_ms()
  o mptbase.c warning fix

Andrew Vasquez:
  o qla2xxx: Update version
  o qla2xxx: TCQ fixes
  o qla2xxx: Set firmware options fixes
  o qla2xxx: EH host-reset fixes

Andrey Panin:
  o fix qla1280 build on visws

Atul Mukker:
  o Update megaraid to version 2.20.3.1
  o Update to megaraid version 2.20.3.0
  o Add new Megaraid driver version 2.20.0.1

Brian King:
  o Allow TCQ depth to be lowered properly
  o ipr: Don't log adapter shutdown error response code
  o ipr: Set allow_restart for disk devices only
  o ipr: Dead adapter I/O hang fix
  o ipr: Properly enable/disable TCQ
  o ipr: New PCI IDs
  o ipr: Add maintainers email address to comment block
  o ipr: Use kref instead of a kobject
  o ipr: New adapter support
  o ipr: Properly retry aborted reponse
  o ipr: Bump driver version
  o ipr: Use cancel all instead of abort task
  o fix scsi_remove_device locking

Christoph Hellwig:
  o mesh is ppc32-only
  o BKL removal for EH thread startup
  o update scsi_eh_get_sense commentary
  o fix NC5380 locking and delayed work handling
  o clean up some more tmscsim scan logic
  o kill tmscsim ->proc_info
  o switch sd numbering to idr
  o qla1280: update changelog and version
  o qla1280: cleanup qla1280_initialize_adapter
  o qla1280: cleanup qla1280_nvram_config
  o qla1280: cleanup firmware loading, add pio-based loading
  o qla1280: add IS_ISP* helpers
  o qla1280: add ISP1040 register definitions

Dave Boutcher:
  o ibmvscsi driver v1.5.1

Douglas Gilbert:
  o scsi_mid_low_api.txt update
  o scsi_level constants in scsi.h

Eric Dean Moore:
  o fix dma mapping leak in fusion
  o MPT Fusion driver 3.01.10 update

François Romieu:
  o ipr: minor fixes and assorted nit

Guennadi Liakhovetski:
  o tmscsim: remove unused / redundant bios_param
  o tmscsim: (CH) Fix error handling
  o SCSI tmscsim.c: fix inline compile errors
  o tmscsim: MAINTAINERS
  o tmscsim: kernel bugzilla bug #2139

J. A. Magallon:
  o fix aic driver build for db4

James Bottomley:
  o Add internal API to remove reliance on deprecated
SCSI_IOCTL_TEST_UNIT_READY
  o fix sym2 negotiation
  o Add accessor functons for scsi_device 56 byte inquiry data
  o fix for Domain Validation hang on some devices with sym_2
  o get the kernel to warn about deprecated SCSI ioctls
  o Fix the new megaraid compat code to work on all 64 bit systems
  o MPT Fusion driver 3.01.15 update

Jeff Garzik:
  o add ssleep(), kill scsi_sleep()

Jens Axboe:
  o reduce aacraid namespace polution

Joe Korty:
  o Fix double reset in aic7xxx driver

Kenn Humborg:
  o AUTOSENSE bug in NCR5380.c

Mark Haverkamp:
  o aacraid driver update
  o aacraid patch for new device support
  o aacraid reset handler

Markus Lidel:
  o i2o maintainer
  o I2O: removes multiplexer notification and use
  o I2O: fixes compiler warning on x86_64 in i2o_config
  o I2O: run linux/i2o.h and linux/i2o-dev.h through
  o I2O: remove on-demand allocation of Scsi_Host's in
  o I2O: add functionality to scsi_add_device to preset
  o i20 rewrite

Matt Domsch:
  o add MODULE_VERSION to drivers/scsi
  o add MODULE_VERSION to drivers/scsi

Mika Kukkonen:
  o ipr: Sparse warnings fixes
  o warning fix to include/scsi/scsi_device.h

Mike Anderson:
  o reorder call in scsi_remove_host

Nishanth Aravamudan:
  o ipr: replace schedule_timeout() with msleep()

Pawel Sikora:
  o ipr: Use sector_t type in sector_div call

Randy Dunlap:
  o NCR53c406a: fix __setup function
  o fd_mcs: fix __setup function
  o fix imm to build with IMM_DEBUG
  o fix JAZZ_ESP driver config depends

And the diffstat:

 Documentation/i2o/README                |   63 
 Documentation/i2o/ioctl                 |  394 +++
 Documentation/scsi/ChangeLog.megaraid   |  233 +
 Documentation/scsi/megaraid.txt         |   70 
 Documentation/scsi/scsi_mid_low_api.txt |  256 +-
 MAINTAINERS                             |    8 
 drivers/block/scsi_ioctl.c              |    1 
 drivers/message/fusion/Kconfig          |   33 
 drivers/message/fusion/Makefile         |    3 
 drivers/message/fusion/ascq_tbl.c       | 2416 -------------------
 drivers/message/fusion/ascq_tbl.sh      |  109 
 drivers/message/fusion/isense.c         |  119 
 drivers/message/fusion/isense.h         |   95 
 drivers/message/fusion/mptbase.c        | 1068 ++++----
 drivers/message/fusion/mptbase.h        |  166 -
 drivers/message/fusion/mptctl.c         |  171 -
 drivers/message/fusion/mptlan.c         |  154 -
 drivers/message/fusion/mptscsih.c       | 1828 ++++----------
 drivers/message/fusion/scsi3.h          |  707 -----
 drivers/message/fusion/scsiops.c        |  309 --
 drivers/message/i2o/Makefile            |    1 
 drivers/message/i2o/debug.c             |  571 ++++
 drivers/message/i2o/device.c            |  674 +++++
 drivers/message/i2o/driver.c            |  367 ++
 drivers/message/i2o/exec-osm.c          |  505 +++
 drivers/message/i2o/i2o_block.c         | 2355 ++++++++----------
 drivers/message/i2o/i2o_block.h         |   99 
 drivers/message/i2o/i2o_config.c        | 1365 +++++-----
 drivers/message/i2o/i2o_proc.c          | 4058 ++++++++++----------------------
 drivers/message/i2o/i2o_scsi.c          | 1413 ++++-------
 drivers/message/i2o/iop.c               | 1258 +++++++++
 drivers/message/i2o/pci.c               |  513 ++++
 drivers/pci/pci.ids                     |   29 
 drivers/scsi/Kconfig                    |   27 
 drivers/scsi/Makefile                   |    4 
 drivers/scsi/NCR5380.c                  |  222 -
 drivers/scsi/NCR5380.h                  |    3 
 drivers/scsi/NCR53c406a.c               |   10 
 drivers/scsi/aacraid/README             |   14 
 drivers/scsi/aacraid/aachba.c           |   71 
 drivers/scsi/aacraid/aacraid.h          |   25 
 drivers/scsi/aacraid/commctrl.c         |    2 
 drivers/scsi/aacraid/commsup.c          |    2 
 drivers/scsi/aacraid/linit.c            |  179 -
 drivers/scsi/advansys.c                 |   20 
 drivers/scsi/advansys.h                 |   26 
 drivers/scsi/aha1542.c                  |    4 
 drivers/scsi/aic7xxx/Kconfig.aic79xx    |    2 
 drivers/scsi/aic7xxx/Kconfig.aic7xxx    |    2 
 drivers/scsi/aic7xxx/aic79xx_osm.c      |   12 
 drivers/scsi/aic7xxx/aic79xx_pci.c      |    4 
 drivers/scsi/aic7xxx/aic7xxx_osm.c      |   12 
 drivers/scsi/aic7xxx/aic7xxx_pci.c      |    4 
 drivers/scsi/aic7xxx/aicasm/Makefile    |    6 
 drivers/scsi/aic7xxx_old.c              |    9 
 drivers/scsi/arm/cumana_1.c             |    1 
 drivers/scsi/arm/ecoscsi.c              |    1 
 drivers/scsi/arm/fas216.c               |    4 
 drivers/scsi/arm/oak.c                  |    1 
 drivers/scsi/dc390.h                    |   32 
 drivers/scsi/dc395x.c                   |   40 
 drivers/scsi/dmx3191d.c                 |    3 
 drivers/scsi/dtc.c                      |    1 
 drivers/scsi/eata_pio.c                 |    5 
 drivers/scsi/fd_mcs.c                   |   10 
 drivers/scsi/g_NCR5380.c                |    6 
 drivers/scsi/gdth.c                     |    3 
 drivers/scsi/hosts.c                    |    2 
 drivers/scsi/ibmvscsi/Makefile          |    5 
 drivers/scsi/ibmvscsi/ibmvscsi.c        | 1393 ++++++++++
 drivers/scsi/ibmvscsi/ibmvscsi.h        |  108 
 drivers/scsi/ibmvscsi/iseries_vscsi.c   |  144 +
 drivers/scsi/ibmvscsi/rpa_vscsi.c       |  260 ++
 drivers/scsi/ibmvscsi/srp.h             |  225 +
 drivers/scsi/ibmvscsi/viosrp.h          |  126 
 drivers/scsi/imm.c                      |    2 
 drivers/scsi/ipr.c                      |  237 +
 drivers/scsi/ipr.h                      |   24 
 drivers/scsi/ips.c                      |  130 -
 drivers/scsi/mac_scsi.c                 |    1 
 drivers/scsi/megaraid.c                 |   10 
 drivers/scsi/megaraid/Kconfig.megaraid  |   77 
 drivers/scsi/megaraid/Makefile          |    2 
 drivers/scsi/megaraid/mbox_defs.h       |  790 ++++++
 drivers/scsi/megaraid/mega_common.h     |  283 ++
 drivers/scsi/megaraid/megaraid_ioctl.h  |  291 ++
 drivers/scsi/megaraid/megaraid_mbox.c   | 3891 ++++++++++++++++++++++++++++++
 drivers/scsi/megaraid/megaraid_mbox.h   |  268 ++
 drivers/scsi/megaraid/megaraid_mm.c     | 1162 +++++++++
 drivers/scsi/megaraid/megaraid_mm.h     |  102 
 drivers/scsi/nsp32.c                    |    8 
 drivers/scsi/pas16.c                    |    1 
 drivers/scsi/qla1280.c                  | 1026 ++++----
 drivers/scsi/qla1280.h                  |   57 
 drivers/scsi/qla2xxx/ql2100.c           |    1 
 drivers/scsi/qla2xxx/ql2200.c           |    1 
 drivers/scsi/qla2xxx/ql2300.c           |    1 
 drivers/scsi/qla2xxx/ql2322.c           |    1 
 drivers/scsi/qla2xxx/ql6312.c           |    1 
 drivers/scsi/qla2xxx/ql6322.c           |    1 
 drivers/scsi/qla2xxx/qla_init.c         |   10 
 drivers/scsi/qla2xxx/qla_iocb.c         |   16 
 drivers/scsi/qla2xxx/qla_os.c           |    7 
 drivers/scsi/qla2xxx/qla_version.h      |    4 
 drivers/scsi/scsi.c                     |   17 
 drivers/scsi/scsi_error.c               |   63 
 drivers/scsi/scsi_ioctl.c               |   23 
 drivers/scsi/scsi_lib.c                 |   28 
 drivers/scsi/scsi_scan.c                |   25 
 drivers/scsi/scsi_syms.c                |    4 
 drivers/scsi/scsi_sysfs.c               |    8 
 drivers/scsi/scsiiom.c                  |  164 -
 drivers/scsi/sd.c                       |   61 
 drivers/scsi/sg.c                       |   43 
 drivers/scsi/sr.c                       |    2 
 drivers/scsi/sr_ioctl.c                 |    3 
 drivers/scsi/sym53c8xx_2/sym_defs.h     |    3 
 drivers/scsi/sym53c8xx_2/sym_glue.c     |  122 
 drivers/scsi/sym53c8xx_2/sym_glue.h     |    8 
 drivers/scsi/sym53c8xx_2/sym_hipd.c     |  126 
 drivers/scsi/sym53c8xx_2/sym_hipd.h     |   40 
 drivers/scsi/sym53c8xx_2/sym_misc.c     |  118 
 drivers/scsi/sym53c8xx_2/sym_nvram.c    |   16 
 drivers/scsi/t128.c                     |    1 
 drivers/scsi/tmscsim.c                  |  609 ----
 drivers/scsi/tmscsim.h                  |    1 
 include/linux/delay.h                   |    5 
 include/linux/i2o-dev.h                 |  262 --
 include/linux/i2o.h                     |  756 ++++-
 include/linux/pci_ids.h                 |    1 
 include/scsi/scsi.h                     |    9 
 include/scsi/scsi_device.h              |   42 
 include/scsi/scsi_eh.h                  |    1 
 133 files changed, 21254 insertions(+), 14153 deletions(-)



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbWJDVBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbWJDVBX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 17:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbWJDVBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 17:01:23 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:34247 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751121AbWJDVBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 17:01:22 -0400
Subject: [GIT PATCH] scsi updates for post 2.6.18
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 04 Oct 2006 16:01:17 -0500
Message-Id: <1159995678.3437.80.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is (hopefully) my final batch of updates before we go -rc1.  It's
mainly code cleanups, some driver updates and the new qla4xxx iScsi
driver.

The patch is available here:

master.kernel.org:/pub/scm/linux/kernel/git/jejb/scsi-misc-2.6.git

The short changelog is:

Alan Cox:
  o Switch ips to pci_register from pci_module

Alexey Dobriyan:
  o 3w-xxxx: fix "ATA UDMA upgrade" message number

Andrew Morton:
  o scsi: device_reprobe() can fail

Andrew Vasquez:
  o qla2xxx: Update version number to 8.01.07-k2
  o qla2xxx: Stall mid-layer error handlers while rport is blocked
  o qla2xxx: Add MODULE_FIRMWARE tags
  o qla2xxx: Add support for host port state FC transport attribute
  o qla2xxx: Add support for fabric name FC transport attribute
  o qla2xxx: Add support for system hostname FC transport attribute
  o qla2xxx: Add support for symbolic nodename FC transport attribute
  o qla2xxx: Add iIDMA support

Arne Redlich:
  o trivial scsi_execute_async fix

Brian King:
  o ipr: Support attaching SATA devices

David Somayajulu:
  o Initial Commit of qla4xxx

Denis Vlasenko:
  o aic7xxx: fix byte I/O order in ahd_inw

Douglas Gilbert:
  o sg: fixes for large page_size

Ed Lin:
  o stex: add new device (id 0x8650) support
  o stex: cancel unused field in struct req_msg

Eric Sesterhenn:
  o fix scsi_device_types overrun in scsi.c
  o Signedness issue in drivers/scsi/ipr.c
  o Signdness issue in drivers/scsi/osst.c

Eric W. Biederman:
  o megaraid: Use the proper type to hold the irq number

Guennadi Liakhovetski:
  o enable clustering for tmscsim

Henne:
  o scsi: remove hosts.h
  o scsi: Scsi_Cmnd convertion in aic7xxx_old.c
  o scsi: Scsi_Cmnd convertion in arm subtree
  o scsi: Convertion to struct scsi_cmnd in ips-driver

Henrik Kretzschmar:
  o pci_module_init conversion in scsi subsystem
  o scsi: included header cleanup
  o seagate: remove header and convert to struct scsi_cmnd

James Smart:
  o lpfc: don't free mempool if mailbox is busy

Jeff Garzik:
  o raid class: handle component-add errors
  o megaraid_sas: handle thrown errors
  o aic94xx: handle sysfs errors
  o st: fix error handling in module init, sysfs
  o sd: fix module init/exit error handling
  o osst: add error handling to module init, sysfs

Jes Sorensen:
  o qla1280 command timeout

Michal Piotrowski:
  o drivers/message/fusion/linux_compat.h Removal of old code
  o drivers/scsi/gdth.h: removal of old scsi code
  o drivers/scsi/dpt/dpti_i2o.h: removal of old scsi code
  o drivers/scsi/nsp32.h: removal of old scsi code

Mike Christie:
  o scsi_devinfo: scsi2 HP and Hitachi entries
  o scsi_devinfo: add nec iStorage
  o scsi_devinfo: add Tornado
  o scsi_devinfo: add EMC Invista

Muli Ben-Yehuda:
  o aic94xx: require firmware loader

Randy Dunlap:
  o dc395x: fix printk format warning

Sumant Patro:
  o megaraid_sas: sets ioctl timeout and updates version,changelog
  o megaraid_sas: adds tasklet for cmd completion
  o megaraid_sas: prints pending cmds before setting hw_crit_error
  o megaraid_sas: function pointer for disable interrupt
  o megaraid_sas: frame count optimization
  o megaraid_sas: FW transition and q size changes

And the diffstat:

 b/Documentation/scsi/ChangeLog.megaraid_sas |   45 
 b/drivers/message/fusion/linux_compat.h     |    9 
 b/drivers/scsi/3w-9xxx.c                    |    2 
 b/drivers/scsi/3w-xxxx.c                    |    2 
 b/drivers/scsi/3w-xxxx.h                    |    2 
 b/drivers/scsi/Kconfig                      |    7 
 b/drivers/scsi/Makefile                     |    1 
 b/drivers/scsi/a100u2w.c                    |    2 
 b/drivers/scsi/aic7xxx/aic79xx_inline.h     |    3 
 b/drivers/scsi/aic7xxx/aic79xx_osm_pci.c    |    2 
 b/drivers/scsi/aic7xxx/aic7xxx_inline.h     |    3 
 b/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c    |    3 
 b/drivers/scsi/aic7xxx_old.c                |  298 ++--
 b/drivers/scsi/aic94xx/Kconfig              |    1 
 b/drivers/scsi/aic94xx/aic94xx_init.c       |   41 
 b/drivers/scsi/arm/acornscsi.c              |   48 
 b/drivers/scsi/arm/acornscsi.h              |    4 
 b/drivers/scsi/arm/fas216.c                 |   50 
 b/drivers/scsi/arm/fas216.h                 |   36 
 b/drivers/scsi/arm/queue.c                  |   37 
 b/drivers/scsi/arm/queue.h                  |   28 
 b/drivers/scsi/arm/scsi.h                   |    2 
 b/drivers/scsi/dc395x.c                     |    4 
 b/drivers/scsi/dmx3191d.c                   |    2 
 b/drivers/scsi/dpt/dpti_i2o.h               |   10 
 b/drivers/scsi/dpt_i2o.c                    |    2 
 b/drivers/scsi/dpti.h                       |    2 
 b/drivers/scsi/gdth.h                       |   10 
 b/drivers/scsi/ipr.c                        |  687 ++++++++++
 b/drivers/scsi/ipr.h                        |   18 
 b/drivers/scsi/ips.c                        |   91 -
 b/drivers/scsi/ips.h                        |   16 
 b/drivers/scsi/lpfc/lpfc_init.c             |    6 
 b/drivers/scsi/megaraid/mega_common.h       |    2 
 b/drivers/scsi/megaraid/megaraid_sas.c      |  362 ++++-
 b/drivers/scsi/megaraid/megaraid_sas.h      |   22 
 b/drivers/scsi/nsp32.c                      |    2 
 b/drivers/scsi/nsp32.h                      |   42 
 b/drivers/scsi/osst.c                       |  134 +-
 b/drivers/scsi/pcmcia/nsp_cs.c              |    1 
 b/drivers/scsi/qla1280.c                    |    6 
 b/drivers/scsi/qla2xxx/qla_attr.c           |   57 
 b/drivers/scsi/qla2xxx/qla_def.h            |   40 
 b/drivers/scsi/qla2xxx/qla_gbl.h            |    9 
 b/drivers/scsi/qla2xxx/qla_gs.c             |  228 +++
 b/drivers/scsi/qla2xxx/qla_init.c           |   84 +
 b/drivers/scsi/qla2xxx/qla_isr.c            |    4 
 b/drivers/scsi/qla2xxx/qla_mbx.c            |   86 +
 b/drivers/scsi/qla2xxx/qla_os.c             |   48 
 b/drivers/scsi/qla2xxx/qla_version.h        |    2 
 b/drivers/scsi/qla4xxx/Kconfig              |    7 
 b/drivers/scsi/qla4xxx/Makefile             |    5 
 b/drivers/scsi/qla4xxx/ql4_dbg.c            |  197 +++
 b/drivers/scsi/qla4xxx/ql4_dbg.h            |   55 
 b/drivers/scsi/qla4xxx/ql4_def.h            |  586 +++++++++
 b/drivers/scsi/qla4xxx/ql4_fw.h             |  843 +++++++++++++
 b/drivers/scsi/qla4xxx/ql4_glbl.h           |   78 +
 b/drivers/scsi/qla4xxx/ql4_init.c           | 1340 +++++++++++++++++++++
 b/drivers/scsi/qla4xxx/ql4_inline.h         |   84 +
 b/drivers/scsi/qla4xxx/ql4_iocb.c           |  368 +++++
 b/drivers/scsi/qla4xxx/ql4_isr.c            |  797 ++++++++++++
 b/drivers/scsi/qla4xxx/ql4_mbx.c            |  930 ++++++++++++++
 b/drivers/scsi/qla4xxx/ql4_nvram.c          |  224 +++
 b/drivers/scsi/qla4xxx/ql4_nvram.h          |  256 ++++
 b/drivers/scsi/qla4xxx/ql4_os.c             | 1755 ++++++++++++++++++++++++++++
 b/drivers/scsi/qla4xxx/ql4_version.h        |   13 
 b/drivers/scsi/raid_class.c                 |   20 
 b/drivers/scsi/scsi.c                       |    2 
 b/drivers/scsi/scsi_devinfo.c               |   16 
 b/drivers/scsi/scsi_lib.c                   |    2 
 b/drivers/scsi/sd.c                         |   23 
 b/drivers/scsi/seagate.c                    |   24 
 b/drivers/scsi/sg.c                         |   53 
 b/drivers/scsi/st.c                         |  115 +
 b/drivers/scsi/stex.c                       |  197 ++-
 b/drivers/scsi/tmscsim.c                    |   12 
 b/include/linux/raid_class.h                |    5 
 b/include/scsi/scsi_device.h                |    4 
 b/include/scsi/sg.h                         |   59 
 drivers/scsi/hosts.h                        |    2 
 drivers/scsi/seagate.h                      |   19 
 81 files changed, 9920 insertions(+), 774 deletions(-)

James



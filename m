Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267563AbUJRWEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267563AbUJRWEp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 18:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267535AbUJRWEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 18:04:35 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:28805 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S267464AbUJRWDp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 18:03:45 -0400
Subject: [BK PATCH] SCSI updates for 2.6.9
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 18 Oct 2004 17:03:30 -0500
Message-Id: <1098137016.2011.339.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This represents a significant amount of bug fix and clean up work and
driver updates (I'm afraid another large qla2xxx firmware update), plus
one new feature:

- A scsi target abstraction for the transport classes.  This necessarily
adds another element to the sysfs path.  However, it's been cooking in
-mm for over a month now with no reported side effects.

The update is available from

bk://linux-scsi.bkbits.net/scsi-for-linus-2.6

The short changelog is:

<james.smart:emulex.com>:
  o suspending I/Os to a device
  o Allow LLDD's to fail slave alloc (non-existent slave)

<jejb:pashleys.(none)>:
  o ncr53c8xx: Convert to using transport classes
  o add device_configure to the transport classes
  o mcr53c8xx: remove INQUIRY snooping and believe the mid-layer flags
  o ncr53c8xx: move driver local quirks up to scsi blacklist
  o ncr53c8xx: remove integrity checking

<jejb:titanic.il.steeleye.com>:
  o SCSI: fix Suspend I/O block/unblock path
  o 53c700: update driver for host spi class
  o scsi: fix host transport allocations
  o Fix up 3w-xxxx after NULL removal mismerge
  o add channel to struct scsi_target
  o fix SPI transport attributes not showing up in sysfs

<luben_tuikov:adaptec.com>:
  o Adding PCI ID tables to aic7xxx and aic79xxx

Adam Radford:
  o 3ware 5/6/7/8000 driver update
  o 3ware 5/6/7/8000 driver v1.26.02.000

Adrian Bunk:
  o qla2xxx gcc-3.5 fixes

Alan Stern:
  o Let LLD specify INQUIRY length
  o Add BLIST_INQUIRY_36 to all USB blacklist entries

Andi Kleen:
  o scsi: add proper pci id table to aic7xxx

Andrew Morton:
  o psi240i build fix
  o tmscsim.c build fix

Andrew Vasquez:
  o SCSI QLA not working on latest *-mm SN2 (qla_dbg fixes)
  o Fix qla2xxx mismerge
  o [8/8]  qla2xxx: Update version
  o qla2xxx: 23xx/63xx firmware updates
  o [5/8]  qla2xxx: Rework ISR registration
  o [4/8]  qla2xxx: Small fixes
  o qla2xxx: DMA pool/api usage
  o [2/8]  qla2xxx: Dynamic resize of request-q
  o [1/8]  qla2xxx: PCI posting fixes

Arjan van de Ven:
  o mark scsi_add_host __must_check
  o aic79xx hostraid support

Bjorn Helgaas:
  o QLogic ISP2x00: remove needless busyloop

Christoph Hellwig:
  o sparse __iomem annotations for qla2xxx
  o merge scsiiom.c into tmscsim.c
  o fdomain: reduce usage of global variables
  o get rid of obsolete APIs in nsp32
  o get rid of obsolete APIs in BusLogic
  o tmscsim: remove remaining INQUIRY sniffing
  o get rid of obsolete APIs in u14-34f
  o tmscsim: remove superflous global host list
  o merge initio source files
  o a100u2w: cleanups
  o initio: remove obsolete APIs, cleanup
  o qla1280: ISP1020/1040 support
  o merge a100u2w source files
  o tmscsim: back out bogus eeprom reading changes
  o fusion dead code removal
  o fix inia100 dma mapping warnings
  o remove internal queueing from inia100
  o don't mark the initio 9100 driver broken
  o switch fusion to use <linux/list.h> everywhere
  o don't mark aacraid as experimental
  o move scsi_add_host back to where it belongs in aacraid
  o some ncr53c8xx decrufting
  o remove abort,reset methods from host templates
  o kill useless spinlock wrappers in BusLogic
  o fix Scsi_Host leak in BusLogic
  o start removing queue from tmscsim
  o fix aic79xx module_init return value when no hardware
  o allow non-modular mptctl
  o avoid obsolete APIs in eata
  o avoid obsolete APIs in ide-scsi
  o don't include "scsi.h" in scsi_module.c
  o update notcq blacklist
  o refactor tmscsim inititalization code
  o first steps at BusLogic cleanup
  o update dmx3191d to modern pci/scsi probing
  o update NCR5380 comments

Dave Jones:
  o plug leaks in aic7xxx_osm
  o Remove possible reuse of stale pointer in aic7xxx
  o plug leaks in aic79xx
  o Remove redundant freeing code from aic7770

Douglas Gilbert:
  o scsi_mid_low_api.txt update
  o scsi: normalize fixed and descriptor sense data
  o sg jiffy library calls [was: sg kill local jiffies
  o scsi_debug version 1.74

Guennadi Liakhovetski:
  o tmscsim: use block-layer tags
  o tmscsim: remove internal command queue
  o tmscsim: use mid-layer's decision for tag support
  o ST34555N misbehaves on tagged INQUIRY commands - add to blacklist
  o tmscsim: remove redundant code

Jack Hammer:
  o ServeRAID driver ( ips ) Version 7.10.18

James Bottomley:
  o SCSI: Fix problems with non-power-of-two sector size discs
  o Add refcounting to scsi command allocation
  o Fix a100u2w compile error
  o Remove duplicate IDENTIFY from scsi.h
  o complete the bus_addr_t removal from aic7xxx
  o add .module to qla1280 template
  o remove old ifdefs aic7xxx
  o remove old ifdefs aic79xx
  o scsi: Add reset ioctl capability to ULDs
  o advansys build fix
  o fix printk warning in sg.c
  o fix undefined function msleep warning in osst
  o Fix up scsi_test_unit_ready() to work correctly with CD-ROMs
  o Add bus signalling host attribute to spi transport class
  o Make the SPI transport parameters operate at the target level
  o Add host and target transport class abstractions
  o Add scsi_target abstraction and place it in sysfs

Jeremy Higdon:
  o add ability to set device queue depth to mptfusion
  o scsi: add blacklist attribute indicating no ULD attach
  o sg.c to warn about ambiguous data direction

Jesse Barnes:
  o SCSI QLA not working on latest *-mm SN2

Joshua Kwan:
  o Disambiguate esp.c clones

Kai Mäkisara:
  o avoid obsolete "scsi.h" APIs in st

Luben Tuikov:
  o aic7xxx and aic79xx: fix sleeping while holding a lock

Mark Haverkamp:
  o aacraid: Add get container name functionality
  o aacraid: dynamic dev update
  o 2.6.9 aacraid: aac_count fix
  o aacraid: Detect non-committed array

Matthew Wilcox:
  o Add SPI-5 constants to scsi.h
  o sym2 2.1.18k

Maximilian Attems:
  o scsi/sata_sx4: replace schedule_timeout()       with
  o scsi/qla_os: replace schedule_timeout()         with msleep()
  o scsi/qla_init: replace  schedule_timeout() with
  o scsi/sd: replace schedule_timeout() with        msleep()
  o scsi/wd7000: replace schedule_timeout()         with msleep()
  o scsi/osst: replace schedule_timeout()   with msleep()
  o scsi/mesh: replace schedule_timeout()   with msleep()

Mike Miller:
  o cciss: fixes for clustering
  o cciss: SCSI API updates

Olaf Hering:
  o mesh is ppc32-only

Sreenivas Bagalkote:
  o remove config_compat from Megaraid
  o megaraid 2.20.4: Fix a data corruption bug


And the diffstat:

 b/Documentation/scsi/ChangeLog.megaraid   |    6 
 b/Documentation/scsi/scsi_mid_low_api.txt |   52 
 b/drivers/block/cciss.c                   |   88 
 b/drivers/block/cciss_scsi.c              |   53 
 b/drivers/message/fusion/Kconfig          |    2 
 b/drivers/message/fusion/mptbase.c        |  105 
 b/drivers/message/fusion/mptbase.h        |  155 
 b/drivers/message/fusion/mptscsih.c       |  124 
 b/drivers/s390/scsi/zfcp_scsi.c           |   82 
 b/drivers/scsi/3w-xxxx.c                  | 3152 ++-----
 b/drivers/scsi/3w-xxxx.h                  |  151 
 b/drivers/scsi/53c700.c                   |   86 
 b/drivers/scsi/53c700.h                   |   11 
 b/drivers/scsi/BusLogic.c                 |  175 
 b/drivers/scsi/BusLogic.h                 |   44 
 b/drivers/scsi/Kconfig                    |   26 
 b/drivers/scsi/Makefile                   |    2 
 b/drivers/scsi/NCR5380.c                  |   65 
 b/drivers/scsi/NCR_D700.c                 |   25 
 b/drivers/scsi/NCR_Q720.c                 |    8 
 b/drivers/scsi/a100u2w.c                  | 1202 ++
 b/drivers/scsi/a100u2w.h                  |  416 
 b/drivers/scsi/aacraid/aachba.c           |  442 
 b/drivers/scsi/aacraid/aacraid.h          |  153 
 b/drivers/scsi/aacraid/linit.c            |   67 
 b/drivers/scsi/advansys.c                 |    1 
 b/drivers/scsi/aic7xxx/aic7770_osm.c      |    4 
 b/drivers/scsi/aic7xxx/aic79xx.h          |    8 
 b/drivers/scsi/aic7xxx/aic79xx_core.c     |   15 
 b/drivers/scsi/aic7xxx/aic79xx_inline.h   |   10 
 b/drivers/scsi/aic7xxx/aic79xx_osm.c      |  108 
 b/drivers/scsi/aic7xxx/aic79xx_osm.h      |   82 
 b/drivers/scsi/aic7xxx/aic79xx_osm_pci.c  |  149 
 b/drivers/scsi/aic7xxx/aic79xx_pci.c      |   57 
 b/drivers/scsi/aic7xxx/aic79xx_pci.h      |   70 
 b/drivers/scsi/aic7xxx/aic7xxx.h          |   12 
 b/drivers/scsi/aic7xxx/aic7xxx_core.c     |    9 
 b/drivers/scsi/aic7xxx/aic7xxx_osm.c      |  100 
 b/drivers/scsi/aic7xxx/aic7xxx_osm.h      |   81 
 b/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c  |   99 
 b/drivers/scsi/aic7xxx/aic7xxx_pci.c      |   83 
 b/drivers/scsi/aic7xxx/aic7xxx_pci.h      |  124 
 b/drivers/scsi/aic7xxx/aiclib.h           |   39 
 b/drivers/scsi/aic7xxx/cam.h              |    6 
 b/drivers/scsi/aic7xxx_old.c              |    1 
 b/drivers/scsi/dec_esp.c                  |    2 
 b/drivers/scsi/dmx3191d.c                 |  213 
 b/drivers/scsi/eata.c                     |  228 
 b/drivers/scsi/fdomain.c                  |  146 
 b/drivers/scsi/hosts.c                    |   22 
 b/drivers/scsi/ide-scsi.c                 |   24 
 b/drivers/scsi/initio.c                   | 3184 +++++++
 b/drivers/scsi/initio.h                   |  739 +
 b/drivers/scsi/ips.c                      |   26 
 b/drivers/scsi/ips.h                      |   57 
 b/drivers/scsi/jazz_esp.c                 |    2 
 b/drivers/scsi/lasi700.c                  |   20 
 b/drivers/scsi/mac_esp.c                  |    2 
 b/drivers/scsi/mca_53c9x.c                |    2 
 b/drivers/scsi/megaraid/megaraid_mm.c     |    6 
 b/drivers/scsi/megaraid/megaraid_mm.h     |    4 
 b/drivers/scsi/mesh.c                     |   12 
 b/drivers/scsi/ncr53c8xx.c                | 1349 ---
 b/drivers/scsi/ncr53c8xx.h                |    4 
 b/drivers/scsi/nsp32.c                    |  103 
 b/drivers/scsi/nsp32.h                    |    4 
 b/drivers/scsi/osst.c                     |   19 
 b/drivers/scsi/psi240i.c                  |   37 
 b/drivers/scsi/ql1040_fw.h                | 2101 ++++
 b/drivers/scsi/qla1280.c                  |   32 
 b/drivers/scsi/qla2xxx/ql2300_fw.c        |13378 +++++++++++++++---------------
 b/drivers/scsi/qla2xxx/ql2322_fw.c        |12001 +++++++++++++-------------
 b/drivers/scsi/qla2xxx/ql6312_fw.c        |12741 ++++++++++++++--------------
 b/drivers/scsi/qla2xxx/ql6322_fw.c        |11193 ++++++++++++-------------
 b/drivers/scsi/qla2xxx/qla_dbg.c          |   94 
 b/drivers/scsi/qla2xxx/qla_def.h          |   37 
 b/drivers/scsi/qla2xxx/qla_gbl.h          |    3 
 b/drivers/scsi/qla2xxx/qla_init.c         |  226 
 b/drivers/scsi/qla2xxx/qla_inline.h       |   15 
 b/drivers/scsi/qla2xxx/qla_iocb.c         |   15 
 b/drivers/scsi/qla2xxx/qla_isr.c          |  281 
 b/drivers/scsi/qla2xxx/qla_mbx.c          |   41 
 b/drivers/scsi/qla2xxx/qla_os.c           |  466 -
 b/drivers/scsi/qla2xxx/qla_rscn.c         |   31 
 b/drivers/scsi/qla2xxx/qla_sup.c          |   22 
 b/drivers/scsi/qla2xxx/qla_version.h      |    4 
 b/drivers/scsi/qlogicfc.c                 |    8 
 b/drivers/scsi/sata_sx4.c                 |    6 
 b/drivers/scsi/scsi.c                     |   40 
 b/drivers/scsi/scsi_debug.c               |  125 
 b/drivers/scsi/scsi_devinfo.c             |   23 
 b/drivers/scsi/scsi_error.c               |   76 
 b/drivers/scsi/scsi_ioctl.c               |   49 
 b/drivers/scsi/scsi_lib.c                 |  188 
 b/drivers/scsi/scsi_module.c              |    1 
 b/drivers/scsi/scsi_priv.h                |   21 
 b/drivers/scsi/scsi_scan.c                |  317 
 b/drivers/scsi/scsi_sysfs.c               |  192 
 b/drivers/scsi/scsi_transport_fc.c        |  474 -
 b/drivers/scsi/scsi_transport_spi.c       |  263 
 b/drivers/scsi/scsicam.c                  |    9 
 b/drivers/scsi/sd.c                       |   20 
 b/drivers/scsi/sg.c                       |   18 
 b/drivers/scsi/sim710.c                   |   19 
 b/drivers/scsi/sr_ioctl.c                 |   12 
 b/drivers/scsi/st.c                       |  243 
 b/drivers/scsi/st.h                       |    8 
 b/drivers/scsi/sun3x_esp.c                |    2 
 b/drivers/scsi/sym53c8xx_2/sym53c8xx.h    |   35 
 b/drivers/scsi/sym53c8xx_2/sym_conf.h     |   35 
 b/drivers/scsi/sym53c8xx_2/sym_defs.h     |   37 
 b/drivers/scsi/sym53c8xx_2/sym_fw.c       |   37 
 b/drivers/scsi/sym53c8xx_2/sym_fw.h       |   35 
 b/drivers/scsi/sym53c8xx_2/sym_fw1.h      |   35 
 b/drivers/scsi/sym53c8xx_2/sym_fw2.h      |   35 
 b/drivers/scsi/sym53c8xx_2/sym_glue.c     |  316 
 b/drivers/scsi/sym53c8xx_2/sym_glue.h     |   39 
 b/drivers/scsi/sym53c8xx_2/sym_hipd.c     |   58 
 b/drivers/scsi/sym53c8xx_2/sym_hipd.h     |   41 
 b/drivers/scsi/sym53c8xx_2/sym_malloc.c   |   35 
 b/drivers/scsi/sym53c8xx_2/sym_misc.c     |   35 
 b/drivers/scsi/sym53c8xx_2/sym_misc.h     |   35 
 b/drivers/scsi/sym53c8xx_2/sym_nvram.c    |   35 
 b/drivers/scsi/sym53c8xx_2/sym_nvram.h    |   35 
 b/drivers/scsi/sym53c8xx_comm.h           |  358 
 b/drivers/scsi/sym53c8xx_defs.h           |    7 
 b/drivers/scsi/tmscsim.c                  | 2734 ++++--
 b/drivers/scsi/tmscsim.h                  |   96 
 b/drivers/scsi/u14-34f.c                  |   70 
 b/drivers/scsi/wd7000.c                   |    3 
 b/drivers/scsi/zalon.c                    |    7 
 b/include/scsi/scsi.h                     |   19 
 b/include/scsi/scsi_device.h              |   33 
 b/include/scsi/scsi_devinfo.h             |    2 
 b/include/scsi/scsi_eh.h                  |   35 
 b/include/scsi/scsi_host.h                |   21 
 b/include/scsi/scsi_ioctl.h               |    2 
 b/include/scsi/scsi_transport.h           |   24 
 b/include/scsi/scsi_transport_fc.h        |   61 
 b/include/scsi/scsi_transport_spi.h       |   95 
 drivers/scsi/dmx3191d.h                   |   48 
 drivers/scsi/i60uscsi.c                   |  805 -
 drivers/scsi/i91uscsi.c                   | 2672 -----
 drivers/scsi/i91uscsi.h                   |  843 -
 drivers/scsi/ini9100u.c                   |  727 -
 drivers/scsi/ini9100u.h                   |  251 
 drivers/scsi/inia100.c                    |  580 -
 drivers/scsi/inia100.h                    |  533 -
 drivers/scsi/scsiiom.c                    | 1654 ---
149 files changed, 40417 insertions(+), 40891 deletions(-)

James



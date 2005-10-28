Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965033AbVJ1AtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965033AbVJ1AtJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 20:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965031AbVJ1AtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 20:49:08 -0400
Received: from havoc.gtf.org ([69.61.125.42]:4049 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S965027AbVJ1AtH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 20:49:07 -0400
Date: Thu, 27 Oct 2005 20:49:06 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] 2.6.x libata updates
Message-ID: <20051028004906.GA16486@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream' branch of
master.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

Broad changes:
* improved PATA support
* new drivers: pdc_adma, sata_sil24
* vastly improved sata_mv driver (60xx only, alas)
* small cleanups etc.


 Documentation/DocBook/libata.tmpl | 1072 +++++++++++++++++++++++++++++++++++
 drivers/scsi/Kconfig              |   22 
 drivers/scsi/Makefile             |    2 
 drivers/scsi/ahci.c               |   41 -
 drivers/scsi/ata_piix.c           |    4 
 drivers/scsi/libata-core.c        |  876 +++++++++++++++++++----------
 drivers/scsi/libata-scsi.c        |  736 +++++++++++++++++-------
 drivers/scsi/libata.h             |   19 
 drivers/scsi/pdc_adma.c           |  739 ++++++++++++++++++++++++
 drivers/scsi/sata_mv.c            | 1145 +++++++++++++++++++++++++++++++-------
 drivers/scsi/sata_nv.c            |    8 
 drivers/scsi/sata_promise.c       |   26 
 drivers/scsi/sata_qstor.c         |    8 
 drivers/scsi/sata_sil.c           |    6 
 drivers/scsi/sata_sil24.c         |  875 +++++++++++++++++++++++++++++
 drivers/scsi/sata_sis.c           |    4 
 drivers/scsi/sata_svw.c           |    4 
 drivers/scsi/sata_sx4.c           |   29 
 drivers/scsi/sata_uli.c           |    4 
 drivers/scsi/sata_via.c           |    4 
 drivers/scsi/sata_vsc.c           |   14 
 include/linux/ata.h               |   41 +
 include/linux/libata.h            |  113 ++-
 23 files changed, 4973 insertions(+), 819 deletions(-)

Al Viro:
      iomem annotations (sata_nv)
      iomem annotations (ahci)
      iomem annotations (sata_promise)
      enum safety (sata_qstor)
      iomem annotations (sata_sx4)
      iomem annotations (sata_sil)
      iomem annotations (sata_vsc)

Alan Cox:
      ata: re-order speeds sensibly.
      libata: bitmask based pci init functions for one or two ports
      libata: handle early device PIO modes correctly
      Add ide-timing functionality to libata.
      [libata] ata_timing fix

Albert Lee:
      [libata] C/H/S support, for older devices
      libata: indent and whitespace change
      libata: rename host states
      libata: minor whitespace, comment, debug message updates
      [libata scsi] tidy up SCSI lba and xfer len calculations
      [libata scsi] add CHS support to ata_scsi_start_stop_xlat()
      libata CHS: move the initialization of taskfile LBA flags (revise #6)
      libata CHS: calculate read/write commands and protocol on the fly (revise #6)
      libata CHS: reread device identify info (revise #6)

Andy Currid:
      Fix sata_nv handling of NVIDIA MCP51/55

Brett Russ:
      libata: Marvell SATA support (DMA mode) (resend: v0.22)
      libata: Marvell spinlock fixes and simplification
      libata: Marvell function headers
      libata: Marvell endian fix

Douglas Gilbert:
      [libata scsi] add ata_scsi_set_sense helper
      [libata scsi] improve scsi error handling with ata_scsi_set_sense()

Jeff Garzik:
      libata: move EH docs to separate DocBook chapter
      [libata] improve device scan
      [libata] improve device scan even more
      libata: add ata_ratelimit(), use it in AHCI driver irq handler
      libata: ATAPI command completion tweaks and notes
      libata: move atapi_request_sense() to libata-scsi module
      [libata sata_mv] fix warning
      libata: minor cleanups
      [libata pdc_adma] license update, minor cleanup
      libata: turn on block layer clustering
      libata: const-ification bombing run

Mark Lord:
      libata: add new driver pdc_adma for PDC ADMA ATA cards

Randy Dunlap:
      libata kernel-doc fixes

Tejun Heo:
      SATA: rewritten sil24 driver
      sil24: add FIXME comment above ata_device_add
      sil24: remove irq disable code on spurious interrupt
      sil24: add testing for PCI fault
      sil24: move error handling out of hot interrupt path
      sil24: remove PORT_TF
      sil24: replace pp->port w/ ap->ioaddr.cmd_addr
      sil24: fix PORT_CTRL_STAT constants
      sil24: add more comments for constants
      sil24: initialization fix
      libata EH document update
      libata: add ATA exceptions chapter to doc
      sil24: ignore non-error exception irqs
      sil24: remove CMDERR clearing
      sil24: implement proper TF register reading & caching
      sil24: implement tf_read callback
      [libata sata_sil24] nit pickings
      [libata sata_sil24] add support for 3131/3531


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751680AbVLAKBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680AbVLAKBU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 05:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751668AbVLAKBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 05:01:20 -0500
Received: from havoc.gtf.org ([69.61.125.42]:12781 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751360AbVLAKBT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 05:01:19 -0500
Date: Thu, 1 Dec 2005 05:01:17 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: libata queue updated
Message-ID: <20051201100117.GA23762@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the current contents of libata-dev.git#ALL, which is
auto-propagated to Andrew Morton's -mm tree.

http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.15-rc4-libata1.patch.bz2

A lot of this stuff is the 'pata-drivers' branch, which is available for
testing, but not bound for upstream anytime soon.

Alan Cox:
      Add libata CMD/SI680 driver
      [libata] Add PATA driver for Compaq Triflex
      [libata] Add PATA VIA driver.
      [libata] Add driver for PATA AMD/NVIDIA chips.
      libata: Update the AMD driver to support the AMD CS5536.
      libata: Add enablebits support to the triflex driver
      libata: Add enablebits to via driver
      [libata] Add new PATA driver pata_opti
      libata: AMD pata fixes
      libata: Fix opti pci enable bits as with the AMD bug
      libata: Fix enable bits for triflex
      libata: Clean up and fix the VIA PATA libata driver

Albert Lee:
      [libata] add driver for Promise PATA 2027x
      libata-dev-2.6: pdc2027x add ata_scsi_ioctl
      libata-dev-2.6: pdc2027x change comments
      libata-dev-2.6: pdc2027x move the PLL counter reading code
      libata-dev-2.6: pdc2027x PLL input clock detection fix
      libata-dev: Convert pdc2027x from PIO to MMIO
      libata-dev: pdc2027x use "long" for counter data type
      libata-dev: pdc2027x ATAPI DMA lost irq problem workaround
      libata: interrupt driven pio for libata-core
      libata: interrupt driven pio for LLD
      libata irq-pio: add comments and cleanup
      libata irq-pio: rename atapi_packet_task() and comments
      libata irq-pio: simplify if condition in ata_dataout_task()
      libata irq-pio: cleanup ata_qc_issue_prot()
      libata: move atapi_send_cdb() and ata_dataout_task()
      [libata irq-pio] reorganize ata_pio_sector() and __atapi_pio_bytes()
      [libata irq-pio] reorganize "buf + offset" in ata_pio_sector()
      [libata irq-pio] use PageHighMem() to optimize the kmap_atomic() usage
      libata CHS: LBA28/LBA48 optimization (revise #6)
      libata irq-pio: misc fixes
      libata irq-pio: merge the ata_dataout_task workqueue with ata_pio_task workqueue
      libata irq-pio: eliminate unnecessary queuing in ata_pio_first_block()
      libata irq-pio: add read/write multiple support
      libata: pata_pdc2027x minor fix

Erik Benada:
      [libata sata_promise] support PATA ports on SATA controllers

Jeff Garzik:
      [libata] pata_pdc2027x: update for recent ->host_stop() API changes
      [libata pata_pdc2027x] add documentation ref in header; trim trailing whitespace
      [libata irq-pio] build fix
      [libata pdc_adma] update for removal of ATA_FLAG_NOINTR
      [libata pata_sil680] add to Makefile/Kconfig
      libata: Add makefile rules for pata_via driver.
      [libata pdc_adma] fix for new irq-driven PIO code
      [libata] minor updates to PATA drivers
      [libata] constify PCI tables in PATA drivers
      [libata] remove two unused fields from struct ata_port
      [libata ata_piix] cleanup: remove duplicate ata_port_info records
      [libata sata_mv] IRQ PIO build fix
      [libata pata_via] fix warning
      [libata] Print out SATA speed, if link is up
      [libata sata_promise] minor whitespace cleanup

 drivers/scsi/Kconfig         |   52 ++
 drivers/scsi/Makefile        |    6 
 drivers/scsi/ata_piix.c      |   40 --
 drivers/scsi/libata-core.c   |  571 +++++++++++++++++++++-------
 drivers/scsi/libata-scsi.c   |   48 +-
 drivers/scsi/pata_amd.c      |  644 ++++++++++++++++++++++++++++++++
 drivers/scsi/pata_opti.c     |  267 +++++++++++++
 drivers/scsi/pata_pdc2027x.c |  855 +++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/pata_sil680.c   |  361 ++++++++++++++++++
 drivers/scsi/pata_triflex.c  |  267 +++++++++++++
 drivers/scsi/pata_via.c      |  511 +++++++++++++++++++++++++
 drivers/scsi/pdc_adma.c      |    8 
 drivers/scsi/sata_mv.c       |    8 
 drivers/scsi/sata_nv.c       |    4 
 drivers/scsi/sata_promise.c  |   67 ++-
 drivers/scsi/sata_qstor.c    |   11 
 drivers/scsi/sata_sx4.c      |    7 
 drivers/scsi/sata_vsc.c      |    6 
 include/linux/ata.h          |   23 +
 include/linux/libata.h       |   32 -
 include/linux/pci_ids.h      |    8 
 21 files changed, 3539 insertions(+), 257 deletions(-)

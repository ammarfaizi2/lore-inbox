Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932192AbWCAUjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbWCAUjE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 15:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751897AbWCAUjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 15:39:04 -0500
Received: from havoc.gtf.org ([69.61.125.42]:34225 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751182AbWCAUjD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 15:39:03 -0500
Date: Wed, 1 Mar 2006 15:39:01 -0500
From: Jeff Garzik <jeff@garzik.org>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: libata queue contents
Message-ID: <20060301203901.GA6915@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the stuff that's pending for 2.6.17, in the
libata-dev.git#upstream branch.  These changes are also auto-propagated
to Andrew Morton's -mm via the #ALL meta-branch.

Shortlog below.  The shortshort log is:
* Fix: ata_piix port mapping
* Fix: sata_promise hotplug register usage
* Fix: a ton of work improving libata error handling
* Optimization: Use LBA28 on LBA48 drives, where possible
* Feature: add sata_mv 6042 chip support
* Feature: remove artificial max-sector limits on LBA48 drives
* Feature: a ton of work improving libata error handling
* Feature: add PCI ID to sata_sil24 
* Cleanup: move code to new file libata-bmdma.c



Albert Lee:
      libata CHS: LBA28/LBA48 optimization (revise #6)

Jeff Garzik:
      [libata ata_piix] Fix ICH6/7 map value interpretation
      [libata sata_mv] add 6042 support, fix 60xx/50xx EDMA configuration
      [libata scsi] build fix for ATA_FLAG_IN_EH change
      [libata] Move PCI IDE BMDMA-related code to new file libata-bmdma.c.

Luke Kosewski:
      [libata sata_promise] add correct read/write of hotplug registers for SATAII devices

Randy Dunlap:
      
      Various libata documentation updates.

Tejun Heo:
      libata: separate out ata_sata_print_link_status
      ahci: separate out ahci_stop/start_engine
      ahci: separate out ahci_dev_classify
      ata_piix: fix MAP VALUE interpretation for for ICH6/7
      libata: fold __ata_qc_complete() into ata_qc_free()
      libata: make the owner of a qc responsible for freeing it
      libata: fix ata_qc_issue() error handling
      ahci: fix err_mask setting in ahci_host_intr
      libata: add detailed AC_ERR_* flags
      libata: return AC_ERR_* from issue functions
      SCSI: export scsi_eh_finish_cmd() and scsi_eh_flush_done_q()
      libata: implement and apply ata_eh_qc_complete/retry()
      libata: create pio/atapi task queueing wrappers
      ahci: stop engine during hard reset
      ahci: add constants for SRST
      libata: export ata_busy_sleep
      libata: modify ata_dev_try_classify
      libata: new ->probe_reset operation
      libata: implement ata_drive_probe_reset()
      libata: implement standard reset component operations and ->probe_reset
      libata: implement ATA_FLAG_IN_EH port flag
      libata: EH / pio tasks synchronization
      libata: fix ata_std_probe_reset() SATA detection
      libata: separate out sata_phy_resume() from sata_std_hardreset()
      libata: add probeinit component operation to ata_drive_probe_reset()
      libata: implement ata_std_probeinit()
      libata: add ATA_QCFLAG_EH_SCHEDULED
      libata: implement ata_scsi_timed_out()
      libata: use ata_scsi_timed_out()
      libata: kill NULL qc handling from ->eng_timeout callbacks
      ahci: separate out ahci_fill_cmd_slot()
      libata: make new reset act identical to ->phy_reset register-wise
      libata: kill SError clearing in sata_std_hardreset().
      sata_sil: convert to new reset mechanism
      sata_sil24: convert to new reset mechanism
      sata_sil24: add hardreset
      libata: inline ata_qc_complete()
      ahci: make ahci_fill_cmd_slot() take *pp instead of *ap
      ahci: convert to new reset mechanism
      libata: convert assert(X)'s in libata core layer to WARN_ON(!X)'s
      libata: convert assert(xxx)'s in low-level drivers to WARN_ON(!xxx)'s
      libata: kill assert() macro
      libata: allow ->probe_reset to return ATA_DEV_UNKNOWN
      ata_piix: kill spurious assignment in piix_sata_probe()
      libata: implement ata_dev_id_c_string()
      libata: use ata_dev_id_c_string()
      libata: separate out ata_id_n_sectors()
      libata: separate out ata_id_major_version()
      libata: make ata_dump_id() take @id instead of @dev
      libata: don't do EDD handling if ->probe_reset is used
      libata: make ata_dev_knobble() per-device
      libata: move cdb_len for host to device
      libata: add per-device max_sectors
      libata: kill sht->max_sectors
      libata: rename ata_dev_id_[c_]string()
      libata: update ata_dev_init_params()
      libata: fix comment regarding setting cable type
      ata_piix: convert pata to new reset mechanism
      ata_piix: convert sata to new reset mechanism
      libata: separate out ata_dev_read_id()
      libata: kill ata_dev_reread_id()
      sata_sil24: add a new PCI ID for SiI 3124
      libata: kill illegal kfree(id)
      sata_sil: remove unneeded ATA_FLAG_SRST from 3512 port info

 drivers/scsi/Makefile       |    2 
 drivers/scsi/ahci.c         |  196 ++--
 drivers/scsi/ata_piix.c     |  133 +--
 drivers/scsi/libata-bmdma.c |  703 +++++++++++++++
 drivers/scsi/libata-core.c  | 1942 +++++++++++++++++++-------------------------
 drivers/scsi/libata-scsi.c  |  238 +++--
 drivers/scsi/libata.h       |    2 
 drivers/scsi/pdc_adma.c     |    6 
 drivers/scsi/sata_mv.c      |  279 +++++-
 drivers/scsi/sata_nv.c      |    2 
 drivers/scsi/sata_promise.c |  127 +-
 drivers/scsi/sata_qstor.c   |   10 
 drivers/scsi/sata_sil.c     |   37 
 drivers/scsi/sata_sil24.c   |   89 --
 drivers/scsi/sata_sis.c     |    2 
 drivers/scsi/sata_svw.c     |    2 
 drivers/scsi/sata_sx4.c     |   25 
 drivers/scsi/sata_uli.c     |    2 
 drivers/scsi/sata_via.c     |    2 
 drivers/scsi/sata_vsc.c     |    2 
 drivers/scsi/scsi_error.c   |    7 
 include/linux/ata.h         |   22 
 include/linux/libata.h      |  146 ++-
 include/scsi/scsi_eh.h      |    3 
 24 files changed, 2454 insertions(+), 1525 deletions(-)

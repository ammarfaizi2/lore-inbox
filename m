Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262370AbVCPAy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbVCPAy5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 19:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262265AbVCPAyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 19:54:47 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:56267 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262171AbVCPAxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 19:53:44 -0500
Subject: [BK PATCH] SCSI updates for 2.6.11
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Tue, 15 Mar 2005 18:53:30 -0600
Message-Id: <1110934411.5685.39.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is my current tranch of patches that were waiting the transition
from -rc to released (sorry it's late ... I've been on holiday).

The patch is available here:

bk://linux-scsi.bkbits.net/scsi-for-linus-2.6

The short log is:

Adrian Bunk:
  o SCSI NCR_D700.c: make some code static
  o SCSI sim710.c: make some code static

Alan Stern:
  o Add a NOREPORTLUN blacklist flag
  o Retry supposedly "unrecoverable" hardware errors

Andi Kleen:
  o Fix selection of command serial numbers and pids
  o Add compat_ioctl to mptctl
  o Convert megaraid2 to compat_ioctl
  o Add compat_ioctl to SG
  o Convert aacraid to compat_ioctl
  o Add compat_ioctl to osst
  o Add comment for compat_ioctl to SR
  o Add compat_ioctl to st
  o Add compat_ioctl to SD

Andrew Morton:
  o st msleep warning fix

Andrew Vasquez:
  o target code updates to support scanned targets

Brian King:
  o ipr: Handle new RAID 6 errors
  o ipr: Bump driver version to 2.0.13
  o ipr: Send uevent change notifications
  o ipr: Sparse fixes
  o ipr: Use bitwise types
  o ipr: Remove tcq_active flag from resource entry
  o ipr: Remove resource qdepth field
  o ipr: Remove tcq_enable device attribute
  o ipr: Use change queue type API
  o ipr: Fast failure module options
  o ipr: Support dynamic IDs
  o ipr: Setup max_sectors based on device type
  o ipr: Device remove cleanup
  o ipr: New adapter support
  o ipr: PCI ID table update
  o PCI: update ipr PCI ids

Christoph Hellwig:
  o mark qlogicisp broken
  o mark eata_pio broken
  o qla1280: update changelog
  o qla1280: use pci_map_single
  o qla1280: remove qla1280_proc_info
  o drop some attibutes from the FC transport class

Dave Jones:
  o blacklist microtek scanmaker III

Eric Moore:
  o mptfusion: delete watchdogs timers from mptctl and mptscsih

Guennadi Liakhovetski:
  o dc395x: Fix support for highmem

James Bottomley:
  o FC Remote Port Patch
  o SCSI: dc395x.c add missing #include <linux/vmalloc.h>
  o SCSI: fix transport statistics mismerge
  o Add statistics to generic transport class
  o SCSI: revamp target scanning routines
  o SCSI: fix io statistics compile warnings
  o SCSI: Add device io statistics
  o SCSI: fix compat_ioctl compile warnings

James Smart:
  o add per scsi-host workqueues for defered processing

Kai Mäkisara:
  o SCSI tape security: require CAP_ADMIN for SG_IO etc
  o SCSI tape fixes: remove f_pos handling
  o SCSI tape fixes (new version): sense descriptor
  o SCSI tape fixes: sense descriptor init, bsf->weof, blkno,
  o SCSI tape: write filemark before rewind etc. when writing
  o SCSI tape descriptor based sense data support

Kenn Humborg:
  o NCR5380 delayed work fix and locking fix

Mark Haverkamp:
  o aacraid: adapter naming fix

Matthew Wilcox:
  o sym2 version 2.2.0
  o Use spi_display_xfer_agreement() in 53c700
  o Display SPI transfer agreement in common code
  o scsi: remove device_request_lock

Mike Anderson:
  o SCSI: Add TASK_ABORTED to status_byte macro

And the diffstat is:

 b/Documentation/kernel-parameters.txt   |    3 
 b/Documentation/scsi/st.txt             |    5 
 b/Documentation/scsi/sym53c8xx_2.txt    |    2 
 b/drivers/base/transport_class.c        |   24 
 b/drivers/message/fusion/mptbase.h      |   10 
 b/drivers/message/fusion/mptctl.c       |  630 +++++---------
 b/drivers/message/fusion/mptscsih.c     |  185 +---
 b/drivers/pci/pci.ids                   |    7 
 b/drivers/scsi/53c700.c                 |   16 
 b/drivers/scsi/Kconfig                  |    4 
 b/drivers/scsi/NCR5380.c                |   15 
 b/drivers/scsi/NCR_D700.c               |    4 
 b/drivers/scsi/aacraid/linit.c          |  115 +-
 b/drivers/scsi/dc395x.c                 |   49 -
 b/drivers/scsi/hosts.c                  |   41 
 b/drivers/scsi/ipr.c                    |  248 +++--
 b/drivers/scsi/ipr.h                    |  201 ++--
 b/drivers/scsi/megaraid/megaraid_mm.c   |   26 
 b/drivers/scsi/osst.c                   |   19 
 b/drivers/scsi/qla1280.c                |  146 ---
 b/drivers/scsi/scsi.c                   |  105 ++
 b/drivers/scsi/scsi_devinfo.c           |    4 
 b/drivers/scsi/scsi_error.c             |   13 
 b/drivers/scsi/scsi_lib.c               |   61 +
 b/drivers/scsi/scsi_scan.c              |  266 ++++--
 b/drivers/scsi/scsi_sysfs.c             |  188 +---
 b/drivers/scsi/scsi_transport_fc.c      | 1092 ++++++++++++++++++++-----
 b/drivers/scsi/scsi_transport_iscsi.c   |   30 
 b/drivers/scsi/scsi_transport_spi.c     |  213 +++--
 b/drivers/scsi/sd.c                     |   39 
 b/drivers/scsi/sg.c                     |   26 
 b/drivers/scsi/sim710.c                 |    6 
 b/drivers/scsi/sr.c                     |    4 
 b/drivers/scsi/st.c                     |  426 +++++-----
 b/drivers/scsi/st.h                     |   19 
 b/drivers/scsi/sym53c8xx_2/Makefile     |    2 
 b/drivers/scsi/sym53c8xx_2/sym53c8xx.h  |   60 +
 b/drivers/scsi/sym53c8xx_2/sym_defs.h   |    4 
 b/drivers/scsi/sym53c8xx_2/sym_fw.c     |    2 
 b/drivers/scsi/sym53c8xx_2/sym_glue.c   |  628 +++++---------
 b/drivers/scsi/sym53c8xx_2/sym_glue.h   |  299 -------
 b/drivers/scsi/sym53c8xx_2/sym_hipd.c   | 1354 +++++++++++++++-----------------
 b/drivers/scsi/sym53c8xx_2/sym_hipd.h   |  231 ++---
 b/drivers/scsi/sym53c8xx_2/sym_malloc.c |  124 +-
 b/drivers/scsi/sym53c8xx_2/sym_nvram.c  |   94 +-
 b/drivers/scsi/sym53c8xx_2/sym_nvram.h  |   11 
 b/include/linux/pci_ids.h               |    1 
 b/include/linux/transport_class.h       |   18 
 b/include/scsi/scsi.h                   |    6 
 b/include/scsi/scsi_cmnd.h              |    3 
 b/include/scsi/scsi_device.h            |   17 
 b/include/scsi/scsi_devinfo.h           |    1 
 b/include/scsi/scsi_host.h              |   33 
 b/include/scsi/scsi_transport.h         |   14 
 b/include/scsi/scsi_transport_fc.h      |  207 +++-
 b/include/scsi/scsi_transport_spi.h     |    1 
 drivers/scsi/sym53c8xx_2/sym_conf.h     |  110 --
 drivers/scsi/sym53c8xx_2/sym_misc.c     |  111 --
 58 files changed, 3991 insertions(+), 3582 deletions(-)

James



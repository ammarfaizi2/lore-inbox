Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbUC0C2P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 21:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbUC0C2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 21:28:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61569 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261648AbUC0C1o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 21:27:44 -0500
Message-ID: <4064E691.2070009@pobox.com>
Date: Fri, 26 Mar 2004 21:27:29 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-ide@vger.kernel.org
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [sata] libata update
Content-Type: multipart/mixed;
 boundary="------------080903020300010206010505"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080903020300010206010505
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


More work on libata...  human-readable summary:
* scsi portion of command submission path now a lot more lightweight. 
Should reduce CPU usage a bit.
* improved documentation (see below)
* New SiS SATA driver.
* Promise: minor improvements in locking, error handling, and 
initialization.  Promise users, please test.
* Intel ICH5:  minor improvements in probing and combined mode handling. 
  Intel users, please test.

This is going to Linus after 2.6.5 is released.

BK repositories:
	http://gkernel.bkbits.net/libata-2.[46]

Patches:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.4.25-libata15.patch.bz2
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.5-rc2-bk6-libata2.patch.bz2

And also, there are some PDF docs generated from the source code. 
Although this is always available via "make pdfdocs", I also post this 
document at
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/libata.pdf


I have attached the short and long changelogs for the above patches, 
versus upstream 2.6.x.




--------------080903020300010206010505
Content-Type: text/plain;
 name="changelog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="changelog.txt"


<uwe.koziolek:gmx.net>:
  o [libata] Add driver for SiS 964/180 SATA

Jeff Garzik:
  o [libata sata_promise] better locking and error handling
  o [libata] more documentation
  o [libata] more cmd queue path cleanups
  o [libata] more command queue path cleanup
  o [libata] clean up command queue/submit path a bit
  o [libata sata_promise] minor initialization updates
  o [libata] documentation, and a couple tiny cleanups
  o [libata] use scsi host lock
  o [libata] reduce diff with 2.4 libata backport
  o [libata] pci_dma_error() was renamed to pci_dma_mapping_error()
  o [ata] move some generic stuff linux/libata.h -> linux/ata.h
  o [libata] consolidate data transfer mode handling
  o [libata] set up some of the per-command data beforehand
  o [libata sata_promise] check for PATA port on PDC20375
  o [libata ata_piix] fix combined mode device detection
  o [libata ata_piix] clean up combined mode handling
  o [libata ata_piix] do not disable SATA port on module unload
  o [libata] use kmap_atomic() rather than kmap()
  o [libata] use new pci_dma_error() to check for pci_map_single() failure
  o [libata sata_sis] minor cleanups


--------------080903020300010206010505
Content-Type: text/plain;
 name="changelog-long.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="changelog-long.txt"

ChangeSet@1.1694, 2004-03-26 20:40:58-05:00, jgarzik@redhat.com
  [libata sata_promise] better locking and error handling
  
  * Prefer spin_lock() to spin_lock_irq() in interrupt handler
  * Reset each port, before probing the SATA phy
  * Reset port when every time an error occurs

ChangeSet@1.1673.6.13, 2004-03-26 18:02:34-05:00, jgarzik@redhat.com
  [libata] more documentation
  
  libata-scsi.c should now be fully documented.

ChangeSet@1.1673.6.12, 2004-03-26 04:04:17-05:00, jgarzik@redhat.com
  [libata] more cmd queue path cleanups
  
  Final part in tonight's series of changes to clean up the
  command queueing path.
  
  The simulate-ATA-over-SCSI code is moved to a new function,
  ata_scsi_simulate(), and ata_scsi_rw_queue() is renamed to
  ata_scsi_translate().  With the SCSI CDB debugging dump function
  also moved into its own function, the queue-command path is now
  nice, compact, and readable.

ChangeSet@1.1673.6.11, 2004-03-26 03:32:10-05:00, jgarzik@redhat.com
  [libata] more command queue path cleanup
  
  A new helper ata_scsi_xlat_possible(), and the command queue path
  gets a bit more compact.
  
  As side effects we kill the 'cmd_size' argument from two functions,
  and mark ata_scsi_rw_queue() as static, as its only needed 
  in libata-scsi.c.

ChangeSet@1.1673.6.10, 2004-03-26 03:20:47-05:00, jgarzik@redhat.com
  [libata] clean up command queue/submit path a bit
  
  This change is part of a series that compartmentalizes and consolidates
  ATA taskfile submission.
  
  Here, the device-location-related checks are moved out of the ->queuecommand()
  hook and into an inline helper function.

ChangeSet@1.1673.6.9, 2004-03-26 01:13:20-05:00, jgarzik@redhat.com
  [libata sata_promise] minor initialization updates
  
  * remove incorrect PATA port check
  * enable undocumented bit 13 in flash control register,
    because the Promise driver does so.
  * wait 10 ms after setting TBG mode, for the same reason.

ChangeSet@1.1673.6.8, 2004-03-25 17:23:41-05:00, jgarzik@redhat.com
  [libata] documentation, and a couple tiny cleanups
  
  Add more per-function source code documentation.  Some of this stuff
  is esoteric ATA crapola, and definitely needed to be documented.
  
  Also, two tiny cleanups spotted while documenting:
  * kill unused arg from internal function ata_dev_try_classify()
  * kill unused return value from ata_dev_id_string()

ChangeSet@1.1673.6.7, 2004-03-25 14:40:17-05:00, jgarzik@redhat.com
  [libata] use scsi host lock
  
  In 2.4 we release io_request_lock and take our own per-host lock,
  in the ->queuecommand() hook.  In 2.6, the SCSI layer provides a
  useful to simply use the lock we already have, via scsi_assign_lock().

ChangeSet@1.1673.6.6, 2004-03-25 14:36:59-05:00, jgarzik@redhat.com
  [libata] reduce diff with 2.4 libata backport

ChangeSet@1.1673.6.5, 2004-03-25 14:36:27-05:00, jgarzik@redhat.com
  [libata] pci_dma_error() was renamed to pci_dma_mapping_error()

ChangeSet@1.1643.1.215, 2004-03-25 01:57:34-05:00, jgarzik@redhat.com
  [ata] move some generic stuff linux/libata.h -> linux/ata.h
  
  struct ata_taskfile is generic, and so far its flags (ATA_TFLAG_xxx)
  
  Also, move ATA_PROT_xxx definitions into their own enum.

ChangeSet@1.1643.1.214, 2004-03-25 01:44:08-05:00, jgarzik@redhat.com
  [libata] consolidate data transfer mode handling
  
  The various ways you can send data to/from your ATA device is
  known as the ATA taskfile protocol:  PIO single sector, PIO
  multiple sector, DMA, DMA TCQ, DMA NCQ, ...
  
  Prior to this change, the data direction (read/write) was encoded
  implicitly into the ATA_PROT_xxx value itself.  This increased
  complexity in some areas, and inhibited flexibility in others.
  
  This change separates data direction from taskfile protocol, and also
  moves the data direction flag (ATA_QCFLAG_WRITE) down to a lower
  level (ATA_TFLAG_WRITE).

ChangeSet@1.1643.1.213, 2004-03-25 00:53:07-05:00, jgarzik@redhat.com
  [libata] set up some of the per-command data beforehand
  
  The data transfer mode and the set of read/write commands we generate
  during normal operation remains constant until we change the data
  transfer mode.
  
  This removes a series of branches in the read/write fast path,
  and in general cleans up that particular spot of code.

ChangeSet@1.1643.1.212, 2004-03-24 23:50:34-05:00, jgarzik@redhat.com
  [libata sata_promise] check for PATA port on PDC20375
  
  We don't handle it yet, but this prints out a message in its presence,
  permitting verification of the check and informing users why their
  PATA device is not recognized.

ChangeSet@1.1643.1.211, 2004-03-23 12:35:54-05:00, jgarzik@redhat.com
  [libata ata_piix] fix combined mode device detection
  
  SATA port detection should not have assumed that a single SATA port
  mapped to a single struct ata_port.  Combined mode breaks this
  assumption.
  
  Change code to simply detect if one or more devices are present
  on the struct ata_port, which is what we really wanted to do.

ChangeSet@1.1643.1.210, 2004-03-23 11:52:00-05:00, jgarzik@redhat.com
  [libata ata_piix] clean up combined mode handling

ChangeSet@1.1643.1.209, 2004-03-23 11:14:06-05:00, jgarzik@redhat.com
  [libata ata_piix] do not disable SATA port on module unload
  
  We were disabling the SATA port, but not enabling it on module load.
  So, modprobe+rmmod+modprobe would fail.

ChangeSet@1.1643.1.208, 2004-03-23 09:20:14-05:00, jgarzik@redhat.com
  [libata] use kmap_atomic() rather than kmap()

ChangeSet@1.1643.1.207, 2004-03-22 23:40:01-05:00, jgarzik@redhat.com
  [libata] use new pci_dma_error() to check for pci_map_single() failure

ChangeSet@1.1643.39.2, 2004-03-21 12:15:16-05:00, jgarzik@redhat.com
  [libata sata_sis] minor cleanups

ChangeSet@1.1643.39.1, 2004-03-21 11:55:35-05:00, uwe.koziolek@gmx.net
  [libata] Add driver for SiS 964/180 SATA.


--------------080903020300010206010505--


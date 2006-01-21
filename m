Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932378AbWAUVkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbWAUVkO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 16:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWAUVkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 16:40:14 -0500
Received: from admingilde.org ([213.95.32.146]:13030 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S932388AbWAUVkM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 16:40:12 -0500
Date: Sat, 21 Jan 2006 22:40:11 +0100
From: Martin Waitz <tali@admingilde.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] DocBook: fix some comments in drivers/scsi
Message-ID: <20060121214011.GD30777@admingilde.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update some kernel-doc comments to match the code

Signed-off-by: Martin Waitz <tali@admingilde.org>

---

 drivers/scsi/ata_piix.c    |    1 +
 drivers/scsi/libata-core.c |   31 +++++++++++++++++--------------
 drivers/scsi/libata-scsi.c |    2 ++
 3 files changed, 20 insertions(+), 14 deletions(-)

9ef1bc69154d1f4c7376b4bc676f3370aa79b303
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index fc3ca05..1dac098 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -627,6 +627,7 @@ static int piix_disable_ahci(struct pci_
 
 /**
  *	piix_check_450nx_errata	-	Check for problem 450NX setup
+ *	@ata_dev: the PCI device to check
  *	
  *	Check for the present of 450NX errata #19 and errata #25. If
  *	they are found return an error code so we can turn off DMA
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 46c4cdb..a1b4d84 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -4212,19 +4212,6 @@ err_out:
 }
 
 
-/**
- *	ata_port_start - Set port up for dma.
- *	@ap: Port to initialize
- *
- *	Called just after data structures for each port are
- *	initialized.  Allocates space for PRD table.
- *
- *	May be used as the port_start() entry in ata_port_operations.
- *
- *	LOCKING:
- *	Inherited from caller.
- */
-
 /*
  * Execute a 'simple' command, that only consists of the opcode 'cmd' itself,
  * without filling any other registers
@@ -4276,6 +4263,8 @@ static int ata_start_drive(struct ata_po
 
 /**
  *	ata_device_resume - wakeup a previously suspended devices
+ *	@ap: port the device is connected to
+ *	@dev: the device to resume
  *
  *	Kick the drive back into action, by sending it an idle immediate
  *	command and making sure its transfer mode matches between drive
@@ -4298,10 +4287,11 @@ int ata_device_resume(struct ata_port *a
 
 /**
  *	ata_device_suspend - prepare a device for suspend
+ *	@ap: port the device is connected to
+ *	@dev: the device to suspend
  *
  *	Flush the cache on the drive, if appropriate, then issue a
  *	standbynow command.
- *
  */
 int ata_device_suspend(struct ata_port *ap, struct ata_device *dev)
 {
@@ -4315,6 +4305,19 @@ int ata_device_suspend(struct ata_port *
 	return 0;
 }
 
+/**
+ *	ata_port_start - Set port up for dma.
+ *	@ap: Port to initialize
+ *
+ *	Called just after data structures for each port are
+ *	initialized.  Allocates space for PRD table.
+ *
+ *	May be used as the port_start() entry in ata_port_operations.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
+
 int ata_port_start (struct ata_port *ap)
 {
 	struct device *dev = ap->host_set->dev;
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index cfbceb5..b94c991 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -2492,6 +2492,8 @@ out_unlock:
 
 /**
  *	ata_scsi_simulate - simulate SCSI command on ATA device
+ *	@ap: port the device is connected to
+ *	@dev: the target device
  *	@id: current IDENTIFY data for target device.
  *	@cmd: SCSI command being sent to device.
  *	@done: SCSI command completion function.
-- 
0.99.9.GIT

-- 
Martin Waitz

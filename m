Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751494AbWBVWK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbWBVWK7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 17:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbWBVWK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 17:10:59 -0500
Received: from fmr17.intel.com ([134.134.136.16]:52885 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751484AbWBVWK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 17:10:58 -0500
Date: Wed, 22 Feb 2006 14:00:08 -0800
From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: linux-ide@vger.kernel.org, akpm@osdl.org, jgarzik@pobox.com
Subject: [PATCH 9/13] ATA ACPI: check SATA/PATA more carefully
Message-Id: <20060222140008.3832951a.randy_d_dunlap@linux.intel.com>
In-Reply-To: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com>
References: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
X-Face: "}I"O`t9.W]b]8SycP0Jap#<FU!b:16h{lR\#aFEpEf\3c]wtAL|,'>)%JR<P#Yg.88}`$#
 A#bhRMP(=%<w07"0#EoCxXWD%UDdeU]>,H)Eg(FP)?S1qh0ZJRu|mz*%SKpL7rcKI3(OwmK2@uo\b2
 GB:7w&?a,*<8v[ldN`5)MXFcm'cjwRs5)ui)j
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy_d_dunlap@linux.intel.com>

Use 'legacy_mode' to check for SATA vs. PATA mode.

Signed-off-by: Randy Dunlap <randy_d_dunlap@linux.intel.com>
---
 drivers/scsi/libata-acpi.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-2616-rc4-ata.orig/drivers/scsi/libata-acpi.c
+++ linux-2616-rc4-ata/drivers/scsi/libata-acpi.c
@@ -437,7 +437,7 @@ int do_drive_get_GTF(struct ata_port *ap
 
 	/* Don't continue if device has no _ADR method.
 	 * _GTF is intended for known motherboard devices. */
-	if (ata_id_is_ata(atadev->id)) {
+	if (ap->legacy_mode) {
 		err = pata_get_dev_handle(dev, &dev_handle, &pcidevfn);
 		if (err < 0) {
 			if (ata_msg_probe(ap))
@@ -459,7 +459,7 @@ int do_drive_get_GTF(struct ata_port *ap
 
 	/* Get this drive's _ADR info. if not already known. */
 	if (!atadev->obj_handle) {
-		if (ata_id_is_ata(atadev->id)) {
+		if (ap->legacy_mode) {
 			/* get child objects of dev_handle == channel objects,
 	 		 * + _their_ children == drive objects */
 			/* channel is ap->hard_port_no */
@@ -655,7 +655,7 @@ int do_drive_set_taskfiles(struct ata_po
 
 	if (noacpi)
 		return 0;
-	if (!ata_id_is_sata(atadev->id)) {
+	if (ap->legacy_mode) {
 		printk(KERN_DEBUG "%s: skipping non-SATA drive\n",
 			__FUNCTION__);
 		return 0;

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932422AbWAQU2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbWAQU2j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 15:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbWAQU2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 15:28:39 -0500
Received: from fmr20.intel.com ([134.134.136.19]:55234 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S932422AbWAQU2i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 15:28:38 -0500
From: Jason Gaston <jason.d.gaston@intel.com>
Organization: Intel Corp.
To: jgarzik@redhat.com
Subject: [patch] Intel ICH8 SATA: add PCI device IDs
Date: Tue, 17 Jan 2006 12:28:48 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601171228.48394.jason.d.gaston@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resubmit after removing duplicate entry.

Signed-off-by:  Jason Gaston <Jason.d.gaston@intel.com>

--- linux-2.6.16-rc1/drivers/scsi/ata_piix.c.orig	2006-01-17 08:45:23.711123752 -0800
+++ linux-2.6.16-rc1/drivers/scsi/ata_piix.c	2006-01-17 08:46:32.645644112 -0800
@@ -157,6 +157,9 @@
 	{ 0x8086, 0x27c0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_ahci },
 	{ 0x8086, 0x27c4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_ahci },
 	{ 0x8086, 0x2680, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_ahci },
+	{ 0x8086, 0x2820, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_ahci },
+	{ 0x8086, 0x2825, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_ahci },
+	{ 0x8086, 0x2828, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_ahci },
 
 	{ }	/* terminate list */
 };
--- linux-2.6.16-rc1/drivers/pci/quirks.c.orig	2006-01-17 08:46:41.357319736 -0800
+++ linux-2.6.16-rc1/drivers/pci/quirks.c	2006-01-17 08:49:23.747632656 -0800
@@ -1142,6 +1142,9 @@
 	case 0x27c4:
 		ich = 7;
 		break;
+	case 0x2828:	/* ICH8M */
+		ich = 8;
+		break;
 	default:
 		/* we do not handle this PCI device */
 		return;
@@ -1161,7 +1164,7 @@
 		else
 			return;			/* not in combined mode */
 	} else {
-		WARN_ON((ich != 6) && (ich != 7));
+		WARN_ON((ich != 6) && (ich != 7) && (ich != 8));
 		tmp &= 0x3;  /* interesting bits 1:0 */
 		if (tmp & (1 << 0))
 			comb = (1 << 2);	/* PATA port 0, SATA port 1 */

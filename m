Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964859AbWIYCWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964859AbWIYCWz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 22:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbWIYCWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 22:22:55 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:406 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S964833AbWIYCWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 22:22:53 -0400
Date: Sun, 24 Sep 2006 20:22:52 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: James Bottomley <James.Bottomley@steeleye.com>,
       Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Revert ABI-breaking change in /proc
Message-ID: <20060925022252.GG2595@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some user tools parse /proc/scsi/scsi, so we can't yet change the names.
Change the existing ones back to their old names, and add an admonition
to not make the same mistake that I did.

Andrew Morton reports that this was breaking YDL 4.1 userspace.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>
Signed-off-by: Andrew Morton <akpm@osdl.org>

diff -puN drivers/scsi/scsi.c~revert-scsi-improve-inquiry-printing drivers/scsi/scsi.c
--- a/drivers/scsi/scsi.c~revert-scsi-improve-inquiry-printing
+++ a/drivers/scsi/scsi.c
@@ -96,22 +96,26 @@ unsigned int scsi_logging_level;
 EXPORT_SYMBOL(scsi_logging_level);
 #endif
 
+/* NB: These are exposed through /proc/scsi/scsi and form part of the ABI.
+ * You may not alter any existing entry (although adding new ones is
+ * encouraged once assigned by ANSI/INCITS T10
+ */
 static const char *const scsi_device_types[] = {
-	"Direct access    ",
-	"Sequential access",
+	"Direct-Access    ",
+	"Sequential-Access",
 	"Printer          ",
 	"Processor        ",
 	"WORM             ",
-	"CD/DVD           ",
+	"CD-ROM           ",
 	"Scanner          ",
-	"Optical memory   ",
-	"Media changer    ",
+	"Optical Device   ",
+	"Medium Changer   ",
 	"Communications   ",
 	"ASC IT8          ",
 	"ASC IT8          ",
 	"RAID             ",
 	"Enclosure        ",
-	"Direct access RBC",
+	"Direct-Access-RBC",
 	"Optical card     ",
 	"Bridge controller",
 	"Object storage   ",

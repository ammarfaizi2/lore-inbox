Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263488AbTIHSxB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 14:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263492AbTIHSxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 14:53:01 -0400
Received: from zok.SGI.COM ([204.94.215.101]:11229 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S263488AbTIHSw4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 14:52:56 -0400
From: jbarnes@sgi.com
Date: Mon, 8 Sep 2003 11:47:40 -0700
To: acpi-devel@lists.sourceforge.net
Subject: [PATCH] don't use alloc_bootmem in ACPI table initialization
Message-ID: <20030908184740.GA758@sgi.com>
Mail-Followup-To: acpi-devel@lists.sf.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Already talked with Andy about this one, is it ok to push to Linus?

Thanks,
Jesse


diff -Nru a/drivers/acpi/tables.c b/drivers/acpi/tables.c
--- a/drivers/acpi/tables.c	Wed Jul 30 11:45:27 2003
+++ b/drivers/acpi/tables.c	Wed Jul 30 11:45:27 2003
@@ -69,7 +69,8 @@
 
 static unsigned long		sdt_pa;		/* Physical Address */
 static unsigned long		sdt_count;	/* Table count */
-static struct acpi_table_sdt	*sdt_entry;
+
+static struct acpi_table_sdt	sdt_entry[ACPI_MAX_TABLES];
 
 void
 acpi_table_print (
@@ -413,12 +414,6 @@
 			sdt_count = ACPI_MAX_TABLES;
 		}
 
-		sdt_entry = alloc_bootmem(sdt_count * sizeof(struct acpi_table_sdt));
-		if (!sdt_entry) {
-			printk(KERN_ERR "ACPI: Could not allocate mem for SDT entries!\n");
-			return -ENOMEM;
-		}
-
 		for (i = 0; i < sdt_count; i++)
 			sdt_entry[i].pa = (unsigned long) mapped_xsdt->entry[i];
 	}
@@ -463,12 +458,6 @@
 			printk(KERN_WARNING PREFIX "Truncated %lu RSDT entries\n",
 				(sdt_count - ACPI_MAX_TABLES));
 			sdt_count = ACPI_MAX_TABLES;
-		}
-
-		sdt_entry = alloc_bootmem(sdt_count * sizeof(struct acpi_table_sdt));
-		if (!sdt_entry) {
-			printk(KERN_ERR "ACPI: Could not allocate mem for SDT entries!\n");
-			return -ENOMEM;
 		}
 
 		for (i = 0; i < sdt_count; i++)

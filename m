Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262775AbTIQPfy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 11:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262782AbTIQPfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 11:35:54 -0400
Received: from zok.SGI.COM ([204.94.215.101]:52424 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S262775AbTIQPfw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 11:35:52 -0400
Date: Wed, 17 Sep 2003 08:35:42 -0700
To: Len Brown <len.brown@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [BKPATCH] ACPI 20030916 for 2.4.23-pre4
Message-ID: <20030917153542.GA22959@sgi.com>
Mail-Followup-To: Len Brown <len.brown@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0309151824360.2914-100000@logos.cnet> <1063759840.13038.23.camel@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1063759840.13038.23.camel@linux.local>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can you please push this one as well?  Thanks.

Jesse


diff -Nru a/drivers/acpi/tables.c b/drivers/acpi/tables.c
--- a/drivers/acpi/tables.c	Tue Sep  9 10:24:34 2003
+++ b/drivers/acpi/tables.c	Tue Sep  9 10:24:34 2003
@@ -69,7 +69,8 @@
 
 static unsigned long		sdt_pa;		/* Physical Address */
 static unsigned long		sdt_count;	/* Table count */
-static struct acpi_table_sdt	*sdt_entry;
+
+static struct acpi_table_sdt	sdt_entry[ACPI_MAX_TABLES];
 
 void
 acpi_table_print (
@@ -425,12 +426,6 @@
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
@@ -475,12 +470,6 @@
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

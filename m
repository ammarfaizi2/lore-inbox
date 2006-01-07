Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752561AbWAGST3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752561AbWAGST3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 13:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752573AbWAGST3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 13:19:29 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:38149 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1752574AbWAGST2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 13:19:28 -0500
Date: Sat, 7 Jan 2006 19:19:27 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com,
       linux-acpi@vger.kernel.org
Subject: [-mm patch] drivers/acpi/: make two functions static
Message-ID: <20060107181927.GQ3774@stusta.de>
References: <20060107052221.61d0b600.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060107052221.61d0b600.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2006 at 05:22:21AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.15-mm1:
>...
> +fix-some-f_ops-abuse-in-acpi.patch
>...

After this patch, we can make two functions static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/acpi/processor_thermal.c    |    6 +++---
 drivers/acpi/processor_throttling.c |    6 +++---
 include/acpi/processor.h            |    6 ------
 3 files changed, 6 insertions(+), 12 deletions(-)

--- linux-2.6.15-mm2-full/include/acpi/processor.h.old	2006-01-07 17:52:17.000000000 +0100
+++ linux-2.6.15-mm2-full/include/acpi/processor.h	2006-01-07 17:52:28.000000000 +0100
@@ -223,9 +223,6 @@
 /* in processor_throttling.c */
 int acpi_processor_get_throttling_info(struct acpi_processor *pr);
 int acpi_processor_set_throttling(struct acpi_processor *pr, int state);
-ssize_t acpi_processor_write_throttling(struct file *file,
-					const char __user * buffer,
-					size_t count, loff_t * data);
 extern struct file_operations acpi_processor_throttling_fops;
 
 /* in processor_idle.c */
@@ -237,9 +234,6 @@
 
 /* in processor_thermal.c */
 int acpi_processor_get_limit_info(struct acpi_processor *pr);
-ssize_t acpi_processor_write_limit(struct file *file,
-				   const char __user * buffer,
-				   size_t count, loff_t * data);
 extern struct file_operations acpi_processor_limit_fops;
 
 #ifdef CONFIG_CPU_FREQ
--- linux-2.6.15-mm2-full/drivers/acpi/processor_throttling.c.old	2006-01-07 17:52:37.000000000 +0100
+++ linux-2.6.15-mm2-full/drivers/acpi/processor_throttling.c	2006-01-07 17:52:54.000000000 +0100
@@ -306,9 +306,9 @@
 			   PDE(inode)->data);
 }
 
-ssize_t acpi_processor_write_throttling(struct file * file,
-					const char __user * buffer,
-					size_t count, loff_t * data)
+static ssize_t acpi_processor_write_throttling(struct file * file,
+					       const char __user * buffer,
+					       size_t count, loff_t * data)
 {
 	int result = 0;
 	struct seq_file *m = (struct seq_file *)file->private_data;
--- linux-2.6.15-mm2-full/drivers/acpi/processor_thermal.c.old	2006-01-07 17:53:04.000000000 +0100
+++ linux-2.6.15-mm2-full/drivers/acpi/processor_thermal.c	2006-01-07 17:53:16.000000000 +0100
@@ -348,9 +348,9 @@
 			   PDE(inode)->data);
 }
 
-ssize_t acpi_processor_write_limit(struct file * file,
-				   const char __user * buffer,
-				   size_t count, loff_t * data)
+static ssize_t acpi_processor_write_limit(struct file * file,
+					  const char __user * buffer,
+					  size_t count, loff_t * data)
 {
 	int result = 0;
 	struct seq_file *m = (struct seq_file *)file->private_data;


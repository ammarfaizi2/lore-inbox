Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932348AbWAWQhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbWAWQhu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 11:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932441AbWAWQhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 11:37:50 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:30163 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932433AbWAWQht
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 11:37:49 -0500
Subject: [PATCH] tpm: tpm_bios fix sparse warnings
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Mon, 23 Jan 2006 10:38:57 -0600
Message-Id: <1138034337.5076.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixing the sparse warnings on the acpi_os_map_memory calls pointed out
by Randy.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
--- 
diff -uprN --exclude-from=linux_excludes linux-2.6.16-rc1/drivers/char/tpm/tpm_bios.c linux-2.6.16-rc1-tpm/drivers/char/tpm/tpm_bios.c
--- linux-2.6.16-rc1/drivers/char/tpm/tpm_bios.c	2006-01-20 14:21:13.000000000 -0600
+++ linux-2.6.16-rc1-tpm/drivers/char/tpm/tpm_bios.c	2006-01-20 14:05:41.000000000 -0600
@@ -376,7 +375,7 @@ static int read_log(struct tpm_bios_log 
 {
 	struct acpi_tcpa *buff;
 	acpi_status status;
-	void *virt;
+	struct acpi_table_header *virt;
 
 	if (log->bios_event_log != NULL) {
 		printk(KERN_ERR
@@ -413,7 +412,7 @@ static int read_log(struct tpm_bios_log 
 
 	log->bios_event_log_end = log->bios_event_log + buff->log_max_len;
 
-	acpi_os_map_memory(buff->log_start_addr, buff->log_max_len, &virt);
+	acpi_os_map_memory(buff->log_start_addr, buff->log_max_len, (void *) &virt);
 
 	memcpy(log->bios_event_log, virt, buff->log_max_len);
 




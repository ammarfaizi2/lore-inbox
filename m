Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932163AbWCSSqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbWCSSqX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 13:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbWCSSqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 13:46:23 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:24758 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S932163AbWCSSqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 13:46:22 -0500
Date: Sun, 19 Mar 2006 18:43:25 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Matt_Domsch@dell.com, matthew.e.tolentino@intel.com,
       linux-kernel@vger.kernel.org, mactel-linux-devel@lists.sourceforge.net
Subject: [PATCH] - make sure that EFI variable data size is always 64 bit
Message-ID: <20060319184325.GA7605@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The EFI spec states that the data size of an EFI variable is 64 bits. 
"unsigned long", on the other hand, isn't on IA32.

diff --git a/drivers/firmware/efivars.c b/drivers/firmware/efivars.c
index bda5bce..488c24c 100644
--- a/drivers/firmware/efivars.c
+++ b/drivers/firmware/efivars.c
@@ -110,7 +110,7 @@ static LIST_HEAD(efivar_list);
 struct efi_variable {
 	efi_char16_t  VariableName[1024/sizeof(efi_char16_t)];
 	efi_guid_t    VendorGuid;
-	unsigned long DataSize;
+	__u64	      DataSize;
 	__u8          Data[1024];
 	efi_status_t  Status;
 	__u32         Attributes;
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 9e97bc2..3f0a179 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -163,7 +163,7 @@ typedef efi_status_t efi_get_wakeup_time
 					    efi_time_t *tm);
 typedef efi_status_t efi_set_wakeup_time_t (efi_bool_t enabled, efi_time_t *tm);
 typedef efi_status_t efi_get_variable_t (efi_char16_t *name, efi_guid_t *vendor, u32 *attr,
-					 unsigned long *data_size, void *data);
+					 __u64 *data_size, void *data);
 typedef efi_status_t efi_get_next_variable_t (unsigned long *name_size, efi_char16_t *name,
 					      efi_guid_t *vendor);
 typedef efi_status_t efi_set_variable_t (efi_char16_t *name, efi_guid_t *vendor, 

-- 
Matthew Garrett | mjg59@srcf.ucam.org

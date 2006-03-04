Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbWCDSEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbWCDSEK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 13:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbWCDSEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 13:04:10 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:58584 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S932278AbWCDSEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 13:04:08 -0500
Date: Sat, 4 Mar 2006 18:04:01 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: mactel-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] Remove __init from efi_get_time
Message-ID: <20060304180359.GA3775@srcf.ucam.org>
References: <20060304180018.GA3695@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060304180018.GA3695@srcf.ucam.org>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The comment above efi_get_time claims:

Note, this call isn't used later, so mark it __init.

Unfortunately, it's not true - it's called during suspend as well, 
leading to nasty explosions.

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>

diff --git a/arch/i386/kernel/efi.c b/arch/i386/kernel/efi.c
index ecad519..6be705e 100644
--- a/arch/i386/kernel/efi.c
+++ b/arch/i386/kernel/efi.c
@@ -193,9 +193,9 @@ inline int efi_set_rtc_mmss(unsigned lon
 /*
  * This should only be used during kernel init and before runtime
  * services have been remapped, therefore, we'll need to call in physical
- * mode.  Note, this call isn't used later, so mark it __init.
+ * mode.
  */
-inline unsigned long __init efi_get_time(void)
+inline unsigned long efi_get_time(void)
 {
 	efi_status_t status;
 	efi_time_t eft;
diff --git a/include/linux/efi.h b/include/linux/efi.h
index c7c5dd3..9e97bc2 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -295,7 +295,7 @@ extern u64 efi_mem_attributes (unsigned 
 extern int __init efi_uart_console_only (void);
 extern void efi_initialize_iomem_resources(struct resource *code_resource,
 					struct resource *data_resource);
-extern unsigned long __init efi_get_time(void);
+extern unsigned long efi_get_time(void);
 extern int __init efi_set_rtc_mmss(unsigned long nowtime);
 extern struct efi_memory_map memmap;
 
-- 
Matthew Garrett | mjg59@srcf.ucam.org

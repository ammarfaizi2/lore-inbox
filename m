Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932770AbWHOAmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932770AbWHOAmA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 20:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932769AbWHOAl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 20:41:59 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:59911 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932766AbWHOAl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 20:41:58 -0400
Date: Tue, 15 Aug 2006 02:41:57 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Bob Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/acpi/osl.c: fix a NULL check
Message-ID: <20060815004157.GF3543@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a non-working NULL check introduced by commit 
b229cf92eee616c7cb5ad8cdb35a19b119f00bc8.

Spotted by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.18-rc4-mm1/drivers/acpi/osl.c.old	2006-08-15 00:43:30.000000000 +0200
+++ linux-2.6.18-rc4-mm1/drivers/acpi/osl.c	2006-08-15 00:43:55.000000000 +0200
@@ -1030,7 +1030,7 @@
 acpi_os_create_cache(char *name, u16 size, u16 depth, acpi_cache_t ** cache)
 {
 	*cache = kmem_cache_create(name, size, 0, 0, NULL, NULL);
-	if (cache == NULL)
+	if (*cache == NULL)
 		return AE_ERROR;
 	else
 		return AE_OK;


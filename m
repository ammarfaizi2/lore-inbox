Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751304AbWCYL64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbWCYL64 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 06:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbWCYL6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 06:58:55 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:47117 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751304AbWCYL6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 06:58:55 -0500
Date: Sat, 25 Mar 2006 12:58:53 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Darren Jenkins <darrenrjenkins@gmail.com>
Subject: [2.6 patch] fix array over-run in efi.c
Message-ID: <20060325115853.GB4053@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Darren Jenkins <darrenrjenkins@gmail.com>

Coverity found an over-run @ line 364 of efi.c

This is due to the loop checking the size correctly, then adding a '\0'
after possibly hitting the end of the array.

The patch below just ensures the loop exits with one space left in the
array.

Compile tested.


Signed-off-by: Darren Jenkins <darrenrjenkins@gmail.com>
Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was sent by Darren Jenkins on:
- 08 Mar 2006

--- linux-2.6.16-rc5/arch/i386/kernel/efi.c.orig	2006-03-08 12:31:14.000000000 +1100
+++ linux-2.6.16-rc5/arch/i386/kernel/efi.c	2006-03-08 12:37:59.000000000 +1100
@@ -359,7 +359,7 @@ void __init efi_init(void)
 	 */
 	c16 = (efi_char16_t *) boot_ioremap(efi.systab->fw_vendor, 2);
 	if (c16) {
-		for (i = 0; i < sizeof(vendor) && *c16; ++i)
+		for (i = 0; i < (sizeof(vendor) - 1) && *c16; ++i)
 			vendor[i] = *c16++;
 		vendor[i] = '\0';
 	} else




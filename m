Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759029AbWK3E0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759029AbWK3E0n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 23:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759009AbWK3E00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 23:26:26 -0500
Received: from www.swissdisk.com ([216.66.254.197]:25267 "EHLO
	swissweb.swissdisk.com") by vger.kernel.org with ESMTP
	id S1759017AbWK3E0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 23:26:19 -0500
From: Ben Collins <bcollins@ubuntu.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Subject: [PATCH 3/4] [ATM] Add CPPFLAGS to byteorder.h check.
Reply-To: Ben Collins <bcollins@ubuntu.com>
Date: Wed, 29 Nov 2006 23:26:07 -0500
Message-Id: <11648607734110-git-send-email-bcollins@ubuntu.com>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <11648607683157-git-send-email-bcollins@ubuntu.com>
References: <11648607683157-git-send-email-bcollins@ubuntu.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

O= builds produced errors in the shell command because of unfound headers.

Signed-off-by: Ben Collins <bcollins@ubuntu.com>
---
 drivers/atm/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/atm/Makefile b/drivers/atm/Makefile
index b5077ce..1b16f81 100644
--- a/drivers/atm/Makefile
+++ b/drivers/atm/Makefile
@@ -41,7 +41,7 @@ ifeq ($(CONFIG_ATM_FORE200E_PCA),y)
   # guess the target endianess to choose the right PCA-200E firmware image
   ifeq ($(CONFIG_ATM_FORE200E_PCA_DEFAULT_FW),y)
     byteorder.h			:= include$(if $(patsubst $(srctree),,$(objtree)),2)/asm/byteorder.h
-    CONFIG_ATM_FORE200E_PCA_FW	:= $(obj)/pca200e$(if $(shell $(CC) -E -dM $(byteorder.h) | grep ' __LITTLE_ENDIAN '),.bin,_ecd.bin2)
+    CONFIG_ATM_FORE200E_PCA_FW	:= $(obj)/pca200e$(if $(shell $(CC) $(CPPFLAGS) -E -dM $(byteorder.h) | grep ' __LITTLE_ENDIAN '),.bin,_ecd.bin2)
   endif
 endif
 
-- 
1.4.1


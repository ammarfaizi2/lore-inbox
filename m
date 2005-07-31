Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261687AbVGaLRB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbVGaLRB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 07:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263070AbVGaLMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 07:12:20 -0400
Received: from coderock.org ([193.77.147.115]:41156 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261687AbVGaLKv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 07:10:51 -0400
Message-Id: <20050731111058.920880000@homer>
Date: Sun, 31 Jul 2005 13:10:59 +0200
From: domen@coderock.org
To: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org,
       Marcelo Feitoza Parisi <marcelo@feitoza.com.br>, domen@coderock.org
Subject: [patch 1/1] drivers/char/agp/nvidia-agp.c : Use of the time_before_eq() macro
Content-Disposition: inline; filename=time_after-drivers_char_agp_nvidia-agp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcelo Feitoza Parisi <marcelo@feitoza.com.br>



Use of the time_before_eq() macro, defined at linux/jiffies.h, which deal
with wrapping correctly and are nicer to read.

Signed-off-by: Marcelo Feitoza Parisi <marcelo@feitoza.com.br>
Signed-off-by: Domen Puncer <domen@coderock.org>

---
 nvidia-agp.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

Index: quilt/drivers/char/agp/nvidia-agp.c
===================================================================
--- quilt.orig/drivers/char/agp/nvidia-agp.c
+++ quilt/drivers/char/agp/nvidia-agp.c
@@ -11,6 +11,7 @@
 #include <linux/gfp.h>
 #include <linux/page-flags.h>
 #include <linux/mm.h>
+#include <linux/jiffies.h>
 #include "agp.h"
 
 /* NVIDIA registers */
@@ -256,7 +257,7 @@ static void nvidia_tlbflush(struct agp_m
 		do {
 			pci_read_config_dword(nvidia_private.dev_1,
 					NVIDIA_1_WBC, &wbc_reg);
-			if ((signed)(end - jiffies) <= 0) {
+			if (time_before_eq(end, jiffies)) {
 				printk(KERN_ERR PFX
 				    "TLB flush took more than 3 seconds.\n");
 			}

--

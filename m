Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263193AbVGaLMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263193AbVGaLMN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 07:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbVGaLMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 07:12:12 -0400
Received: from coderock.org ([193.77.147.115]:54212 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S263193AbVGaLMB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 07:12:01 -0400
Message-Id: <20050731111205.933793000@homer>
Date: Sun, 31 Jul 2005 13:12:06 +0200
From: domen@coderock.org
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org,
       Marcelo Feitoza Parisi <marcelo@feitoza.com.br>, domen@coderock.org
Subject: [patch 1/5] drivers/char/lp.c : Use of the time_after() macro
Content-Disposition: inline; filename=time_after-drivers_char_lp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcelo Feitoza Parisi <marcelo@feitoza.com.br>



Use of the time_after() macro, defined at linux/jiffies.h, which deal
with wrapping correctly and are nicer to read.

Signed-off-by: Marcelo Feitoza Parisi <marcelo@feitoza.com.br>
Signed-off-by: Domen Puncer <domen@coderock.org>

---
 lp.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

Index: quilt/drivers/char/lp.c
===================================================================
--- quilt.orig/drivers/char/lp.c
+++ quilt/drivers/char/lp.c
@@ -128,6 +128,7 @@
 #include <linux/console.h>
 #include <linux/device.h>
 #include <linux/wait.h>
+#include <linux/jiffies.h>
 
 #include <linux/parport.h>
 #undef LP_STATS
@@ -307,7 +308,7 @@ static ssize_t lp_write(struct file * fi
 			(LP_F(minor) & LP_ABORT));
 
 #ifdef LP_STATS
-	if (jiffies-lp_table[minor].lastcall > LP_TIME(minor))
+	if (time_after(jiffies, lp_table[minor].lastcall + LP_TIME(minor)))
 		lp_table[minor].runchars = 0;
 
 	lp_table[minor].lastcall = jiffies;

--

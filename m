Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262858AbTEGEqh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 00:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262860AbTEGEqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 00:46:37 -0400
Received: from [203.145.184.221] ([203.145.184.221]:21520 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S262858AbTEGEqd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 00:46:33 -0400
Subject: [PATCH 2.5.69] IA64 sn mod_timer fixes for kernel/mca.c
From: Vinay K Nallamothu <vinay-rc@naturesoft.net>
To: linux-ia64@linuxia64.org
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 07 May 2003 10:34:02 +0530
Message-Id: <1052283842.19524.44.camel@lima.royalchallenge.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mca.c: Trivial {del,add}_timer to mod_timer conversion.

Thanks
vinay

--- linux-2.5.69/arch/ia64/sn/kernel/mca.c	2003-03-25 10:07:20.000000000 +0530
+++ linux-2.5.69-nvk/arch/ia64/sn/kernel/mca.c	2003-05-07 10:11:42.000000000 +0530
@@ -246,9 +246,7 @@
 void
 sn_cpei_timer_handler(unsigned long dummy) {
         sn_cpei_handler(-1, NULL, NULL);
-        del_timer(&sn_cpei_timer);
-        sn_cpei_timer.expires = jiffies + CPEI_INTERVAL;
-        add_timer(&sn_cpei_timer);
+        mod_timer(&sn_cpei_timer, jiffies + CPEI_INTERVAL);
 }
 
 void
@@ -267,9 +265,7 @@
         unsigned long *pi_ce_error_inject_reg = 0xc00000092fffff00;
 
         *pi_ce_error_inject_reg = 0x0000000000000100;
-        del_timer(&sn_ce_timer);
-        sn_ce_timer.expires = jiffies + CPEI_INTERVAL;
-        add_timer(&sn_ce_timer);
+        mod_timer(&sn_ce_timer, jiifies + CPEI_INTERVAL);
 }
 
 sn_init_ce_timer() {




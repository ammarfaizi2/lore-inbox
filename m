Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262845AbTEGEma (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 00:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262850AbTEGEma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 00:42:30 -0400
Received: from [203.145.184.221] ([203.145.184.221]:7952 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S262845AbTEGEm3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 00:42:29 -0400
Subject: [PATCH 2.{4,5}.x] IA64 SN mod_timer fix for kernel/irq.c
From: Vinay K Nallamothu <vinay-rc@naturesoft.net>
To: linux-ia64@linuxia64.org
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 07 May 2003 10:29:54 +0530
Message-Id: <1052283594.1189.39.camel@lima.royalchallenge.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

irq.c: Remove {del,add}_timer to use mod_timer.

--- linux-2.5.68/arch/ia64/sn/kernel/irq.c	2003-03-25 10:07:20.000000000 +0530
+++ linux-2.5.68-nvk/arch/ia64/sn/kernel/irq.c	2003-05-03 16:14:38.000000000 +0530
@@ -310,9 +310,7 @@
 			bridge->b_force_always[intr_test_registered[i].slot].intr = 1;
 		}
 	}
-	del_timer(&intr_test_timer);
-	intr_test_timer.expires = jiffies + HZ/100;
-	add_timer(&intr_test_timer);
+	mod_timer(&intr_test_timer, jiffies + HZ/100);
 }
 
 void




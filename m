Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbVICDrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbVICDrh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 23:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbVICDrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 23:47:37 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:12788 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S1750800AbVICDrg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 23:47:36 -0400
Subject: [PATCH] RT: trace_irqs_on in raw_local_irq_restore
From: Daniel Walker <dwalker@mvista.com>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 02 Sep 2005 20:47:29 -0700
Message-Id: <1125719249.2709.17.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Add trace_irqs_on() to raw_local_irq_restore() . 

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.13/include/linux/rt_irq.h
===================================================================
--- linux-2.6.13.orig/include/linux/rt_irq.h	2005-09-01 21:25:53.000000000 +0000
+++ linux-2.6.13/include/linux/rt_irq.h	2005-09-03 00:45:28.000000000 +0000
@@ -30,7 +30,8 @@ extern int irqs_disabled_flags(unsigned 
 # define raw_local_irq_disable()	do { __raw_local_irq_disable(); trace_irqs_off(); } while (0)
 # define raw_local_irq_save(flags)	do { __raw_local_irq_save(flags); trace_irqs_off(); } while (0)
 # define raw_local_irq_restore(flags) \
-	do { check_raw_flags(flags); __raw_local_irq_restore(flags); } while (0)
+	do { check_raw_flags(flags); if (!__raw_irqs_disabled_flags(flags)) { trace_irqs_on(); } \
+			__raw_local_irq_restore(flags); } while (0)
 # define raw_safe_halt()		__raw_safe_halt()
 #else
 # define RAW_LOCAL_ILLEGAL_MASK		0UL



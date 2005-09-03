Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751358AbVICDri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbVICDri (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 23:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbVICDri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 23:47:38 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:13044 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S1751358AbVICDrh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 23:47:37 -0400
Subject: [PATCH] RT: Add raw_irqs_disabled to might_sleep
From: Daniel Walker <dwalker@mvista.com>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 02 Sep 2005 20:47:30 -0700
Message-Id: <1125719250.2709.19.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Add in raw_irqs_disabled() into the might sleep check.

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.13/kernel/sched.c
===================================================================
--- linux-2.6.13.orig/kernel/sched.c	2005-09-02 23:42:18.000000000 +0000
+++ linux-2.6.13/kernel/sched.c	2005-09-03 03:44:24.000000000 +0000
@@ -5914,7 +5914,7 @@ void __might_sleep(char *file, int line)
 #if defined(in_atomic)
 	static unsigned long prev_jiffy;	/* ratelimiting */
 
-	if ((in_atomic() || irqs_disabled()) &&
+	if ((in_atomic() || irqs_disabled() || raw_irqs_disabled()) && 
 	    system_state == SYSTEM_RUNNING && !oops_in_progress) {
 		if (debug_direct_keyboard && hardirq_count())
 			return;



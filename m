Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266205AbUFUMKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266205AbUFUMKR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 08:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266206AbUFUMKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 08:10:17 -0400
Received: from d64-180-152-77.bchsia.telus.net ([64.180.152.77]:57612 "EHLO
	antichrist") by vger.kernel.org with ESMTP id S266205AbUFUMKO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 08:10:14 -0400
Date: Mon, 21 Jun 2004 05:06:43 -0700
From: carbonated beverage <ramune@net-ronin.org>
To: linux-kernel@vger.kernel.org
Subject: compile fix net/core/dev.c
Message-ID: <20040621120643.GA8827@net-ronin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tiny patch to make gcc 2.95.4 happy.  Declare a variable before code
preceeds it.

-- DN
Daniel

===== net/core/dev.c 1.147 vs edited =====
--- 1.147/net/core/dev.c	2004-06-20 17:35:52 -07:00
+++ edited/net/core/dev.c	2004-06-21 04:36:04 -07:00
@@ -1406,8 +1406,10 @@
 	   Either shot noqueue qdisc, it is even simpler 8)
 	 */
 	if (dev->flags & IFF_UP) {
+		int cpu;
+
 		preempt_disable();
-		int cpu = smp_processor_id();
+		cpu = smp_processor_id();
 
 		if (dev->xmit_lock_owner != cpu) {
 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266263AbUHMR3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266263AbUHMR3i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 13:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266284AbUHMR3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 13:29:36 -0400
Received: from omx3-ext.SGI.COM ([192.48.171.20]:61662 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266263AbUHMR1l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 13:27:41 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] don't print per-cpu delay loop calibration
Date: Fri, 13 Aug 2004 10:27:22 -0700
User-Agent: KMail/1.6.2
Cc: Greg Edwards <edwardsg@sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_6nPHBEoHBXAz6kf"
Message-Id: <200408131027.22720.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_6nPHBEoHBXAz6kf
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

People are mainly concerned with showing off their total bogomips, not per-cpu 
bogomips, so turn it into a KERN_DEBUG message for the benefit of systems 
with lots of CPUs.

Signed-off-by: Jesse Barnes <jbarnes@sgi.com>

Thanks,
Jesse

--Boundary-00=_6nPHBEoHBXAz6kf
Content-Type: text/plain;
  charset="us-ascii";
  name="quiet-calibrating-delay-loop.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="quiet-calibrating-delay-loop.patch"

===== init/main.c 1.149 vs edited =====
--- 1.149/init/main.c	2004-06-27 00:19:38 -07:00
+++ edited/init/main.c	2004-08-13 09:53:37 -07:00
@@ -196,7 +196,7 @@
 
 	loops_per_jiffy = (1<<12);
 
-	printk("Calibrating delay loop... ");
+	printk(KERN_DEBUG "Calibrating delay loop... ");
 	while ((loops_per_jiffy <<= 1) != 0) {
 		/* wait for "start of" clock tick */
 		ticks = jiffies;

--Boundary-00=_6nPHBEoHBXAz6kf--

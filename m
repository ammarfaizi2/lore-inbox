Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932571AbVIHPch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932571AbVIHPch (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 11:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932532AbVIHPch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 11:32:37 -0400
Received: from mail12.syd.optusnet.com.au ([211.29.132.193]:21736 "EHLO
	mail12.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932571AbVIHPcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 11:32:36 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] vm: kswapd use pgdat
Date: Fri, 9 Sep 2005 01:36:00 +1000
User-Agent: KMail/1.8.2
Cc: akpm@osdl.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_hpFIDNP4RrE9eAR"
Message-Id: <200509090136.01034.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_hpFIDNP4RrE9eAR
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

We don't fully utilise this pointer.

Con
---



--Boundary-00=_hpFIDNP4RrE9eAR
Content-Type: text/x-diff;
  charset="us-ascii";
  name="vm-kswapd_use_pgdat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="vm-kswapd_use_pgdat.patch"

Use the pgdat pointer we've already defined in wakeup_kswapd

Signed-off-by: Con Kolivas <kernel@kolivas.org>

Index: linux-2.6.13-mm2/mm/vmscan.c
===================================================================
--- linux-2.6.13-mm2.orig/mm/vmscan.c	2005-09-09 01:27:33.000000000 +1000
+++ linux-2.6.13-mm2/mm/vmscan.c	2005-09-09 01:28:56.000000000 +1000
@@ -1263,9 +1263,9 @@ void wakeup_kswapd(struct zone *zone, in
 		pgdat->kswapd_max_order = order;
 	if (!cpuset_zone_allowed(zone, __GFP_HARDWALL))
 		return;
-	if (!waitqueue_active(&zone->zone_pgdat->kswapd_wait))
+	if (!waitqueue_active(&pgdat->kswapd_wait))
 		return;
-	wake_up_interruptible(&zone->zone_pgdat->kswapd_wait);
+	wake_up_interruptible(&pgdat->kswapd_wait);
 }
 
 #ifdef CONFIG_PM

--Boundary-00=_hpFIDNP4RrE9eAR--

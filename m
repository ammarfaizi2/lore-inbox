Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932392AbWHNRoB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbWHNRoB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 13:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWHNRoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 13:44:01 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:9910 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932405AbWHNRoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 13:44:00 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Mon, 14 Aug 2006 19:42:37 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.18-rc4-mm1 1/8] the scheduled removal of
 drivers/ieee1394/sbp2.c:force_inquiry_hack
To: linux1394-devel@lists.sourceforge.net
cc: Ben Collins <bcollins@ubuntu.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <tkrat.9b22090d7dd50b12@s5r6.in-berlin.de>
Message-ID: <tkrat.7dc19850cb95d34b@s5r6.in-berlin.de>
References: <tkrat.9b22090d7dd50b12@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: Sat, 29 Jul 2006 19:48:28 +0200
From: Adrian Bunk <bunk@stusta.de>
Subject: the scheduled removal of drivers/ieee1394/sbp2.c:force_inquiry_hack

This patch contains the scheduled removal of the force_inquiry_hack 
module parameter.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
 Documentation/feature-removal-schedule.txt |    9 ---------
 drivers/ieee1394/sbp2.c                    |   10 ----------
 2 files changed, 19 deletions(-)

Index: linux-2.6.18-rc4-mm1/Documentation/feature-removal-schedule.txt
===================================================================
--- linux-2.6.18-rc4-mm1.orig/Documentation/feature-removal-schedule.txt	2006-08-14 18:12:47.000000000 +0200
+++ linux-2.6.18-rc4-mm1/Documentation/feature-removal-schedule.txt	2006-08-14 18:21:46.000000000 +0200
@@ -23,15 +23,6 @@ Who:	Jody McIntyre <scjody@modernduck.co
 
 ---------------------------
 
-What:	sbp2: module parameter "force_inquiry_hack"
-When:	July 2006
-Why:	Superceded by parameter "workarounds". Both parameters are meant to be
-	used ad-hoc and for single devices only, i.e. not in modprobe.conf,
-	therefore the impact of this feature replacement should be low.
-Who:	Stefan Richter <stefanr@s5r6.in-berlin.de>
-
----------------------------
-
 What:	Video4Linux API 1 ioctls and video_decoder.h from Video devices.
 When:	July 2006
 Why:	V4L1 AP1 was replaced by V4L2 API. during migration from 2.4 to 2.6
Index: linux-2.6.18-rc4-mm1/drivers/ieee1394/sbp2.c
===================================================================
--- linux-2.6.18-rc4-mm1.orig/drivers/ieee1394/sbp2.c	2006-08-14 18:12:59.000000000 +0200
+++ linux-2.6.18-rc4-mm1/drivers/ieee1394/sbp2.c	2006-08-14 18:21:46.000000000 +0200
@@ -174,11 +174,6 @@ MODULE_PARM_DESC(workarounds, "Work arou
 	", override internal blacklist = " __stringify(SBP2_WORKAROUND_OVERRIDE)
 	", or a combination)");
 
-/* legacy parameter */
-static int force_inquiry_hack;
-module_param(force_inquiry_hack, int, 0644);
-MODULE_PARM_DESC(force_inquiry_hack, "Deprecated, use 'workarounds'");
-
 /*
  * Export information about protocols/devices supported by this driver.
  */
@@ -1564,11 +1559,6 @@ static void sbp2_parse_unit_directory(st
 	}
 
 	workarounds = sbp2_default_workarounds;
-	if (force_inquiry_hack) {
-		SBP2_WARN("force_inquiry_hack is deprecated. "
-			  "Use parameter 'workarounds' instead.");
-		workarounds |= SBP2_WORKAROUND_INQUIRY_36;
-	}
 
 	if (!(workarounds & SBP2_WORKAROUND_OVERRIDE))
 		for (i = 0; i < ARRAY_SIZE(sbp2_workarounds_table); i++) {



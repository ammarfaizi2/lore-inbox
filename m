Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbWG2Rs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbWG2Rs3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 13:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbWG2Rs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 13:48:29 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:786 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932187AbWG2Rs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 13:48:28 -0400
Date: Sat, 29 Jul 2006 19:48:28 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] the scheduled removal of drivers/ieee1394/sbp2.c:force_inquiry_hack
Message-ID: <20060729174828.GC26963@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the scheduled removal of the force_inquiry_hack 
module parameter.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 Documentation/feature-removal-schedule.txt |    9 ---------
 drivers/ieee1394/sbp2.c                    |   10 ----------
 2 files changed, 19 deletions(-)

--- linux-2.6.18-rc2-mm1-full/Documentation/feature-removal-schedule.txt.old	2006-07-27 20:36:51.000000000 +0200
+++ linux-2.6.18-rc2-mm1-full/Documentation/feature-removal-schedule.txt	2006-07-27 20:37:00.000000000 +0200
@@ -23,15 +23,6 @@
 
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
--- linux-2.6.18-rc2-mm1-full/drivers/ieee1394/sbp2.c.old	2006-07-27 20:37:10.000000000 +0200
+++ linux-2.6.18-rc2-mm1-full/drivers/ieee1394/sbp2.c	2006-07-27 20:37:23.000000000 +0200
@@ -173,11 +173,6 @@
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
@@ -1554,11 +1549,6 @@
 	}
 
 	workarounds = sbp2_default_workarounds;
-	if (force_inquiry_hack) {
-		SBP2_WARN("force_inquiry_hack is deprecated. "
-			  "Use parameter 'workarounds' instead.");
-		workarounds |= SBP2_WORKAROUND_INQUIRY_36;
-	}
 
 	if (!(workarounds & SBP2_WORKAROUND_OVERRIDE))
 		for (i = 0; i < ARRAY_SIZE(sbp2_workarounds_table); i++) {


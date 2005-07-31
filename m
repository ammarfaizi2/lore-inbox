Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261747AbVGaTyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbVGaTyb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 15:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbVGaTya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 15:54:30 -0400
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]:21011 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S261747AbVGaTy2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 15:54:28 -0400
Date: Sun, 31 Jul 2005 21:54:28 +0200
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>
Cc: Greg KH <greg@kroah.com>
Subject: [PATCH 2.6] (8/11) hwmon vs i2c, second round
Message-Id: <20050731215428.64c7fc99.khali@linux-fr.org>
In-Reply-To: <20050731205933.2e2a957f.khali@linux-fr.org>
References: <20050731205933.2e2a957f.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup hwmon-vid a bit, fixing typos, rewording some comments and
reindenting properly at places.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/hwmon/hwmon-vid.c |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

--- linux-2.6.13-rc4.orig/drivers/hwmon/hwmon-vid.c	2005-07-31 16:59:30.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/hwmon-vid.c	2005-07-31 20:55:50.000000000 +0200
@@ -38,14 +38,14 @@
 	{X86_VENDOR_AMD, 0x6, ANY, 90},		/* Athlon Duron etc */
 	{X86_VENDOR_AMD, 0xF, ANY, 24},		/* Athlon 64, Opteron */
 	{X86_VENDOR_INTEL, 0x6, 0x9, 85},	/* 0.13um too */
-	{X86_VENDOR_INTEL, 0x6, 0xB, 85},	/* 0xB Tualatin */
+	{X86_VENDOR_INTEL, 0x6, 0xB, 85},	/* Tualatin */
 	{X86_VENDOR_INTEL, 0x6, ANY, 82},	/* any P6 */
 	{X86_VENDOR_INTEL, 0x7, ANY, 0},	/* Itanium */
 	{X86_VENDOR_INTEL, 0xF, 0x3, 100},	/* P4 Prescott */
 	{X86_VENDOR_INTEL, 0xF, ANY, 90},	/* P4 before Prescott */
 	{X86_VENDOR_INTEL, 0x10,ANY, 0},	/* Itanium 2 */
 	{X86_VENDOR_UNKNOWN, ANY, ANY, 0}	/* stop here */
-	};
+};
 
 static int find_vrm(u8 eff_family, u8 eff_model, u8 vendor)
 {
@@ -53,9 +53,9 @@
 
 	while (vrm_models[i].vendor!=X86_VENDOR_UNKNOWN) {
 		if (vrm_models[i].vendor==vendor)
-			if ((vrm_models[i].eff_family==eff_family)&& \
-			((vrm_models[i].eff_model==eff_model)|| \
-			(vrm_models[i].eff_model==ANY)))
+			if ((vrm_models[i].eff_family==eff_family)
+			 && ((vrm_models[i].eff_model==eff_model) ||
+			     (vrm_models[i].eff_model==ANY)))
 				return vrm_models[i].vrm_type;
 		i++;
 	}
@@ -70,8 +70,9 @@
 	u8 eff_family, eff_model;
 	int vrm_ret;
 
-	if (c->x86 < 6) return 0;	/* any CPU with familly lower than 6
-				 	dont have VID and/or CPUID */
+	if (c->x86 < 6)		/* Any CPU with family lower than 6 */
+		return 0;	/* doesn't have VID and/or CPUID */
+
 	eax = cpuid_eax(1);
 	eff_family = ((eax & 0x00000F00)>>8);
 	eff_model  = ((eax & 0x000000F0)>>4);
@@ -81,12 +82,12 @@
 	}
 	vrm_ret = find_vrm(eff_family,eff_model,c->x86_vendor);
 	if (vrm_ret == 0)
-		printk(KERN_INFO "hwmon-vid: Unknown VRM version of your"
-		" x86 CPU\n");
+		printk(KERN_INFO "hwmon-vid: Unknown VRM version of your "
+		       "x86 CPU\n");
 	return vrm_ret;
 }
 
-/* and now for something completely different for Non-x86 world*/
+/* and now something completely different for the non-x86 world */
 #else
 int vid_which_vrm(void)
 {


-- 
Jean Delvare

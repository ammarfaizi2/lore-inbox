Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262188AbUJZCVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbUJZCVR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 22:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbUJZCU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 22:20:59 -0400
Received: from [192.55.52.67] ([192.55.52.67]:32713 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S262157AbUJZCSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 22:18:51 -0400
Date: Tue, 26 Oct 2004 10:01:40 +0800 (CST)
From: "Zhu, Yi" <yi.zhu@intel.com>
X-X-Sender: chuyee@mazda.sh.intel.com
Reply-To: "Zhu, Yi" <yi.zhu@intel.com>
To: Andrew Morton <akpm@osdl.org>
cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] [swsusp] print error message when swapping is disabled (fwd)
Message-ID: <Pine.LNX.4.44.0410260949340.18363-100000@mazda.sh.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew,

This patch gives some clues to the user when swapping is not enabled during
swsusp. Please apply.


Signed-off-by: Zhu Yi <yi.zhu@intel.com>

--- linux-2.6.9-orig/kernel/power/swsusp.c	2004-10-24 16:16:41.000000000 +0800
+++ linux-2.6.9/kernel/power/swsusp.c	2004-10-24 16:15:06.000000000 +0800
@@ -843,8 +843,11 @@ asmlinkage int swsusp_save(void)
 {
 	int error = 0;
 
-	if ((error = swsusp_swap_check()))
+	if ((error = swsusp_swap_check())) {
+		printk(KERN_ERR "swsusp: FATAL: cannot find swap device, try "
+				"swapon -a!\n");
 		return error;
+	}
 	return suspend_prepare_image();
 }
 


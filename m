Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261664AbUJYC4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbUJYC4R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 22:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbUJYC4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 22:56:17 -0400
Received: from fmr05.intel.com ([134.134.136.6]:43654 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S261664AbUJYC4N convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 22:56:13 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH] [swsusp] print error message when swapping is disabled
Date: Mon, 25 Oct 2004 10:56:03 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8403BD57DA@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] [swsusp] print error message when swapping is disabled
Thread-Index: AcS6Pjj5z/NyqcIbTfuhBMGdCz/wXA==
From: "Zhu, Yi" <yi.zhu@intel.com>
To: "Pavel Machek" <pavel@ucw.cz>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 25 Oct 2004 02:56:03.0881 (UTC) FILETIME=[2A9BD190:01C4BA3E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

swsusp exits silently when swapping is disabled. This patch gives some
clues to
the user in this case. Please apply.

Thanks,
-yi

Signed-off-by: Zhu Yi <yi.zhu@intel.com>

--- linux-2.6.9-orig/kernel/power/swsusp.c	2004-10-24
16:16:41.000000000 +0800
+++ linux-2.6.9/kernel/power/swsusp.c	2004-10-24 16:15:06.000000000
+0800
@@ -843,8 +843,11 @@ asmlinkage int swsusp_save(void)
 {
 	int error = 0;
 
-	if ((error = swsusp_swap_check()))
+	if ((error = swsusp_swap_check())) {
+		printk(KERN_ERR "swsusp: FATAL: cannot find swap device,
try "
+				"swap -a!\n");
 		return error;
+	}
 	return suspend_prepare_image();
 }
 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261731AbVCYSWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbVCYSWH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 13:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261729AbVCYSWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 13:22:07 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:40458 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261731AbVCYSVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 13:21:52 -0500
Date: Fri, 25 Mar 2005 19:21:49 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] sound/oss/gus_wave.c: fix off by one errors
Message-ID: <20050325182149.GC3153@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes two off by one errors found by the Coverity checker.
In both cases, the variables are later used as indexes for arrays with 
MAX_PATCH elements.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc1-mm1-full/sound/oss/gus_wave.c.old	2005-03-23 03:19:25.000000000 +0100
+++ linux-2.6.12-rc1-mm1-full/sound/oss/gus_wave.c	2005-03-23 03:20:42.000000000 +0100
@@ -1085,7 +1085,7 @@
 {
 	int sample_no;
 
-	if (instr_no < 0 || instr_no > MAX_PATCH)
+	if (instr_no < 0 || instr_no >= MAX_PATCH)
 		instr_no = 0;	/* Default to acoustic piano */
 
 	if (voice < 0 || voice > 31)
@@ -1676,7 +1676,7 @@
 
 	instr = patch.instr_no;
 
-	if (instr < 0 || instr > MAX_PATCH)
+	if (instr < 0 || instr >= MAX_PATCH)
 	{
 /*		printk(KERN_ERR "GUS: Invalid patch number %d\n", instr);*/
 		return -EINVAL;


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264768AbTFLGuA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 02:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264775AbTFLGsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 02:48:13 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:54194 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264770AbTFLGrI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 02:47:08 -0400
Date: Thu, 12 Jun 2003 12:37:07 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patchset] Fix sign handling bugs in 2.5 -- 3/5; mpt fusion
Message-ID: <20030612070705.GD1146@llm08.in.ibm.com>
References: <20030612070330.GA1146@llm08.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030612070330.GA1146@llm08.in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- linux-2.5.70/drivers/message/fusion/mptbase.c	Tue May 27 06:30:26 2003
+++ shb-mpt-2.5.70/drivers/message/fusion/mptbase.c	Wed Jun 11 15:11:44 2003
@@ -1822,6 +1822,7 @@
 	if (this != NULL) {
 		int sz;
 		u32 state;
+		int ret;
 
 		/* Disable the FW */
 		state = mpt_GetIocState(this, 1);
@@ -1832,9 +1833,9 @@
 		if (this->cached_fw != NULL) {
 			ddlprintk((KERN_INFO MYNAM ": Pushing FW onto adapter\n"));
 
-			if ((state = mpt_downloadboot(this, NO_SLEEP)) < 0) {
+			if ((ret = mpt_downloadboot(this, NO_SLEEP)) < 0) {
 				printk(KERN_WARNING MYNAM
-					": firmware downloadboot failure (%d)!\n", state);
+					": firmware downloadboot failure (%d)!\n", ret);
 			}
 		}
 

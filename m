Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261199AbVFBQ4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbVFBQ4I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 12:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbVFBQ4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 12:56:08 -0400
Received: from quark.didntduck.org ([69.55.226.66]:59594 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S261199AbVFBQ4D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 12:56:03 -0400
Message-ID: <429F3A9E.504@didntduck.org>
Date: Thu, 02 Jun 2005 12:58:06 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: davej@codemonkey.org.uk
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix warning in powernow-k8.c
Content-Type: multipart/mixed;
 boundary="------------050903040400040806010609"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050903040400040806010609
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Fix this warning:
powernow-k8.c: In function ‘query_current_values_with_pending_wait’:
powernow-k8.c:110: warning: ‘hi’ may be used uninitialized in this function

Signed-off-by: Brian Gerst <bgerst@didntduck.org>

--------------050903040400040806010609
Content-Type: text/plain;
 name="powernow-k8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="powernow-k8"

diff --git a/arch/i386/kernel/cpu/cpufreq/powernow-k8.c b/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
--- a/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
+++ b/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
@@ -110,14 +110,13 @@ static int query_current_values_with_pen
 	u32 lo, hi;
 	u32 i = 0;
 
-	lo = MSR_S_LO_CHANGE_PENDING;
-	while (lo & MSR_S_LO_CHANGE_PENDING) {
+	do {
 		if (i++ > 0x1000000) {
 			printk(KERN_ERR PFX "detected change pending stuck\n");
 			return 1;
 		}
 		rdmsr(MSR_FIDVID_STATUS, lo, hi);
-	}
+	} while (lo & MSR_S_LO_CHANGE_PENDING);
 
 	data->currvid = hi & MSR_S_HI_CURRENT_VID;
 	data->currfid = lo & MSR_S_LO_CURRENT_FID;

--------------050903040400040806010609--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265970AbUIME2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265970AbUIME2Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 00:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265943AbUIME2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 00:28:24 -0400
Received: from gate.crashing.org ([63.228.1.57]:19585 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265487AbUIME2U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 00:28:20 -0400
Subject: [PATCH] ppc64:Fix missing register in altivec context switch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1095049526.2543.253.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 13 Sep 2004 14:25:27 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a resend of a patch sent in July and that got lost somewhat,
the "VSCR" register wasn't restored properly from the context on
load_up_altivec (typo), please apply the fix:

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

===== arch/ppc64/kernel/head.S 1.76 vs edited =====
--- 1.76/arch/ppc64/kernel/head.S	2004-09-08 16:32:56 +10:00
+++ edited/arch/ppc64/kernel/head.S	2004-09-13 14:15:00 +10:00
@@ -1588,6 +1588,7 @@
 	li	r10,THREAD_VSCR
 	stw	r4,THREAD_USED_VR(r5)
 	lvx	vr0,r10,r5
+	mtvscr	vr0
 	REST_32VRS(0,r4,r5)
 #ifndef CONFIG_SMP
 	/* Update last_task_used_math to 'current' */



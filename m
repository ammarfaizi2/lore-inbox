Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbUCFAF6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 19:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbUCFAF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 19:05:58 -0500
Received: from gate.crashing.org ([63.228.1.57]:32459 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261497AbUCFAF4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 19:05:56 -0500
Subject: [PATCH] High BAT initialization wrong
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1078531490.5702.137.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 06 Mar 2004 11:04:51 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

The code initializing the "high" BATs on CPUs like the 750FX got
broken when copied over from 2.4. This cause random problems with
machines using those CPUs (iBook 2s typically). Please apply this
fix asap. Thanks.

===== arch/ppc/kernel/head.S 1.41 vs edited =====
--- 1.41/arch/ppc/kernel/head.S	Tue Feb 17 05:37:14 2004
+++ edited/arch/ppc/kernel/head.S	Sat Mar  6 11:03:00 2004
@@ -1492,22 +1492,22 @@
 	 * seems that doesn't affect our ability to actually
 	 * write to these SPRs.
 	 */
-	mtspr	SPRN_DBAT4U,r20
-	mtspr	SPRN_DBAT4L,r20
-	mtspr	SPRN_DBAT5U,r20
-	mtspr	SPRN_DBAT5L,r20
-	mtspr	SPRN_DBAT6U,r20
-	mtspr	SPRN_DBAT6L,r20
-	mtspr	SPRN_DBAT7U,r20
-	mtspr	SPRN_DBAT7L,r20
-	mtspr	SPRN_IBAT4U,r20
-	mtspr	SPRN_IBAT4L,r20
-	mtspr	SPRN_IBAT5U,r20
-	mtspr	SPRN_IBAT5L,r20
-	mtspr	SPRN_IBAT6U,r20
-	mtspr	SPRN_IBAT6L,r20
-	mtspr	SPRN_IBAT7U,r20
-	mtspr	SPRN_IBAT7L,r20
+	mtspr	SPRN_DBAT4U,r10
+	mtspr	SPRN_DBAT4L,r10
+	mtspr	SPRN_DBAT5U,r10
+	mtspr	SPRN_DBAT5L,r10
+	mtspr	SPRN_DBAT6U,r10
+	mtspr	SPRN_DBAT6L,r10
+	mtspr	SPRN_DBAT7U,r10
+	mtspr	SPRN_DBAT7L,r10
+	mtspr	SPRN_IBAT4U,r10
+	mtspr	SPRN_IBAT4L,r10
+	mtspr	SPRN_IBAT5U,r10
+	mtspr	SPRN_IBAT5L,r10
+	mtspr	SPRN_IBAT6U,r10
+	mtspr	SPRN_IBAT6L,r10
+	mtspr	SPRN_IBAT7U,r10
+	mtspr	SPRN_IBAT7L,r10
 END_FTR_SECTION_IFSET(CPU_FTR_HAS_HIGH_BATS)
 	blr
 



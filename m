Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbUCLAue (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 19:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261870AbUCLAue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 19:50:34 -0500
Received: from gate.crashing.org ([63.228.1.57]:54998 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261869AbUCLAuc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 19:50:32 -0500
Subject: [PATCH] ppc32: Fix G5 config space access lockup
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Dan Burcaw <dburcaw@terrasoftsolutions.com>
Content-Type: text/plain
Message-Id: <1079052360.24360.317.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 12 Mar 2004 11:46:00 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a typo in the code that prevents lockup on config space access
to sleeping devices on ppc32/G5. Please apply.

===== arch/ppc/platforms/pmac_feature.c 1.55 vs edited =====
--- 1.55/arch/ppc/platforms/pmac_feature.c	Wed Feb 18 16:49:46 2004
+++ edited/arch/ppc/platforms/pmac_feature.c	Fri Mar 12 11:44:41 2004
@@ -1359,7 +1359,7 @@
 		mb();
 		k2_skiplist[1] = NULL;
 	} else {
-		k2_skiplist[0] = pdev;
+		k2_skiplist[1] = pdev;
 		mb();
 		MACIO_BIC(KEYLARGO_FCR1, K2_FCR1_FW_CLK_ENABLE);
 	}



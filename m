Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267620AbUIXA20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267620AbUIXA20 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 20:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267619AbUIXA16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 20:27:58 -0400
Received: from gate.crashing.org ([63.228.1.57]:54752 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267620AbUIXAZt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 20:25:49 -0400
Subject: [PATCH] ppc32: Fix type/bug in pmac_feature.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1095985537.3830.23.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 24 Sep 2004 10:25:37 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

A typo in pmac_feature.c can cause us to use a bogus node pointer when
iterating the i2c controllers during boot. Fortunately, it seems that
we always find the one we are looking for first, and thus never ended
up in an inifinite loop here, but let's fix it and fix the warning at
the same time.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

===== arch/ppc/platforms/pmac_feature.c 1.26 vs edited =====
--- 1.26/arch/ppc/platforms/pmac_feature.c	2004-06-23 06:04:07 +10:00
+++ edited/arch/ppc/platforms/pmac_feature.c	2004-09-24 10:23:15 +10:00
@@ -2665,7 +2665,7 @@
 			struct device_node *p = of_get_parent(ui2c);
 			if (p && !strcmp(p->name, "uni-n"))
 				break;
-			ui2c = of_find_node_by_type(np, "i2c");
+			ui2c = of_find_node_by_type(ui2c, "i2c");
 		}
 		if (ui2c == NULL)
 			break;



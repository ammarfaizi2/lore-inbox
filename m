Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbWIZMWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbWIZMWF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 08:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWIZMWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 08:22:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:56205 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751174AbWIZMWD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 08:22:03 -0400
X-Authenticated: #704063
Subject: [Patch] Off-by-one in arch/arm/common/icst*
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 26 Sep 2006 14:22:00 +0200
Message-Id: <1159273320.6502.2.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

a quick find -iname \*.[ch] | xargs grep "> ARRAY_SIZE(", revealed
these in the icst drivers.
If i == ARRAY_SIZE, we get past the idx2s array.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.18-git5/arch/arm/common/icst307.c.orig	2006-09-26 14:17:06.000000000 +0200
+++ linux-2.6.18-git5/arch/arm/common/icst307.c	2006-09-26 14:17:40.000000000 +0200
@@ -57,7 +57,7 @@ icst307_khz_to_vco(const struct icst307_
 			break;
 	} while (i < ARRAY_SIZE(idx2s));
 
-	if (i > ARRAY_SIZE(idx2s))
+	if (i >= ARRAY_SIZE(idx2s))
 		return vco;
 
 	vco.s = idx2s[i];
@@ -119,7 +119,7 @@ icst307_ps_to_vco(const struct icst307_p
 			break;
 	} while (i < ARRAY_SIZE(idx2s));
 
-	if (i > ARRAY_SIZE(idx2s))
+	if (i >= ARRAY_SIZE(idx2s))
 		return vco;
 
 	vco.s = idx2s[i];
--- linux-2.6.18-git5/arch/arm/common/icst525.c.orig	2006-09-26 14:17:48.000000000 +0200
+++ linux-2.6.18-git5/arch/arm/common/icst525.c	2006-09-26 14:18:01.000000000 +0200
@@ -55,7 +55,7 @@ icst525_khz_to_vco(const struct icst525_
 			break;
 	} while (i < ARRAY_SIZE(idx2s));
 
-	if (i > ARRAY_SIZE(idx2s))
+	if (i >= ARRAY_SIZE(idx2s))
 		return vco;
 
 	vco.s = idx2s[i];
@@ -118,7 +118,7 @@ icst525_ps_to_vco(const struct icst525_p
 			break;
 	} while (i < ARRAY_SIZE(idx2s));
 
-	if (i > ARRAY_SIZE(idx2s))
+	if (i >= ARRAY_SIZE(idx2s))
 		return vco;
 
 	vco.s = idx2s[i];



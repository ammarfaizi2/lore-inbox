Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268701AbUILLkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268701AbUILLkA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 07:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268688AbUILLjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 07:39:22 -0400
Received: from aun.it.uu.se ([130.238.12.36]:17662 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S268681AbUILLeY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 07:34:24 -0400
Date: Sun, 12 Sep 2004 13:34:03 +0200 (MEST)
Message-Id: <200409121134.i8CBY3Lm015276@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: ajoshi@kernel.crashing.org, ajoshi@shell.unixbox.com,
       marcelo.tosatti@cyclades.com
Subject: [PATCH][2.4.28-pre3] RIVA driver gcc-3.4 fix
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a gcc-3.4 cast-as-lvalue warning in the 2.4.28-pre3
kernel's RIVA video driver. The change is new since the 2.6 code is
different.

/Mikael

--- linux-2.4.28-pre3/drivers/video/riva/accel.c.~1~	2004-08-08 10:56:31.000000000 +0200
+++ linux-2.4.28-pre3/drivers/video/riva/accel.c	2004-09-12 01:56:20.000000000 +0200
@@ -153,8 +153,10 @@
 		for (j = 0; j < cnt; j++) {
 			if (w <= 8) 
 				cdat2 = *cdat++;
-			else
-				cdat2 = *((u16*)cdat)++;
+			else {
+				cdat2 = *(u16*)cdat;
+				cdat += sizeof(u16);
+			}
 			fbcon_reverse_order(&cdat2);
 			d[j] = cdat2;
 		}

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbUILUHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbUILUHQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 16:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbUILUHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 16:07:16 -0400
Received: from aun.it.uu.se ([130.238.12.36]:57752 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261239AbUILUHF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 16:07:05 -0400
Date: Sun, 12 Sep 2004 22:06:52 +0200 (MEST)
Message-Id: <200409122006.i8CK6qZe016054@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: marcelo.tosatti@cyclades.com, paulus@samba.org
Subject: [PATCH][2.4.28-pre3] PPC32 PReP residual data gcc-3.4 fix
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a gcc-3.4 cast-as-lvalue warning in the 2.4.28-pre3
kernel's arch/ppc/platform/residual.c. The change is a backport from
the 2.6 kernel.

/Mikael

--- linux-2.4.28-pre3/arch/ppc/platforms/residual.c.~1~	2003-08-25 20:07:42.000000000 +0200
+++ linux-2.4.28-pre3/arch/ppc/platforms/residual.c	2004-09-12 21:32:52.000000000 +0200
@@ -493,7 +493,7 @@
 			size=tag_small_count(pkt->S1_Pack.Tag)+1;
 			printsmallpacket(pkt, size);
 		}
-		(unsigned char *) pkt+=size;
+		pkt = (PnP_TAG_PACKET *)((unsigned char *) pkt + size);
 	} while (pkt->S1_Pack.Tag != END_TAG);
 }
 

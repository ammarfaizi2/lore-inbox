Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263685AbTCUSaN>; Fri, 21 Mar 2003 13:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263700AbTCUS30>; Fri, 21 Mar 2003 13:29:26 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:60035
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263708AbTCUS2g>; Fri, 21 Mar 2003 13:28:36 -0500
Date: Fri, 21 Mar 2003 19:43:51 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211943.h2LJhpKm025923@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: fix pcmcia crash with hostap
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/pcmcia/cs.c linux-2.5.65-ac2/drivers/pcmcia/cs.c
--- linux-2.5.65/drivers/pcmcia/cs.c	2003-03-03 19:20:10.000000000 +0000
+++ linux-2.5.65-ac2/drivers/pcmcia/cs.c	2003-03-14 01:11:43.000000000 +0000
@@ -895,6 +895,10 @@
 	c = &s->config[reg->Function];
     } else
 	c = CONFIG(handle);
+
+    if (c == NULL)
+	return CS_NO_CARD;
+
     if (!(c->state & CONFIG_LOCKED))
 	return CS_CONFIGURATION_LOCKED;
 

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272584AbTG1AFd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 20:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272583AbTG1AE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:04:56 -0400
Received: from zeus.kernel.org ([204.152.189.113]:28659 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272716AbTG0W6N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 18:58:13 -0400
Date: Sun, 27 Jul 2003 21:12:05 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307272012.h6RKC5uJ029684@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: fix pcmcia_cs without ISA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Taral)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/pcmcia/cs.c linux-2.6.0-test2-ac1/drivers/pcmcia/cs.c
--- linux-2.6.0-test2/drivers/pcmcia/cs.c	2003-07-14 14:11:56.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/pcmcia/cs.c	2003-07-15 17:51:34.000000000 +0100
@@ -1958,6 +1958,9 @@
 	    irq = req->IRQInfo1 & IRQ_MASK;
 	    ret = try_irq(req->Attributes, irq, 1);
 	}
+#else
+    } else {
+	ret = CS_UNSUPPORTED_MODE;
 #endif
     }
     if (ret != 0) return ret;

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262335AbVAVRcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262335AbVAVRcw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 12:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbVAVRcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 12:32:52 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:64977 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262335AbVAVRct convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 12:32:49 -0500
Cc: linux-kernel@vger.kernel.org, js@linuxtv.org
In-Reply-To: <1106415266247@linuxtv.org>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Sat, 22 Jan 2005 18:34:26 +0100
Message-Id: <11064152661677@linuxtv.org>
Mime-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
From: Johannes Stezenbach <js@linuxtv.org>
X-SA-Exim-Connect-IP: 217.231.47.99
Subject: [PATCH 1/9] fix RPS init race
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- [DVB] saa7146: explicitely disable RPS tasks in saa7146_init_one()

Signed-off-by: Michael Hunold <hunold@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

diff -uraNwB linux-2.6.11-rc2/drivers/media/common/saa7146_core.c linux-2.6.11-rc2-dvb/drivers/media/common/saa7146_core.c
--- linux-2.6.11-rc2/drivers/media/common/saa7146_core.c	2005-01-20 19:55:47.000000000 +0100
+++ linux-2.6.11-rc2-dvb/drivers/media/common/saa7146_core.c	2005-01-20 19:56:37.000000000 +0100
@@ -380,8 +380,8 @@
 	/* disable all irqs */
 	saa7146_write(dev, IER, 0);
 
-	/* shut down all dma transfers */
-	saa7146_write(dev, MC1, 0x00ff0000);
+	/* shut down all dma transfers and rps tasks */
+	saa7146_write(dev, MC1, 0x30ff0000);
 
 	/* clear out any rps-signals pending */
 	saa7146_write(dev, MC2, 0xf8000000);


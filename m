Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261748AbVAYAbi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbVAYAbi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 19:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbVAYAbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 19:31:06 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:49643 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S261754AbVAYAaT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 19:30:19 -0500
Cc: linux-kernel@vger.kernel.org, js@linuxtv.org
In-Reply-To: <11066130981300@linuxtv.org>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Tue, 25 Jan 2005 01:31:39 +0100
Message-Id: <11066130991010@linuxtv.org>
Mime-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
From: Johannes Stezenbach <js@linuxtv.org>
X-SA-Exim-Connect-IP: 217.86.181.249
Subject: [PATCH 2/4] fix access to freed memory
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- [DVB] core: fix access to freed memory when unloading frontend
  drivers (fix by Gerd Knorr)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

diff -rupN linux-2.6.11-rc2-bk2/drivers/media/dvb/dvb-core/dvb_frontend.c linux-2.6.11-rc2-bk2-dvb/drivers/media/dvb/dvb-core/dvb_frontend.c
--- linux-2.6.11-rc2-bk2/drivers/media/dvb/dvb-core/dvb_frontend.c	2005-01-24 23:18:39.000000000 +0100
+++ linux-2.6.11-rc2-bk2-dvb/drivers/media/dvb/dvb-core/dvb_frontend.c	2005-01-25 00:17:56.000000000 +0100
@@ -912,8 +912,9 @@ int dvb_unregister_frontend(struct dvb_f
 		fe->ops->release(fe);
 	else
 		printk("dvb_frontend: Demodulator (%s) does not have a release callback!\n", fe->ops->info.name);
-	if (fe->frontend_priv)
-		kfree(fe->frontend_priv);
+	/* fe is invalid now */
+	if (fepriv)
+		kfree(fepriv);
 	up (&frontend_mutex);
 	return 0;
 }


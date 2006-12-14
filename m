Return-Path: <linux-kernel-owner+w=401wt.eu-S964781AbWLNV4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbWLNV4q (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 16:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964840AbWLNV4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 16:56:46 -0500
Received: from sp604005mt.neufgp.fr ([84.96.92.11]:64435 "EHLO smtp.Neuf.fr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964781AbWLNV4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 16:56:45 -0500
X-Greylist: delayed 4504 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 16:56:45 EST
Date: Thu, 14 Dec 2006 21:25:20 +0100
From: nuxdoors@cegetel.net
Subject: [PATCH 2.6.19.1] sunkbd.c: fix sunkbd_enable(sunkbd, 0); obvious
To: vojtech@ucw.cz
Cc: linux-kernel@vger.kernel.org
Message-id: <4581B330.5040106@cegetel.net>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Debian Thunderbird 1.0.2 (X11/20060926)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabrice Knevez <nuxdoors@cegetel.net>

"sunkbd_enable(sunkbd, 0);" has no effect. Adding "sunkbd->enabled = enable" in sunkbd_enable (obvious)

Signed-off-by: Fabrice Knevez <nuxdoors@cegetel.net>

---

Sorry about thunderbird mangling the patch in the first email...
I don't have any sun keyboard, i was just reading the sources and it seemed like an obvious modification.

--- linux-2.6.19.1/drivers/input/keyboard/sunkbd.c.orig	2006-12-11 20:32:53.000000000 +0100
+++ linux-2.6.19.1/drivers/input/keyboard/sunkbd.c	2006-12-14 17:32:48.000000000 +0100
@@ -225,7 +225,7 @@ static void sunkbd_reinit(void *data)
 static void sunkbd_enable(struct sunkbd *sunkbd, int enable)
 {
 	serio_pause_rx(sunkbd->serio);
-	sunkbd->enabled = 1;
+	sunkbd->enabled = enable;
 	serio_continue_rx(sunkbd->serio);
 }




Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262168AbSJJTMY>; Thu, 10 Oct 2002 15:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262169AbSJJTMX>; Thu, 10 Oct 2002 15:12:23 -0400
Received: from www.microgate.com ([216.30.46.105]:30986 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP
	id <S262168AbSJJTME>; Thu, 10 Oct 2002 15:12:04 -0400
Subject: [PATCH] syncppp.c 2.5.41
From: Paul Fulghum <paulkf@microgate.com>
To: "davej@suse.de" <davej@suse.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.4 
Date: 10 Oct 2002 14:17:49 -0500
Message-Id: <1034277473.785.16.camel@diemos.microgate.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Remove cli()/restore()

Please apply

Paul Fulghum
paulkf@microgate.com


--- linux-2.5.41/drivers/net/wan/syncppp.c	Mon Oct  7 13:23:38 2002
+++ linux-2.5.41-mg/drivers/net/wan/syncppp.c	Wed Oct  9 15:55:47 2002
@@ -1284,12 +1284,12 @@
 {
 	struct sppp *sp = (struct sppp*) arg;
 	unsigned long flags;
-	save_flags(flags);
-	cli();
+
+	spin_lock_irqsave(&spppq_lock, flags);
 
 	sp->pp_flags &= ~PP_TIMO;
 	if (! (sp->pp_if->flags & IFF_UP) || (sp->pp_flags & PP_CISCO)) {
-		restore_flags(flags);
+		spin_unlock_irqrestore(&spppq_lock, flags);
 		return;
 	}
 	switch (sp->lcp.state) {
@@ -1328,7 +1328,7 @@
 		}
 		break;
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&spppq_lock, flags);
 }
 
 static char *sppp_lcp_type_name (u8 type)




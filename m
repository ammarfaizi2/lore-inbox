Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266182AbUBBU4f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 15:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266174AbUBBUzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 15:55:09 -0500
Received: from mailr-1.tiscali.it ([212.123.84.81]:56948 "EHLO
	mailr-1.tiscali.it") by vger.kernel.org with ESMTP id S265881AbUBBT5f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 14:57:35 -0500
X-BrightmailFiltered: true
Date: Mon, 2 Feb 2004 20:57:32 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Compile Regression in 2.4.25-pre8][PATCH 24/42]
Message-ID: <20040202195732.GX6785@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040130204956.GA21643@dreamland.darkstar.lan> <Pine.LNX.4.58L.0401301855410.3140@logos.cnet> <20040202180940.GA6367@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202180940.GA6367@dreamland.darkstar.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


irlmp.c:1244: warning: concatenation of string literals with __FUNCTION__ is deprecated
irlmp.c:1258: warning: concatenation of string literals with __FUNCTION__ is deprecated
irlmp.c:1277: warning: concatenation of string literals with __FUNCTION__ is deprecated
irlmp.c:1284: warning: concatenation of string literals with __FUNCTION__ is deprecated

Fix IRDA_DEBUG: __FUNCTION__ shouldn't be concatenated with other
literals.

diff -Nru -X dontdiff linux-2.4-vanilla/net/irda/irlmp.c linux-2.4/net/irda/irlmp.c
--- linux-2.4-vanilla/net/irda/irlmp.c	Fri Jun 13 16:51:39 2003
+++ linux-2.4/net/irda/irlmp.c	Sat Jan 31 18:11:40 2004
@@ -1241,7 +1241,7 @@
 	/* Get the number of lsap. That's the only safe way to know
 	 * that we have looped around... - Jean II */
 	lsap_todo = HASHBIN_GET_SIZE(self->lsaps);
-	IRDA_DEBUG(4, __FUNCTION__ "() : %d lsaps to scan\n", lsap_todo);
+	IRDA_DEBUG(4, "%s() : %d lsaps to scan\n", __FUNCTION__, lsap_todo);
 
 	/* Poll lsap in order until the queue is full or until we
 	 * tried them all.
@@ -1255,7 +1255,7 @@
 			/* Note that if there is only one LSAP on the LAP
 			 * (most common case), self->flow_next is always NULL,
 			 * so we always avoid this loop. - Jean II */
-			IRDA_DEBUG(4, __FUNCTION__ "() : searching my LSAP\n");
+			IRDA_DEBUG(4, "%s() : searching my LSAP\n", __FUNCTION__);
 
 			/* We look again in hashbins, because the lsap
 			 * might have gone away... - Jean II */
@@ -1274,14 +1274,14 @@
 
 		/* Next time, we will get the next one (or the first one) */
 		self->flow_next = (struct lsap_cb *) hashbin_get_next(self->lsaps);
-		IRDA_DEBUG(4, __FUNCTION__ "() : curr is %p, next was %p and is now %p, still %d to go - queue len = %d\n", curr, next, self->flow_next, lsap_todo, IRLAP_GET_TX_QUEUE_LEN(self->irlap));
+		IRDA_DEBUG(4, "() : curr is %p, next was %p and is now %p, still %d to go - queue len = %d\n", __FUNCTION__, curr, next, self->flow_next, lsap_todo, IRLAP_GET_TX_QUEUE_LEN(self->irlap));
 
 		/* Inform lsap user that it can send one more packet. */
 		if (curr->notify.flow_indication != NULL)
 			curr->notify.flow_indication(curr->notify.instance, 
 						     curr, flow);
 		else
-			IRDA_DEBUG(1, __FUNCTION__ "(), no handler\n");
+			IRDA_DEBUG(1, "%s(), no handler\n", __FUNCTION__);
 	}
 }
 

-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Tentare e` il primo passo verso il fallimento.
Homer J. Simpson

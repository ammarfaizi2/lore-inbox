Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbVCOOGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbVCOOGH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 09:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbVCOOGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 09:06:07 -0500
Received: from aun.it.uu.se ([130.238.12.36]:44522 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261243AbVCOOGA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 09:06:00 -0500
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16950.60358.188803.1502@alkaid.it.uu.se>
Date: Tue, 15 Mar 2005 15:05:58 +0100
To: linux-kernel@vger.kernel.org
Subject: [PATCH][2.6.11] drivers/net/arcnet/arcnet.c gcc4 fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix

drivers/net/arcnet/arcnet.c: In function 'release_arcbuf':
drivers/net/arcnet/arcnet.c:256: warning: operation on 'i' may be undefined
drivers/net/arcnet/arcnet.c: In function 'get_arcbuf':
drivers/net/arcnet/arcnet.c:292: warning: operation on 'i' may be undefined

warnings from gcc4 in arcnet.c.

/Mikael

--- linux-2.6.11/drivers/net/arcnet/arcnet.c.~1~	2005-03-02 19:24:16.000000000 +0100
+++ linux-2.6.11/drivers/net/arcnet/arcnet.c	2005-03-15 14:32:49.000000000 +0100
@@ -253,7 +253,7 @@ static void release_arcbuf(struct net_de
 	BUGLVL(D_DURING) {
 		BUGMSG(D_DURING, "release_arcbuf: freed #%d; buffer queue is now: ",
 		       bufnum);
-		for (i = lp->next_buf; i != lp->first_free_buf; i = ++i % 5)
+		for (i = lp->next_buf; i != lp->first_free_buf; i = (i+1) % 5)
 			BUGMSG2(D_DURING, "#%d ", lp->buf_queue[i]);
 		BUGMSG2(D_DURING, "\n");
 	}
@@ -289,7 +289,7 @@ static int get_arcbuf(struct net_device 
 
 	BUGLVL(D_DURING) {
 		BUGMSG(D_DURING, "get_arcbuf: got #%d; buffer queue is now: ", buf);
-		for (i = lp->next_buf; i != lp->first_free_buf; i = ++i % 5)
+		for (i = lp->next_buf; i != lp->first_free_buf; i = (i+1) % 5)
 			BUGMSG2(D_DURING, "#%d ", lp->buf_queue[i]);
 		BUGMSG2(D_DURING, "\n");
 	}

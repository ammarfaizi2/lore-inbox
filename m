Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933722AbWKYPZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933722AbWKYPZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 10:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757389AbWKYPZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 10:25:57 -0500
Received: from smtp12.orange.fr ([193.252.22.20]:50526 "EHLO
	smtp-msa-out12.orange.fr") by vger.kernel.org with ESMTP
	id S1757380AbWKYPZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 10:25:56 -0500
X-ME-UUID: 20061125152555451.6E2DB1C00090@mwinf1203.orange.fr
Date: Sat, 25 Nov 2006 17:26:49 +0200
From: Samuel Ortiz <samuel@sortiz.org>
To: Linus Torvalds <torvalds@osdl.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: irda-users@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Andrey Borzenkov <arvidjaar@mail.ru>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Revert "[IRDA]: Lockdep fix."
Message-ID: <20061125152649.GA5698@sortiz.org>
Reply-To: Samuel Ortiz <samuel@sortiz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

commit 700f9672c9a61c12334651a94d17ec04620e1976 breaks IrDA as irlmp.c
can no longer build. 
This is due to the spin_lock_irqsave_nested() patches being in the -mm 
tree and not yet in yours.
I'll resend the patch once both trees are synchronized.

This reverts commit 700f9672c9a61c12334651a94d17ec04620e1976.
Signed-off-by: Samuel Ortiz <samuel@sortiz.org>

---
 net/irda/irlmp.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/net/irda/irlmp.c b/net/irda/irlmp.c
index fede837..5073261 100644
--- a/net/irda/irlmp.c
+++ b/net/irda/irlmp.c
@@ -1678,8 +1678,7 @@ #endif /* CONFIG_IRDA_ULTRA */
 	 *  every IrLAP connection and check every LSAP associated with each
 	 *  the connection.
 	 */
-	spin_lock_irqsave_nested(&irlmp->links->hb_spinlock, flags,
-			SINGLE_DEPTH_NESTING);
+	spin_lock_irqsave(&irlmp->links->hb_spinlock, flags);
 	lap = (struct lap_cb *) hashbin_get_first(irlmp->links);
 	while (lap != NULL) {
 		IRDA_ASSERT(lap->magic == LMP_LAP_MAGIC, goto errlap;);
-- 
1.4.2.3

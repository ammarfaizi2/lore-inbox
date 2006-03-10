Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbWCJXCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbWCJXCf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 18:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752248AbWCJXCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 18:02:35 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:27908 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751257AbWCJXCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 18:02:34 -0500
Date: Sat, 11 Mar 2006 00:02:33 +0100
From: Adrian Bunk <bunk@stusta.de>
To: patrick@tykepenguin.com
Cc: linux-decnet-user@lists.sourceforge.net, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/decnet/dn_route.c: fix inconsequent NULL checking
Message-ID: <20060310230233.GB21864@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker noted this inconsequent NULL checking in
dnrt_drop().

Since all callers ensure that NULL isn't passed, we can simply remove 
the check.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc5-mm3-full/net/decnet/dn_route.c.old	2006-03-10 23:34:57.000000000 +0100
+++ linux-2.6.16-rc5-mm3-full/net/decnet/dn_route.c	2006-03-10 23:35:08.000000000 +0100
@@ -149,8 +149,7 @@ static inline void dnrt_free(struct dn_r
 
 static inline void dnrt_drop(struct dn_route *rt)
 {
-	if (rt)
-		dst_release(&rt->u.dst);
+	dst_release(&rt->u.dst);
 	call_rcu_bh(&rt->u.dst.rcu_head, dst_rcu_free);
 }
 


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964869AbWGEUrr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbWGEUrr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 16:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964885AbWGEUrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 16:47:47 -0400
Received: from 1wt.eu ([62.212.114.60]:52489 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S964869AbWGEUrq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 16:47:46 -0400
Date: Wed, 5 Jul 2006 22:47:06 +0200
From: Willy Tarreau <w@1wt.eu>
To: marcelo@kvack.org, davem@davemloft.net
Cc: matthew@wil.cx, linux-kernel@vger.kernel.org, stable@kernel.org
Subject: [PATCH-2.4] 2 oopses in ethtool
Message-ID: <20060705204706.GA254@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

I got an oops today with 2.4.33-rc2 when playing ethtool games on my TG3
NIC. It was caused by a typo in ethtool.c, and while fixing it, I discovered
a second one.

David, a quick check showed that 2.6.17.1 has the first one fixed but not
second one (ethtool_set_pauseparam), so you might want to merge it too.

Cheers,
Willy

From: Willy Tarreau <willy@wtap.(none)>
Date: Wed, 5 Jul 2006 22:34:52 +0200
Subject: [PATCH] ethtool: two oopses in ethtool_set_coalesce() and ethtool_set_pauseparam()

The function pointers which were checked were for their get_* counterparts.
Typically a copy-paste typo.

Signed-off-by: Willy Tarreau <w@1wt.eu>

---

 net/core/ethtool.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

d249002f5f8141f98a4f625e7333bf3c49768575
diff --git a/net/core/ethtool.c b/net/core/ethtool.c
index e140eb3..89c1031 100644
--- a/net/core/ethtool.c
+++ b/net/core/ethtool.c
@@ -349,7 +349,7 @@ static int ethtool_set_coalesce(struct n
 {
 	struct ethtool_coalesce coalesce;
 
-	if (!dev->ethtool_ops->get_coalesce)
+	if (!dev->ethtool_ops->set_coalesce)
 		return -EOPNOTSUPP;
 
 	if (copy_from_user(&coalesce, useraddr, sizeof(coalesce)))
@@ -403,7 +403,7 @@ static int ethtool_set_pauseparam(struct
 {
 	struct ethtool_pauseparam pauseparam;
 
-	if (!dev->ethtool_ops->get_pauseparam)
+	if (!dev->ethtool_ops->set_pauseparam)
 		return -EOPNOTSUPP;
 
 	if (copy_from_user(&pauseparam, useraddr, sizeof(pauseparam)))
-- 
1.3.3


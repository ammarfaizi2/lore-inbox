Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932459AbVHKW5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbVHKW5K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 18:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbVHKW5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 18:57:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24451 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932459AbVHKW5I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 18:57:08 -0400
Message-Id: <20050811225552.551843000@localhost.localdomain>
References: <20050811225445.404816000@localhost.localdomain>
Date: Thu, 11 Aug 2005 15:54:46 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Eric Dumazet <dada1@cosmosbay.com>, Andi Kleen <ak@suse.de>,
       Chris Wright <chrisw@osdl.org>
Subject: [patch 1/8] [PATCH] sys_set_mempolicy() doesnt check if mode < 0
Content-Disposition: inline; filename=sys_set_mempolicy-mode-check.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any  objections, please let us know.
------------------


A kernel BUG() is triggered by a call to set_mempolicy() with a negative
first argument.  This is because the mode is declared as an int, and the
validity check doesnt check < 0 values.  Alternatively, mode could be
declared as unsigned int or unsigned long.

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>
Cc: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---
 mm/mempolicy.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.12.y/mm/mempolicy.c
===================================================================
--- linux-2.6.12.y.orig/mm/mempolicy.c
+++ linux-2.6.12.y/mm/mempolicy.c
@@ -409,7 +409,7 @@ asmlinkage long sys_set_mempolicy(int mo
 	struct mempolicy *new;
 	DECLARE_BITMAP(nodes, MAX_NUMNODES);
 
-	if (mode > MPOL_MAX)
+	if (mode < 0 || mode > MPOL_MAX)
 		return -EINVAL;
 	err = get_nodes(nodes, nmask, maxnode, mode);
 	if (err)

--

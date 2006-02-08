Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161016AbWBHGtV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161016AbWBHGtV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 01:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161017AbWBHGnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 01:43:05 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:47747 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1161014AbWBHGnA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 01:43:00 -0500
Message-Id: <20060208064907.692259000@sorel.sous-sol.org>
References: <20060208064503.924238000@sorel.sous-sol.org>
Date: Tue, 07 Feb 2006 22:45:18 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Stephen Smalley <sds@epoch.ncsc.mil>,
       Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>
Subject: [PATCH 15/23] [PATCH] SELinux: fix size-128 slab leak
Content-Disposition: inline; filename=selinux-fix-size-128-slab-leak.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Remove private inode tests from security_inode_alloc and security_inode_free,
as we otherwise end up leaking inode security structures for private inodes.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>
Acked-by: James Morris <jmorris@namei.org>
Signed-off-by:  Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 include/linux/security.h |    4 ----
 1 files changed, 4 deletions(-)

Index: linux-2.6.15.3/include/linux/security.h
===================================================================
--- linux-2.6.15.3.orig/include/linux/security.h
+++ linux-2.6.15.3/include/linux/security.h
@@ -1437,15 +1437,11 @@ static inline void security_sb_post_pivo
 
 static inline int security_inode_alloc (struct inode *inode)
 {
-	if (unlikely (IS_PRIVATE (inode)))
-		return 0;
 	return security_ops->inode_alloc_security (inode);
 }
 
 static inline void security_inode_free (struct inode *inode)
 {
-	if (unlikely (IS_PRIVATE (inode)))
-		return;
 	security_ops->inode_free_security (inode);
 }
 

--

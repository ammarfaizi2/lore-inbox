Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261943AbVCAPi6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbVCAPi6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 10:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261948AbVCAPi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 10:38:58 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:54622 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S261943AbVCAPhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 10:37:22 -0500
Date: Tue, 1 Mar 2005 10:37:21 -0500
From: Jeffrey Mahoney <jeffm@suse.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, Chris Wright <chrisw@osdl.org>
Subject: [PATCH 2/4] selinux: internal inode loop needs IS_PRIVATE test
Message-ID: <20050301153721.GC18215@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.111.19-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch applies the IS_PRIVATE test to the selinux internal inode loop.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>

diff -ruNpX dontdiff linux-2.6.9.base/security/selinux/hooks.c linux-2.6.9.private/security/selinux/hooks.c
--- linux-2.6.9.base/security/selinux/hooks.c	2004-11-19 14:40:58.000000000 -0500
+++ linux-2.6.9.private/security/selinux/hooks.c	2004-12-01 14:38:50.000000000 -0500
@@ -595,7 +595,8 @@ next_inode:
 		spin_unlock(&sbsec->isec_lock);
 		inode = igrab(inode);
 		if (inode) {
-			inode_doinit(inode);
+			if (!IS_PRIVATE (inode))
+				inode_doinit(inode);
 			iput(inode);
 		}
 		spin_lock(&sbsec->isec_lock);
-- 
Jeff Mahoney
SuSE Labs

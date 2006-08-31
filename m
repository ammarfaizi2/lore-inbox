Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932415AbWHaRtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbWHaRtI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 13:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbWHaRtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 13:49:08 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:21212 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932420AbWHaRtH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 13:49:07 -0400
Subject: [PATCH v2] Pass sparse the lock expression given to lock
	annotations
From: Josh Triplett <josht@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1156530118.19291.4.camel@josh-work.beaverton.ibm.com>
References: <1156530118.19291.4.camel@josh-work.beaverton.ibm.com>
Content-Type: text/plain
Date: Thu, 31 Aug 2006 10:49:14 -0700
Message-Id: <1157046554.4366.14.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The lock annotation macros __acquires, __releases, __acquire, and __release
all currently throw away the lock expression passed as an argument.  Now that
sparse can parse __context__ and __attribute__((context)) with a context
expression, pass the lock expression down to sparse as the context expression.
This requires a version of sparse from GIT commit
37475a6c1c3e66219e68d912d5eb833f4098fd72 or later.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
The current sparse GIT tree now includes my patch for parsing a context
expression; updated commit message to reference the GIT commit in the
sparse tree, and to fix a typo.  Please replace
"pass-sparse-the-lock-expression-given-to-lock-annotations.patch" in the
current -mm tree with this patch.

 include/linux/compiler.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index b3963cf..2ed6528 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -10,10 +10,10 @@ # define __safe		__attribute__((safe))
 # define __force	__attribute__((force))
 # define __nocast	__attribute__((nocast))
 # define __iomem	__attribute__((noderef, address_space(2)))
-# define __acquires(x)	__attribute__((context(0,1)))
-# define __releases(x)	__attribute__((context(1,0)))
-# define __acquire(x)	__context__(1)
-# define __release(x)	__context__(-1)
+# define __acquires(x)	__attribute__((context(x,0,1)))
+# define __releases(x)	__attribute__((context(x,1,0)))
+# define __acquire(x)	__context__(x,1)
+# define __release(x)	__context__(x,-1)
 # define __cond_lock(x,c)	((c) ? ({ __acquire(x); 1; }) : 0)
 extern void __chk_user_ptr(void __user *);
 extern void __chk_io_ptr(void __iomem *);
-- 
1.4.2.ga444



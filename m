Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbWCVQLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbWCVQLL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 11:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbWCVQLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 11:11:10 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:51585 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S1750835AbWCVQLJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 11:11:09 -0500
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [patch -mm] notifier chain initialization
From: Jes Sorensen <jes@sgi.com>
Date: 22 Mar 2006 11:11:07 -0500
Message-ID: <yq0y7z2tq78.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This one is against the -mm tree, description below.

Cheers,
Jes

This patch goes on top of Alan Stern's
notifier-chain-update-api-changes.patch

It restructures the notifier chain initialization macros by
introducing FOO_NOTIFIER_INIT() macros which are used by the
FOO_NOTIFIER_HEAD() macros.

The benefit is that one can use the FOO_NOTIFIER_INIT() macro for
static initialization of a notifier chain.

Signed-off-by: Jes Sorensen <jes@sgi.com>

---
 include/linux/notifier.h |   19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

Index: linux-2.6/include/linux/notifier.h
===================================================================
--- linux-2.6.orig/include/linux/notifier.h
+++ linux-2.6/include/linux/notifier.h
@@ -64,17 +64,24 @@
 		(name)->head = NULL;		\
 	} while (0)
 
-#define ATOMIC_NOTIFIER_HEAD(name)				\
-	struct atomic_notifier_head name = {			\
+#define ATOMIC_NOTIFIER_INIT(name) {				\
 		.mutex = __MUTEX_INITIALIZER((name).mutex),	\
 		.head = NULL }
-#define BLOCKING_NOTIFIER_HEAD(name)				\
-	struct blocking_notifier_head name = {			\
+#define BLOCKING_NOTIFIER_INIT(name) {				\
 		.rwsem = __RWSEM_INITIALIZER((name).rwsem),	\
 		.head = NULL }
+#define RAW_NOTIFIER_INIT(name) {				\
+		.head = NULL }
+
+#define ATOMIC_NOTIFIER_HEAD(name)				\
+	struct atomic_notifier_head name =			\
+		ATOMIC_NOTIFIER_INIT(name)
+#define BLOCKING_NOTIFIER_HEAD(name)				\
+	struct blocking_notifier_head name =			\
+		BLOCKING_NOTIFIER_INIT(name)
 #define RAW_NOTIFIER_HEAD(name)					\
-	struct raw_notifier_head name = {			\
-	.head = NULL }
+	struct raw_notifier_head name =				\
+		RAW_NOTIFIER_INIT(name)
 
 #ifdef __KERNEL__
 

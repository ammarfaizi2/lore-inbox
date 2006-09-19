Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751013AbWISF4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbWISF4f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 01:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbWISF4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 01:56:35 -0400
Received: from outbound0.mx.meer.net ([209.157.153.23]:50951 "EHLO
	outbound0.sv.meer.net") by vger.kernel.org with ESMTP
	id S1751013AbWISF4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 01:56:34 -0400
Subject: Re: [patch 2/8] fault-injection capabilities infrastructure
From: Don Mullis <dwm@meer.net>
To: Akinobu Mita <mita@miraclelinux.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, akpm@osdl.org, okuji@enbug.org
In-Reply-To: <20060914102030.721230898@localhost.localdomain>
References: <20060914102012.251231177@localhost.localdomain>
	 <20060914102030.721230898@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 18 Sep 2006 22:50:54 -0700
Message-Id: <1158645054.2419.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace individual structure element comments with reference
to Documentation/fault-injection/fault-injection.txt

Init "interval" to 1 (smallest useful value).
Init "times" to 1 rather than -1 (infinity), for fewer 
accidental system lockups.


Signed-off-by: Don Mullis <dwm@meer.net>

---
 include/linux/fault-inject.h |   20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

Index: linux-2.6.17/include/linux/fault-inject.h
===================================================================
--- linux-2.6.17.orig/include/linux/fault-inject.h
+++ linux-2.6.17/include/linux/fault-inject.h
@@ -6,31 +6,21 @@
 #include <linux/types.h>
 #include <asm/atomic.h>
 
+/*
+ * For explanation of the elements of this struct, see
+ * Documentation/fault-injection/fault-injection.txt
+ */
 struct fault_attr {
-
-	/* how often it should fail in percent. */
 	unsigned long probability;
-
-	/* the interval of failures. */
 	unsigned long interval;
-
-	/*
-	 * how many times failures may happen at most.
-	 * A value of '-1' means infinity.
-	 */
 	atomic_t times;
-
-	/*
-	 * the size of free space where memory can be allocated safely.
-	 * A value of '0' means infinity.
-	 */
 	atomic_t space;
 
 	unsigned long count;
 };
 
 #define DEFINE_FAULT_ATTR(name) \
-	struct fault_attr name = { .times = ATOMIC_INIT(-1), }
+	struct fault_attr name = { .interval=1, .times = ATOMIC_INIT(1), }
 
 int setup_fault_attr(struct fault_attr *attr, char *str);
 void should_fail_srandom(unsigned long entropy);



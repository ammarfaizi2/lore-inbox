Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316823AbSFDVaR>; Tue, 4 Jun 2002 17:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316828AbSFDVaP>; Tue, 4 Jun 2002 17:30:15 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:64758 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S316823AbSFDVaM>; Tue, 4 Jun 2002 17:30:12 -0400
Subject: [PATCH] remove fsuser()
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 04 Jun 2002 14:30:11 -0700
Message-Id: <1023226211.3904.148.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Apparently nothing uses fsuser() - else I would of just stuck this on
the end the last patch...

This patch removes fsuser().  Now both suser() and fsuser() are gone and
all permission checks use an appropriate capable() call.

Patch is against 2.5.20 + previous suser() removal patch.  Please apply.

	Robert Love

diff -urN linux-2.5.20-rml/include/linux/sched.h linux/include/linux/sched.h
--- linux-2.5.20-rml/include/linux/sched.h	Tue Jun  4 14:18:57 2002
+++ linux/include/linux/sched.h	Tue Jun  4 14:20:38 2002
@@ -585,24 +585,6 @@
 extern void free_irq(unsigned int, void *);
 
 /*
- * This has now become a routine instead of a macro, it sets a flag if
- * it returns true (to do BSD-style accounting where the process is flagged
- * if it uses root privs). The implication of this is that you should do
- * normal permissions checks first, and check fsuser() last.
- *
- * suser() is gone, fsuser() should go soon too...
- */
-
-static inline int fsuser(void)
-{
-	if (!issecure(SECURE_NOROOT) && current->fsuid == 0) {
-		current->flags |= PF_SUPERPRIV;
-		return 1;
-	}
-	return 0;
-}
-
-/*
  * capable() checks for a particular capability.
  * See include/linux/capability.h for defined capabilities.
  */




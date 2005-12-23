Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030529AbVLWOKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030529AbVLWOKY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 09:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030531AbVLWOKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 09:10:24 -0500
Received: from a34-mta02.direcpc.com ([66.82.4.91]:31918 "EHLO
	a34-mta02.direcway.com") by vger.kernel.org with ESMTP
	id S1030529AbVLWOKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 09:10:23 -0500
Date: Fri, 23 Dec 2005 09:10:03 -0500
From: Ben Collins <ben.collins@ubuntu.com>
Subject: [PATCH 2.6.15-git] Fix typo in x86_64 __build_write_lock_const	assembly
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Message-id: <1135347004.11626.2.camel@localhost.localdomain>
Organization: Ubuntu Linux
MIME-version: 1.0
X-Mailer: Evolution 2.5.3
Content-type: text/plain
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Based on __build_read_lock_const, this looked like a bug.

diff --git a/include/asm-x86_64/rwlock.h b/include/asm-x86_64/rwlock.h
index 8a78a4a..9942cc3 100644
--- a/include/asm-x86_64/rwlock.h
+++ b/include/asm-x86_64/rwlock.h
@@ -64,7 +64,7 @@
 		     ::"a" (rw) : "memory")
 
 #define __build_write_lock_const(rw, helper) \
-	asm volatile(LOCK "subl $" RW_LOCK_BIAS_STR ",(%0)\n\t" \
+	asm volatile(LOCK "subl $" RW_LOCK_BIAS_STR ",%0\n\t" \
 		     "jnz 2f\n" \
 		     "1:\n" \
 		    LOCK_SECTION_START("") \


-- 
   Ben Collins <ben.collins@ubuntu.com>
   Developer
   Ubuntu Linux


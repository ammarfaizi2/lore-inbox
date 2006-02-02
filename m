Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbWBBSBa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbWBBSBa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 13:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbWBBSB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 13:01:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:15050 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751145AbWBBSB3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 13:01:29 -0500
Subject: [PATCH] Style Fix in __constant_test_bit for S390, remove one set
	of ( )
From: Eric Paris <eparis@redhat.com>
To: schwidefsky@de.ibm.com, linux390@de.ibm.com, linux-390@vm.marist.edu,
       linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 02 Feb 2006 13:01:17 -0500
Message-Id: <1138903277.16707.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Right now in __constant_test_bit for the s390 there is an extra set of
() surrounding the calculation.  Putting it all on one line it could
read like

return (( ((volatile char *) addr) [(nr^(__BITOPS_WORDSIZE-8))>>3] & (1<<(nr&7)) )) != 0;

This patch simply removes one set of () that is surrounding the whole
clause.

Signed-off-by: Eric Paris <eparis@redhat.com>
---
 bitops.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.15.2/include/asm-s390/bitops.h.old
+++ linux-2.6.15.2/include/asm-s390/bitops.h
@@ -518,8 +518,8 @@ static inline int __test_bit(unsigned lo
 
 static inline int 
 __constant_test_bit(unsigned long nr, const volatile unsigned long *addr) {
-    return ((((volatile char *) addr)
-	    [(nr^(__BITOPS_WORDSIZE-8))>>3] & (1<<(nr&7)))) != 0;
+    return (((volatile char *) addr)
+	    [(nr^(__BITOPS_WORDSIZE-8))>>3] & (1<<(nr&7))) != 0;
 }
 
 #define test_bit(nr,addr) \



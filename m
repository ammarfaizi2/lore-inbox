Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751318AbWGRLwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbWGRLwi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 07:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWGRLwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 07:52:38 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:54800 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751318AbWGRLwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 07:52:37 -0400
Date: Tue, 18 Jul 2006 13:52:43 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [patch 1/6] s390: Fix gcc warning about unused return values.
Message-ID: <20060718115243.GA20884@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] Fix gcc warning about unused return values.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/asm-s390/system.h |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff -urpN linux-2.6/include/asm-s390/system.h linux-2.6-patched/include/asm-s390/system.h
--- linux-2.6/include/asm-s390/system.h	2006-07-18 13:40:33.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/system.h	2006-07-18 13:40:42.000000000 +0200
@@ -128,8 +128,13 @@ extern void account_system_vtime(struct 
 
 #define nop() __asm__ __volatile__ ("nop")
 
-#define xchg(ptr,x) \
-  ((__typeof__(*(ptr)))__xchg((unsigned long)(x),(void *)(ptr),sizeof(*(ptr))))
+#define xchg(ptr,x)							  \
+({									  \
+	__typeof__(*(ptr)) __ret;					  \
+	__ret = (__typeof__(*(ptr)))					  \
+		__xchg((unsigned long)(x), (void *)(ptr),sizeof(*(ptr))); \
+	__ret;								  \
+})
 
 static inline unsigned long __xchg(unsigned long x, void * ptr, int size)
 {

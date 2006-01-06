Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752448AbWAFQgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752448AbWAFQgq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 11:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752369AbWAFQgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 11:36:32 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34239 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752448AbWAFQaA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 11:30:00 -0500
Date: Fri, 6 Jan 2006 16:29:37 GMT
Message-Id: <200601061629.k06GTb5P011382@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, aviro@redhat.com
Cc: linux-kernel@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 11/17] FRV: Make get_user macro cast pointers
In-Reply-To: <dhowells1136564974@warthog.cambridge.redhat.com>
References: <dhowells1136564974@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch makes the get_user macro cast the source pointer to an
appropriate type for the specified size.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 frv-uaccess-2615.diff
 include/asm-frv/uaccess.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.15/include/asm-frv/uaccess.h linux-2.6.15-frv/include/asm-frv/uaccess.h
--- /warthog/kernels/linux-2.6.15/include/asm-frv/uaccess.h	2005-11-01 13:19:17.000000000 +0000
+++ linux-2.6.15-frv/include/asm-frv/uaccess.h	2006-01-06 14:43:43.000000000 +0000
@@ -180,16 +180,16 @@ do {						\
 									\
 	switch (sizeof(*(ptr))) {					\
 	case 1:								\
-		__get_user_asm(__gu_err, __gu_val, ptr, "ub", "=r");	\
+		__get_user_asm(__gu_err, *(u8*)&__gu_val, ptr, "ub", "=r"); \
 		break;							\
 	case 2:								\
-		__get_user_asm(__gu_err, __gu_val, ptr, "uh", "=r");	\
+		__get_user_asm(__gu_err, *(u16*)&__gu_val, ptr, "uh", "=r"); \
 		break;							\
 	case 4:								\
-		__get_user_asm(__gu_err, __gu_val, ptr, "", "=r");	\
+		__get_user_asm(__gu_err, *(u32*)&__gu_val, ptr, "", "=r"); \
 		break;							\
 	case 8:								\
-		__get_user_asm(__gu_err, __gu_val, ptr, "d", "=e");	\
+		__get_user_asm(__gu_err, *(u64*)&__gu_val, ptr, "d", "=e"); \
 		break;							\
 	default:							\
 		__gu_err = __get_user_bad();				\

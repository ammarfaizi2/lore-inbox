Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030684AbWJKQ2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030684AbWJKQ2A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 12:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030682AbWJKQ17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 12:27:59 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:49060 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030403AbWJKQ16
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 12:27:58 -0400
To: torvalds@osdl.org
Subject: [PATCH] m68k uaccess __user annotations
Cc: linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org
Message-Id: <E1GXgw1-0005f4-Ac@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 11 Oct 2006 17:27:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/asm-m68k/uaccess.h |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/asm-m68k/uaccess.h b/include/asm-m68k/uaccess.h
index 88b1f47..e4c9f08 100644
--- a/include/asm-m68k/uaccess.h
+++ b/include/asm-m68k/uaccess.h
@@ -76,7 +76,7 @@ ({									\
 		break;							\
 	case 8:								\
  	    {								\
- 		const void *__pu_ptr = (ptr);				\
+ 		const void __user *__pu_ptr = (ptr);			\
 		asm volatile ("\n"					\
 			"1:	moves.l	%2,(%1)+\n"			\
 			"2:	moves.l	%R2,(%1)\n"			\
@@ -125,7 +125,7 @@ #define __get_user_asm(res, x, ptr, type
 		"	.previous"				\
 		: "+d" (res), "=&" #reg (__gu_val)		\
 		: "m" (*(ptr)), "i" (err));			\
-	(x) = (typeof(*(ptr)))(long)__gu_val;			\
+	(x) = (typeof(*(ptr)))(unsigned long)__gu_val;		\
 })
 
 #define __get_user(x, ptr)						\
@@ -221,16 +221,16 @@ __constant_copy_from_user(void *to, cons
 
 	switch (n) {
 	case 1:
-		__get_user_asm(res, *(u8 *)to, (u8 *)from, u8, b, d, 1);
+		__get_user_asm(res, *(u8 *)to, (u8 __user *)from, u8, b, d, 1);
 		break;
 	case 2:
-		__get_user_asm(res, *(u16 *)to, (u16 *)from, u16, w, d, 2);
+		__get_user_asm(res, *(u16 *)to, (u16 __user *)from, u16, w, d, 2);
 		break;
 	case 3:
 		__constant_copy_from_user_asm(res, to, from, tmp, 3, w, b,);
 		break;
 	case 4:
-		__get_user_asm(res, *(u32 *)to, (u32 *)from, u32, l, r, 4);
+		__get_user_asm(res, *(u32 *)to, (u32 __user *)from, u32, l, r, 4);
 		break;
 	case 5:
 		__constant_copy_from_user_asm(res, to, from, tmp, 5, l, b,);
@@ -302,16 +302,16 @@ __constant_copy_to_user(void __user *to,
 
 	switch (n) {
 	case 1:
-		__put_user_asm(res, *(u8 *)from, (u8 *)to, b, d, 1);
+		__put_user_asm(res, *(u8 *)from, (u8 __user *)to, b, d, 1);
 		break;
 	case 2:
-		__put_user_asm(res, *(u16 *)from, (u16 *)to, w, d, 2);
+		__put_user_asm(res, *(u16 *)from, (u16 __user *)to, w, d, 2);
 		break;
 	case 3:
 		__constant_copy_to_user_asm(res, to, from, tmp, 3, w, b,);
 		break;
 	case 4:
-		__put_user_asm(res, *(u32 *)from, (u32 *)to, l, r, 4);
+		__put_user_asm(res, *(u32 *)from, (u32 __user *)to, l, r, 4);
 		break;
 	case 5:
 		__constant_copy_to_user_asm(res, to, from, tmp, 5, l, b,);
-- 
1.4.2.GIT



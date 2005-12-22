Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965078AbVLVEvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965078AbVLVEvI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 23:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965087AbVLVEvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 23:51:07 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:34768 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965081AbVLVEuz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 23:50:55 -0500
To: linux-m68k@vger.kernel.org
Subject: [PATCH 22/36] m68k: basic __user annotations
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EpIPm-0004sd-LP@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 22 Dec 2005 04:50:54 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1133512703 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 include/asm-m68k/uaccess.h |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

14c881493778a59f2642397704ab2f662fbcc3a9
diff --git a/include/asm-m68k/uaccess.h b/include/asm-m68k/uaccess.h
index f5cedf1..a653bf8 100644
--- a/include/asm-m68k/uaccess.h
+++ b/include/asm-m68k/uaccess.h
@@ -42,6 +42,7 @@ struct exception_table_entry
 ({							\
     int __pu_err;					\
     typeof(*(ptr)) __pu_val = (x);			\
+    __chk_user_ptr(ptr);				\
     switch (sizeof (*(ptr))) {				\
     case 1:						\
 	__put_user_asm(__pu_err, __pu_val, ptr, b);	\
@@ -91,6 +92,7 @@ __asm__ __volatile__					\
 ({								\
     int __gu_err;						\
     typeof(*(ptr)) __gu_val;					\
+    __chk_user_ptr(ptr);					\
     switch (sizeof(*(ptr))) {					\
     case 1:							\
 	__get_user_asm(__gu_err, __gu_val, ptr, b, "=d");	\
@@ -105,7 +107,7 @@ __asm__ __volatile__					\
         __gu_err = __constant_copy_from_user(&__gu_val, ptr, 8);  \
         break;                                                  \
     default:							\
-	__gu_val = 0;						\
+	__gu_val = (typeof(*(ptr)))0;				\
 	__gu_err = __get_user_bad();				\
 	break;							\
     }								\
@@ -134,7 +136,7 @@ __asm__ __volatile__				\
      : "m"(*(ptr)), "i" (-EFAULT), "0"(0))
 
 static inline unsigned long
-__generic_copy_from_user(void *to, const void *from, unsigned long n)
+__generic_copy_from_user(void *to, const void __user *from, unsigned long n)
 {
     unsigned long tmp;
     __asm__ __volatile__
@@ -189,7 +191,7 @@ __generic_copy_from_user(void *to, const
 }
 
 static inline unsigned long
-__generic_copy_to_user(void *to, const void *from, unsigned long n)
+__generic_copy_to_user(void __user *to, const void *from, unsigned long n)
 {
     unsigned long tmp;
     __asm__ __volatile__
@@ -264,7 +266,7 @@ __generic_copy_to_user(void *to, const v
 	 : "d0", "memory")
 
 static inline unsigned long
-__constant_copy_from_user(void *to, const void *from, unsigned long n)
+__constant_copy_from_user(void *to, const void __user *from, unsigned long n)
 {
     switch (n) {
     case 0:
@@ -520,7 +522,7 @@ __constant_copy_from_user(void *to, cons
 #define __copy_from_user_inatomic __copy_from_user
 
 static inline unsigned long
-__constant_copy_to_user(void *to, const void *from, unsigned long n)
+__constant_copy_to_user(void __user *to, const void *from, unsigned long n)
 {
     switch (n) {
     case 0:
@@ -766,7 +768,7 @@ __constant_copy_to_user(void *to, const 
  */
 
 static inline long
-strncpy_from_user(char *dst, const char *src, long count)
+strncpy_from_user(char *dst, const char __user *src, long count)
 {
     long res;
     if (count == 0) return count;
@@ -799,7 +801,7 @@ strncpy_from_user(char *dst, const char 
  *
  * Return 0 on exception, a value greater than N if too long
  */
-static inline long strnlen_user(const char *src, long n)
+static inline long strnlen_user(const char __user *src, long n)
 {
 	long res;
 
@@ -842,7 +844,7 @@ static inline long strnlen_user(const ch
  */
 
 static inline unsigned long
-clear_user(void *to, unsigned long n)
+clear_user(void __user *to, unsigned long n)
 {
     __asm__ __volatile__
 	("   tstl %1\n"
-- 
0.99.9.GIT


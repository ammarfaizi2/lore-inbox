Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752131AbWJZJEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131AbWJZJEl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 05:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752124AbWJZJEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 05:04:40 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:37533 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1422778AbWJZJEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 05:04:38 -0400
Date: Thu, 26 Oct 2006 11:04:36 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [S390] Add __must_check to uaccess functions.
Message-ID: <20061026090436.GI16270@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] Add __must_check to uaccess functions.

Follow other architectures and add __must_check to uaccess functions.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/asm-s390/uaccess.h |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff -urpN linux-2.6/include/asm-s390/uaccess.h linux-2.6-patched/include/asm-s390/uaccess.h
--- linux-2.6/include/asm-s390/uaccess.h	2006-10-26 10:43:51.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/uaccess.h	2006-10-26 10:44:10.000000000 +0200
@@ -201,7 +201,7 @@ extern int __get_user_bad(void) __attrib
  * Returns number of bytes that could not be copied.
  * On success, this will be zero.
  */
-static inline unsigned long
+static inline unsigned long __must_check
 __copy_to_user(void __user *to, const void *from, unsigned long n)
 {
 	if (__builtin_constant_p(n) && (n <= 256))
@@ -226,7 +226,7 @@ __copy_to_user(void __user *to, const vo
  * Returns number of bytes that could not be copied.
  * On success, this will be zero.
  */
-static inline unsigned long
+static inline unsigned long __must_check
 copy_to_user(void __user *to, const void *from, unsigned long n)
 {
 	might_sleep();
@@ -252,7 +252,7 @@ copy_to_user(void __user *to, const void
  * If some data could not be copied, this function will pad the copied
  * data to the requested size using zero bytes.
  */
-static inline unsigned long
+static inline unsigned long __must_check
 __copy_from_user(void *to, const void __user *from, unsigned long n)
 {
 	if (__builtin_constant_p(n) && (n <= 256))
@@ -277,7 +277,7 @@ __copy_from_user(void *to, const void __
  * If some data could not be copied, this function will pad the copied
  * data to the requested size using zero bytes.
  */
-static inline unsigned long
+static inline unsigned long __must_check
 copy_from_user(void *to, const void __user *from, unsigned long n)
 {
 	might_sleep();
@@ -288,13 +288,13 @@ copy_from_user(void *to, const void __us
 	return n;
 }
 
-static inline unsigned long
+static inline unsigned long __must_check
 __copy_in_user(void __user *to, const void __user *from, unsigned long n)
 {
 	return uaccess.copy_in_user(n, to, from);
 }
 
-static inline unsigned long
+static inline unsigned long __must_check
 copy_in_user(void __user *to, const void __user *from, unsigned long n)
 {
 	might_sleep();
@@ -306,7 +306,7 @@ copy_in_user(void __user *to, const void
 /*
  * Copy a null terminated string from userspace.
  */
-static inline long
+static inline long __must_check
 strncpy_from_user(char *dst, const char __user *src, long count)
 {
         long res = -EFAULT;
@@ -343,13 +343,13 @@ strnlen_user(const char __user * src, un
  * Zero Userspace
  */
 
-static inline unsigned long
+static inline unsigned long __must_check
 __clear_user(void __user *to, unsigned long n)
 {
 	return uaccess.clear_user(n, to);
 }
 
-static inline unsigned long
+static inline unsigned long __must_check
 clear_user(void __user *to, unsigned long n)
 {
 	might_sleep();

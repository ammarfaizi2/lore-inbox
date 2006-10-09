Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751641AbWJICr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641AbWJICr7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 22:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751646AbWJICr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 22:47:59 -0400
Received: from xenotime.net ([66.160.160.81]:28078 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751627AbWJICr6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 22:47:58 -0400
Date: Sun, 8 Oct 2006 19:46:17 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] uaccess.h: match kernel-doc and function names
Message-Id: <20061008194617.80f6e196.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Place kernel-doc function comment header immediately before the
function that is being documented.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 include/asm-i386/uaccess.h |   67 ++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 33 deletions(-)

--- linux-2619-rc1g3.orig/include/asm-i386/uaccess.h
+++ linux-2619-rc1g3/include/asm-i386/uaccess.h
@@ -404,20 +404,6 @@ unsigned long __must_check __copy_from_u
  * anything, so this is accurate.
  */
 
-/**
- * __copy_to_user: - Copy a block of data into user space, with less checking.
- * @to:   Destination address, in user space.
- * @from: Source address, in kernel space.
- * @n:    Number of bytes to copy.
- *
- * Context: User context only.  This function may sleep.
- *
- * Copy data from kernel space to user space.  Caller must check
- * the specified block with access_ok() before calling this function.
- *
- * Returns number of bytes that could not be copied.
- * On success, this will be zero.
- */
 static __always_inline unsigned long __must_check
 __copy_to_user_inatomic(void __user *to, const void *from, unsigned long n)
 {
@@ -439,35 +425,27 @@ __copy_to_user_inatomic(void __user *to,
 	return __copy_to_user_ll(to, from, n);
 }
 
-static __always_inline unsigned long __must_check
-__copy_to_user(void __user *to, const void *from, unsigned long n)
-{
-       might_sleep();
-       return __copy_to_user_inatomic(to, from, n);
-}
-
 /**
- * __copy_from_user: - Copy a block of data from user space, with less checking.
- * @to:   Destination address, in kernel space.
- * @from: Source address, in user space.
+ * __copy_to_user: - Copy a block of data into user space, with less checking.
+ * @to:   Destination address, in user space.
+ * @from: Source address, in kernel space.
  * @n:    Number of bytes to copy.
  *
  * Context: User context only.  This function may sleep.
  *
- * Copy data from user space to kernel space.  Caller must check
+ * Copy data from kernel space to user space.  Caller must check
  * the specified block with access_ok() before calling this function.
  *
  * Returns number of bytes that could not be copied.
  * On success, this will be zero.
- *
- * If some data could not be copied, this function will pad the copied
- * data to the requested size using zero bytes.
- *
- * An alternate version - __copy_from_user_inatomic() - may be called from
- * atomic context and will fail rather than sleep.  In this case the
- * uncopied bytes will *NOT* be padded with zeros.  See fs/filemap.h
- * for explanation of why this is needed.
  */
+static __always_inline unsigned long __must_check
+__copy_to_user(void __user *to, const void *from, unsigned long n)
+{
+       might_sleep();
+       return __copy_to_user_inatomic(to, from, n);
+}
+
 static __always_inline unsigned long
 __copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
 {
@@ -493,6 +471,29 @@ __copy_from_user_inatomic(void *to, cons
 	}
 	return __copy_from_user_ll_nozero(to, from, n);
 }
+
+/**
+ * __copy_from_user: - Copy a block of data from user space, with less checking.
+ * @to:   Destination address, in kernel space.
+ * @from: Source address, in user space.
+ * @n:    Number of bytes to copy.
+ *
+ * Context: User context only.  This function may sleep.
+ *
+ * Copy data from user space to kernel space.  Caller must check
+ * the specified block with access_ok() before calling this function.
+ *
+ * Returns number of bytes that could not be copied.
+ * On success, this will be zero.
+ *
+ * If some data could not be copied, this function will pad the copied
+ * data to the requested size using zero bytes.
+ *
+ * An alternate version - __copy_from_user_inatomic() - may be called from
+ * atomic context and will fail rather than sleep.  In this case the
+ * uncopied bytes will *NOT* be padded with zeros.  See fs/filemap.h
+ * for explanation of why this is needed.
+ */
 static __always_inline unsigned long
 __copy_from_user(void *to, const void __user *from, unsigned long n)
 {


---

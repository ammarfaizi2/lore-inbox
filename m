Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964840AbVLPXQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbVLPXQF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 18:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbVLPXOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 18:14:04 -0500
Received: from mx1.redhat.com ([66.187.233.31]:47068 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964836AbVLPXNf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 18:13:35 -0500
Date: Fri, 16 Dec 2005 23:13:08 GMT
Message-Id: <200512162313.jBGND8fm019635@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 7/12]: MUTEX: Rename DECLARE_MUTEX for include/asm-*/ dirs
In-Reply-To: <dhowells1134774786@warthog.cambridge.redhat.com>
References: <dhowells1134774786@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch renames DECLARE_MUTEX*() to DECLARE_SEM_MUTEX*() for the
include/asm-*/ directories.

Additionally, for the i386 arch it also implements sem_is_locked().

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 mutex-incasm-2615rc5-2.diff
 include/asm-alpha/semaphore.h     |    4 ++--
 include/asm-arm/semaphore.h       |    4 ++--
 include/asm-arm26/semaphore.h     |    4 ++--
 include/asm-cris/semaphore.h      |    4 ++--
 include/asm-frv/semaphore.h       |    4 ++--
 include/asm-h8300/semaphore.h     |    4 ++--
 include/asm-i386/semaphore.h      |    5 +++--
 include/asm-ia64/semaphore.h      |    4 ++--
 include/asm-m32r/semaphore.h      |    4 ++--
 include/asm-m68k/semaphore.h      |    4 ++--
 include/asm-m68knommu/semaphore.h |    4 ++--
 include/asm-mips/semaphore.h      |    4 ++--
 include/asm-parisc/semaphore.h    |    4 ++--
 include/asm-powerpc/semaphore.h   |    4 ++--
 include/asm-s390/semaphore.h      |    4 ++--
 include/asm-sh/semaphore.h        |    4 ++--
 include/asm-sh64/semaphore.h      |    4 ++--
 include/asm-sparc/semaphore.h     |    4 ++--
 include/asm-sparc64/semaphore.h   |    4 ++--
 include/asm-v850/semaphore.h      |    4 ++--
 include/asm-x86_64/semaphore.h    |    4 ++--
 include/asm-xtensa/semaphore.h    |    4 ++--
 22 files changed, 45 insertions(+), 44 deletions(-)

diff -uNrp linux-2.6.15-rc5/include/asm-alpha/semaphore.h linux-2.6.15-rc5-mutex/include/asm-alpha/semaphore.h
--- linux-2.6.15-rc5/include/asm-alpha/semaphore.h	2005-12-08 16:23:51.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/asm-alpha/semaphore.h	2005-12-15 17:14:56.000000000 +0000
@@ -29,8 +29,8 @@ struct semaphore {
 #define __DECLARE_SEMAPHORE_GENERIC(name,count)		\
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
-#define DECLARE_MUTEX(name)		__DECLARE_SEMAPHORE_GENERIC(name,1)
-#define DECLARE_MUTEX_LOCKED(name)	__DECLARE_SEMAPHORE_GENERIC(name,0)
+#define DECLARE_SEM_MUTEX(name)		__DECLARE_SEMAPHORE_GENERIC(name,1)
+#define DECLARE_SEM_MUTEX_LOCKED(name)	__DECLARE_SEMAPHORE_GENERIC(name,0)
 
 static inline void sema_init(struct semaphore *sem, int val)
 {
diff -uNrp linux-2.6.15-rc5/include/asm-arm/semaphore.h linux-2.6.15-rc5-mutex/include/asm-arm/semaphore.h
--- linux-2.6.15-rc5/include/asm-arm/semaphore.h	2005-12-08 16:23:51.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/asm-arm/semaphore.h	2005-12-15 17:14:56.000000000 +0000
@@ -27,8 +27,8 @@ struct semaphore {
 #define __DECLARE_SEMAPHORE_GENERIC(name,count)	\
 	struct semaphore name = __SEMAPHORE_INIT(name,count)
 
-#define DECLARE_MUTEX(name)		__DECLARE_SEMAPHORE_GENERIC(name,1)
-#define DECLARE_MUTEX_LOCKED(name)	__DECLARE_SEMAPHORE_GENERIC(name,0)
+#define DECLARE_SEM_MUTEX(name)		__DECLARE_SEMAPHORE_GENERIC(name,1)
+#define DECLARE_SEM_MUTEX_LOCKED(name)	__DECLARE_SEMAPHORE_GENERIC(name,0)
 
 static inline void sema_init(struct semaphore *sem, int val)
 {
diff -uNrp linux-2.6.15-rc5/include/asm-arm26/semaphore.h linux-2.6.15-rc5-mutex/include/asm-arm26/semaphore.h
--- linux-2.6.15-rc5/include/asm-arm26/semaphore.h	2005-12-08 16:23:51.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/asm-arm26/semaphore.h	2005-12-15 17:14:56.000000000 +0000
@@ -28,8 +28,8 @@ struct semaphore {
 #define __DECLARE_SEMAPHORE_GENERIC(name,count)	\
 	struct semaphore name = __SEMAPHORE_INIT(name,count)
 
-#define DECLARE_MUTEX(name)		__DECLARE_SEMAPHORE_GENERIC(name,1)
-#define DECLARE_MUTEX_LOCKED(name)	__DECLARE_SEMAPHORE_GENERIC(name,0)
+#define DECLARE_SEM_MUTEX(name)		__DECLARE_SEMAPHORE_GENERIC(name,1)
+#define DECLARE_SEM_MUTEX_LOCKED(name)	__DECLARE_SEMAPHORE_GENERIC(name,0)
 
 static inline void sema_init(struct semaphore *sem, int val)
 {
diff -uNrp linux-2.6.15-rc5/include/asm-cris/semaphore.h linux-2.6.15-rc5-mutex/include/asm-cris/semaphore.h
--- linux-2.6.15-rc5/include/asm-cris/semaphore.h	2005-12-08 16:23:51.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/asm-cris/semaphore.h	2005-12-15 17:14:56.000000000 +0000
@@ -34,8 +34,8 @@ struct semaphore {
 #define __DECLARE_SEMAPHORE_GENERIC(name,count) \
         struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
-#define DECLARE_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
-#define DECLARE_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
+#define DECLARE_SEM_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
+#define DECLARE_SEM_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
 
 static inline void sema_init(struct semaphore *sem, int val)
 {
diff -uNrp linux-2.6.15-rc5/include/asm-frv/semaphore.h linux-2.6.15-rc5-mutex/include/asm-frv/semaphore.h
--- linux-2.6.15-rc5/include/asm-frv/semaphore.h	2005-12-08 16:23:52.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/asm-frv/semaphore.h	2005-12-15 17:14:56.000000000 +0000
@@ -50,8 +50,8 @@ struct semaphore {
 #define __DECLARE_SEMAPHORE_GENERIC(name,count) \
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
-#define DECLARE_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
-#define DECLARE_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
+#define DECLARE_SEM_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
+#define DECLARE_SEM_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
 
 static inline void sema_init (struct semaphore *sem, int val)
 {
diff -uNrp linux-2.6.15-rc5/include/asm-h8300/semaphore.h linux-2.6.15-rc5-mutex/include/asm-h8300/semaphore.h
--- linux-2.6.15-rc5/include/asm-h8300/semaphore.h	2005-12-08 16:23:52.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/asm-h8300/semaphore.h	2005-12-15 17:14:56.000000000 +0000
@@ -38,8 +38,8 @@ struct semaphore {
 #define __DECLARE_SEMAPHORE_GENERIC(name,count) \
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
-#define DECLARE_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
-#define DECLARE_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
+#define DECLARE_SEM_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
+#define DECLARE_SEM_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
 
 static inline void sema_init (struct semaphore *sem, int val)
 {
diff -uNrp linux-2.6.15-rc5/include/asm-i386/semaphore.h linux-2.6.15-rc5-mutex/include/asm-i386/semaphore.h
--- linux-2.6.15-rc5/include/asm-i386/semaphore.h	2005-12-08 16:23:52.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/asm-i386/semaphore.h	2005-12-16 17:42:40.000000000 +0000
@@ -47,6 +47,7 @@ struct semaphore {
 	wait_queue_head_t wait;
 };
 
+#define sem_is_locked(s) (atomic_read(&(s)->count) <= 0)
 
 #define __SEMAPHORE_INITIALIZER(name, n)				\
 {									\
@@ -58,8 +59,8 @@ struct semaphore {
 #define __DECLARE_SEMAPHORE_GENERIC(name,count) \
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
-#define DECLARE_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
-#define DECLARE_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
+#define DECLARE_SEM_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
+#define DECLARE_SEM_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
 
 static inline void sema_init (struct semaphore *sem, int val)
 {
diff -uNrp linux-2.6.15-rc5/include/asm-ia64/semaphore.h linux-2.6.15-rc5-mutex/include/asm-ia64/semaphore.h
--- linux-2.6.15-rc5/include/asm-ia64/semaphore.h	2005-12-08 16:23:52.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/asm-ia64/semaphore.h	2005-12-15 17:14:56.000000000 +0000
@@ -27,8 +27,8 @@ struct semaphore {
 #define __DECLARE_SEMAPHORE_GENERIC(name,count)					\
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name, count)
 
-#define DECLARE_MUTEX(name)		__DECLARE_SEMAPHORE_GENERIC(name, 1)
-#define DECLARE_MUTEX_LOCKED(name)	__DECLARE_SEMAPHORE_GENERIC(name, 0)
+#define DECLARE_SEM_MUTEX(name)		__DECLARE_SEMAPHORE_GENERIC(name, 1)
+#define DECLARE_SEM_MUTEX_LOCKED(name)	__DECLARE_SEMAPHORE_GENERIC(name, 0)
 
 static inline void
 sema_init (struct semaphore *sem, int val)
diff -uNrp linux-2.6.15-rc5/include/asm-m32r/semaphore.h linux-2.6.15-rc5-mutex/include/asm-m32r/semaphore.h
--- linux-2.6.15-rc5/include/asm-m32r/semaphore.h	2005-12-08 16:23:52.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/asm-m32r/semaphore.h	2005-12-15 17:14:56.000000000 +0000
@@ -35,8 +35,8 @@ struct semaphore {
 #define __DECLARE_SEMAPHORE_GENERIC(name,count) \
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
-#define DECLARE_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
-#define DECLARE_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
+#define DECLARE_SEM_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
+#define DECLARE_SEM_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
 
 static inline void sema_init (struct semaphore *sem, int val)
 {
diff -uNrp linux-2.6.15-rc5/include/asm-m68k/semaphore.h linux-2.6.15-rc5-mutex/include/asm-m68k/semaphore.h
--- linux-2.6.15-rc5/include/asm-m68k/semaphore.h	2005-12-08 16:23:52.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/asm-m68k/semaphore.h	2005-12-15 17:14:56.000000000 +0000
@@ -39,8 +39,8 @@ struct semaphore {
 #define __DECLARE_SEMAPHORE_GENERIC(name,count) \
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
-#define DECLARE_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
-#define DECLARE_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
+#define DECLARE_SEM_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
+#define DECLARE_SEM_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
 
 static inline void sema_init(struct semaphore *sem, int val)
 {
diff -uNrp linux-2.6.15-rc5/include/asm-m68knommu/semaphore.h linux-2.6.15-rc5-mutex/include/asm-m68knommu/semaphore.h
--- linux-2.6.15-rc5/include/asm-m68knommu/semaphore.h	2005-12-08 16:23:52.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/asm-m68knommu/semaphore.h	2005-12-15 17:14:56.000000000 +0000
@@ -38,8 +38,8 @@ struct semaphore {
 #define __DECLARE_SEMAPHORE_GENERIC(name,count) \
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
-#define DECLARE_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
-#define DECLARE_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
+#define DECLARE_SEM_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
+#define DECLARE_SEM_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
 
 static inline void sema_init (struct semaphore *sem, int val)
 {
diff -uNrp linux-2.6.15-rc5/include/asm-mips/semaphore.h linux-2.6.15-rc5-mutex/include/asm-mips/semaphore.h
--- linux-2.6.15-rc5/include/asm-mips/semaphore.h	2005-12-08 16:23:52.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/asm-mips/semaphore.h	2005-12-15 17:14:56.000000000 +0000
@@ -48,8 +48,8 @@ struct semaphore {
 #define __DECLARE_SEMAPHORE_GENERIC(name, count) \
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
-#define DECLARE_MUTEX(name)		__DECLARE_SEMAPHORE_GENERIC(name, 1)
-#define DECLARE_MUTEX_LOCKED(name)	__DECLARE_SEMAPHORE_GENERIC(name, 0)
+#define DECLARE_SEM_MUTEX(name)		__DECLARE_SEMAPHORE_GENERIC(name, 1)
+#define DECLARE_SEM_MUTEX_LOCKED(name)	__DECLARE_SEMAPHORE_GENERIC(name, 0)
 
 static inline void sema_init (struct semaphore *sem, int val)
 {
diff -uNrp linux-2.6.15-rc5/include/asm-parisc/semaphore.h linux-2.6.15-rc5-mutex/include/asm-parisc/semaphore.h
--- linux-2.6.15-rc5/include/asm-parisc/semaphore.h	2005-12-08 16:23:52.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/asm-parisc/semaphore.h	2005-12-15 17:14:56.000000000 +0000
@@ -52,8 +52,8 @@ struct semaphore {
 #define __DECLARE_SEMAPHORE_GENERIC(name,count) \
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
-#define DECLARE_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
-#define DECLARE_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
+#define DECLARE_SEM_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
+#define DECLARE_SEM_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
 
 extern inline void sema_init (struct semaphore *sem, int val)
 {
diff -uNrp linux-2.6.15-rc5/include/asm-powerpc/semaphore.h linux-2.6.15-rc5-mutex/include/asm-powerpc/semaphore.h
--- linux-2.6.15-rc5/include/asm-powerpc/semaphore.h	2005-12-08 16:23:53.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/asm-powerpc/semaphore.h	2005-12-15 17:14:56.000000000 +0000
@@ -34,8 +34,8 @@ struct semaphore {
 #define __DECLARE_SEMAPHORE_GENERIC(name, count) \
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
-#define DECLARE_MUTEX(name)		__DECLARE_SEMAPHORE_GENERIC(name, 1)
-#define DECLARE_MUTEX_LOCKED(name)	__DECLARE_SEMAPHORE_GENERIC(name, 0)
+#define DECLARE_SEM_MUTEX(name)		__DECLARE_SEMAPHORE_GENERIC(name, 1)
+#define DECLARE_SEM_MUTEX_LOCKED(name)	__DECLARE_SEMAPHORE_GENERIC(name, 0)
 
 static inline void sema_init (struct semaphore *sem, int val)
 {
diff -uNrp linux-2.6.15-rc5/include/asm-s390/semaphore.h linux-2.6.15-rc5-mutex/include/asm-s390/semaphore.h
--- linux-2.6.15-rc5/include/asm-s390/semaphore.h	2005-12-08 16:23:54.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/asm-s390/semaphore.h	2005-12-15 17:14:56.000000000 +0000
@@ -32,8 +32,8 @@ struct semaphore {
 #define __DECLARE_SEMAPHORE_GENERIC(name,count) \
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
-#define DECLARE_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
-#define DECLARE_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
+#define DECLARE_SEM_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
+#define DECLARE_SEM_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
 
 static inline void sema_init (struct semaphore *sem, int val)
 {
diff -uNrp linux-2.6.15-rc5/include/asm-sh/semaphore.h linux-2.6.15-rc5-mutex/include/asm-sh/semaphore.h
--- linux-2.6.15-rc5/include/asm-sh/semaphore.h	2005-12-08 16:23:54.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/asm-sh/semaphore.h	2005-12-15 17:14:56.000000000 +0000
@@ -36,8 +36,8 @@ struct semaphore {
 #define __DECLARE_SEMAPHORE_GENERIC(name,count) \
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
-#define DECLARE_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
-#define DECLARE_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
+#define DECLARE_SEM_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
+#define DECLARE_SEM_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
 
 static inline void sema_init (struct semaphore *sem, int val)
 {
diff -uNrp linux-2.6.15-rc5/include/asm-sh64/semaphore.h linux-2.6.15-rc5-mutex/include/asm-sh64/semaphore.h
--- linux-2.6.15-rc5/include/asm-sh64/semaphore.h	2005-12-08 16:23:54.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/asm-sh64/semaphore.h	2005-12-15 17:14:56.000000000 +0000
@@ -43,8 +43,8 @@ struct semaphore {
 #define __DECLARE_SEMAPHORE_GENERIC(name,count) \
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
-#define DECLARE_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
-#define DECLARE_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
+#define DECLARE_SEM_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
+#define DECLARE_SEM_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
 
 static inline void sema_init (struct semaphore *sem, int val)
 {
diff -uNrp linux-2.6.15-rc5/include/asm-sparc/semaphore.h linux-2.6.15-rc5-mutex/include/asm-sparc/semaphore.h
--- linux-2.6.15-rc5/include/asm-sparc/semaphore.h	2005-12-08 16:23:54.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/asm-sparc/semaphore.h	2005-12-15 17:14:56.000000000 +0000
@@ -25,8 +25,8 @@ struct semaphore {
 #define __DECLARE_SEMAPHORE_GENERIC(name,count) \
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
-#define DECLARE_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
-#define DECLARE_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
+#define DECLARE_SEM_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
+#define DECLARE_SEM_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
 
 static inline void sema_init (struct semaphore *sem, int val)
 {
diff -uNrp linux-2.6.15-rc5/include/asm-sparc64/semaphore.h linux-2.6.15-rc5-mutex/include/asm-sparc64/semaphore.h
--- linux-2.6.15-rc5/include/asm-sparc64/semaphore.h	2005-12-08 16:23:54.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/asm-sparc64/semaphore.h	2005-12-15 17:14:56.000000000 +0000
@@ -25,8 +25,8 @@ struct semaphore {
 #define __DECLARE_SEMAPHORE_GENERIC(name, count) \
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
-#define DECLARE_MUTEX(name)		__DECLARE_SEMAPHORE_GENERIC(name, 1)
-#define DECLARE_MUTEX_LOCKED(name)	__DECLARE_SEMAPHORE_GENERIC(name, 0)
+#define DECLARE_SEM_MUTEX(name)		__DECLARE_SEMAPHORE_GENERIC(name, 1)
+#define DECLARE_SEM_MUTEX_LOCKED(name)	__DECLARE_SEMAPHORE_GENERIC(name, 0)
 
 static inline void sema_init (struct semaphore *sem, int val)
 {
diff -uNrp linux-2.6.15-rc5/include/asm-v850/semaphore.h linux-2.6.15-rc5-mutex/include/asm-v850/semaphore.h
--- linux-2.6.15-rc5/include/asm-v850/semaphore.h	2005-12-08 16:23:54.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/asm-v850/semaphore.h	2005-12-15 17:14:56.000000000 +0000
@@ -21,8 +21,8 @@ struct semaphore {
 #define __DECLARE_SEMAPHORE_GENERIC(name,count)	\
 	struct semaphore name = __SEMAPHORE_INITIALIZER (name,count)
 
-#define DECLARE_MUTEX(name)		__DECLARE_SEMAPHORE_GENERIC (name,1)
-#define DECLARE_MUTEX_LOCKED(name)	__DECLARE_SEMAPHORE_GENERIC (name,0)
+#define DECLARE_SEM_MUTEX(name)		__DECLARE_SEMAPHORE_GENERIC (name,1)
+#define DECLARE_SEM_MUTEX_LOCKED(name)	__DECLARE_SEMAPHORE_GENERIC (name,0)
 
 static inline void sema_init (struct semaphore *sem, int val)
 {
diff -uNrp linux-2.6.15-rc5/include/asm-x86_64/semaphore.h linux-2.6.15-rc5-mutex/include/asm-x86_64/semaphore.h
--- linux-2.6.15-rc5/include/asm-x86_64/semaphore.h	2005-12-08 16:23:54.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/asm-x86_64/semaphore.h	2005-12-15 17:14:56.000000000 +0000
@@ -59,8 +59,8 @@ struct semaphore {
 #define __DECLARE_SEMAPHORE_GENERIC(name,count) \
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
-#define DECLARE_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
-#define DECLARE_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
+#define DECLARE_SEM_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
+#define DECLARE_SEM_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
 
 static inline void sema_init (struct semaphore *sem, int val)
 {
diff -uNrp linux-2.6.15-rc5/include/asm-xtensa/semaphore.h linux-2.6.15-rc5-mutex/include/asm-xtensa/semaphore.h
--- linux-2.6.15-rc5/include/asm-xtensa/semaphore.h	2005-12-08 16:23:54.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/asm-xtensa/semaphore.h	2005-12-15 17:14:56.000000000 +0000
@@ -32,8 +32,8 @@ struct semaphore {
 #define __DECLARE_SEMAPHORE_GENERIC(name,count) 			\
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
-#define DECLARE_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
-#define DECLARE_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
+#define DECLARE_SEM_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
+#define DECLARE_SEM_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
 
 static inline void sema_init (struct semaphore *sem, int val)
 {

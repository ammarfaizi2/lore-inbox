Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131915AbQKWMIc>; Thu, 23 Nov 2000 07:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131991AbQKWMIX>; Thu, 23 Nov 2000 07:08:23 -0500
Received: from pop.gmx.net ([194.221.183.20]:2937 "HELO mail.gmx.net")
        by vger.kernel.org with SMTP id <S131915AbQKWMIK>;
        Thu, 23 Nov 2000 07:08:10 -0500
Content-Type: text/plain;
  charset="iso8859-1"
From: Helge Deller <deller@gmx.de>
To: torvalds@transmeta.com
Subject: [PATCH]: 2.4.0-test11: sched.h  
Date: Thu, 23 Nov 2000 12:37:32 +0100
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <00112312373201.00318@P100>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch against 2.4.0-test11 changes INIT_FILES, INIT_MM and 
INIT_SIGNALS to use named initializers. 

Please apply,
Thanks,

Helge

--- linux/include/linux/sched.h.org	Tue Nov 21 00:50:43 2000
+++ linux/include/linux/sched.h	Thu Nov 23 10:20:37 2000
@@ -174,18 +174,19 @@
 	struct file * fd_array[NR_OPEN_DEFAULT];
 };
 
-#define INIT_FILES { \
-	ATOMIC_INIT(1), \
-	RW_LOCK_UNLOCKED, \
-	NR_OPEN_DEFAULT, \
-	__FD_SETSIZE, \
-	0, \
-	&init_files.fd_array[0], \
-	&init_files.close_on_exec_init, \
-	&init_files.open_fds_init, \
-	{ { 0, } }, \
-	{ { 0, } }, \
-	{ NULL, } \
+#define INIT_FILES \
+{ 							\
+	count:		ATOMIC_INIT(1), 		\
+	file_lock:	RW_LOCK_UNLOCKED, 		\
+	max_fds:	NR_OPEN_DEFAULT, 		\
+	max_fdset:	__FD_SETSIZE, 			\
+	next_fd:	0, 				\
+	fd:		&init_files.fd_array[0], 	\
+	close_on_exec:	&init_files.close_on_exec_init, \
+	open_fds:	&init_files.open_fds_init, 	\
+	close_on_exec_init: { { 0, } }, 		\
+	open_fds_init:	{ { 0, } }, 			\
+	fd_array:	{ NULL, } 			\
 }
 
 /* Maximum number of active map areas.. This is a random (large) number */
@@ -220,18 +221,19 @@
 	void * segments;
 };
 
-#define INIT_MM(name) {					\
-		&init_mmap, NULL, NULL,			\
-		swapper_pg_dir, 			\
-		ATOMIC_INIT(2), ATOMIC_INIT(1), 1,	\
-		__MUTEX_INITIALIZER(name.mmap_sem),	\
-		SPIN_LOCK_UNLOCKED,			\
-		0,					\
-		0, 0, 0, 0,				\
-		0, 0, 0, 				\
-		0, 0, 0, 0,				\
-		0, 0, 0,				\
-		0, 0, 0, 0, NULL }
+#define INIT_MM(name) \
+{			 				\
+	mmap:		&init_mmap, 			\
+	mmap_avl:	NULL, 				\
+	mmap_cache:	NULL, 				\
+	pgd:		swapper_pg_dir, 		\
+	mm_users:	ATOMIC_INIT(2), 		\
+	mm_count:	ATOMIC_INIT(1), 		\
+	map_count:	1, 				\
+	mmap_sem:	__MUTEX_INITIALIZER(name.mmap_sem), \
+	page_table_lock: SPIN_LOCK_UNLOCKED, 		\
+	segments:	NULL 				\
+}
 
 struct signal_struct {
 	atomic_t		count;
@@ -240,10 +242,11 @@
 };
 
 
-#define INIT_SIGNALS { \
-		ATOMIC_INIT(1), \
-		{ {{0,}}, }, \
-		SPIN_LOCK_UNLOCKED }
+#define INIT_SIGNALS {	\
+	count:		ATOMIC_INIT(1), 		\
+	action:		{ {{0,}}, }, 			\
+	siglock:	SPIN_LOCK_UNLOCKED 		\
+}
 
 /*
  * Some day this will be a full-fledged user tracking system..
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

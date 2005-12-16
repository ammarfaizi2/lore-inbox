Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964897AbVLPXPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964897AbVLPXPM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 18:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbVLPXOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 18:14:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44252 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964829AbVLPXNd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 18:13:33 -0500
Date: Fri, 16 Dec 2005 23:13:08 GMT
Message-Id: <200512162313.jBGND8Xh019643@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 11/12]: MUTEX: Rename DECLARE_MUTEX for miscellaneous directories
In-Reply-To: <dhowells1134774786@warthog.cambridge.redhat.com>
References: <dhowells1134774786@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch renames DECLARE_MUTEX*() to DECLARE_SEM_MUTEX*() for the
remaining directories.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 mutex-misc-2615rc5-2.diff
 Documentation/DocBook/kernel-locking.tmpl |    4 ++--
 Documentation/kref.txt                    |    2 +-
 block/genhd.c                             |    2 +-
 lib/kernel_lock.c                         |    2 +-
 lib/reed_solomon/reed_solomon.c           |    2 +-
 mm/swapfile.c                             |    2 +-
 security/keys/process_keys.c              |    2 +-
 security/selinux/selinuxfs.c              |    2 +-
 security/selinux/ss/services.c            |    2 +-
 9 files changed, 10 insertions(+), 10 deletions(-)

diff -uNrp linux-2.6.15-rc5/Documentation/DocBook/kernel-locking.tmpl linux-2.6.15-rc5-mutex/Documentation/DocBook/kernel-locking.tmpl
--- linux-2.6.15-rc5/Documentation/DocBook/kernel-locking.tmpl	2005-06-22 13:51:22.000000000 +0100
+++ linux-2.6.15-rc5-mutex/Documentation/DocBook/kernel-locking.tmpl	2005-12-15 17:14:56.000000000 +0000
@@ -698,7 +698,7 @@ struct object
 };
 
 /* Protects the cache, cache_num, and the objects within it */
-static DECLARE_MUTEX(cache_lock);
+static DECLARE_SEM_MUTEX(cache_lock);
 static LIST_HEAD(cache);
 static unsigned int cache_num = 0;
 #define MAX_CACHE_SIZE 10
@@ -814,7 +814,7 @@ The change is shown below, in standard p
          int popularity;
  };
 
--static DECLARE_MUTEX(cache_lock);
+-static DECLARE_SEM_MUTEX(cache_lock);
 +static spinlock_t cache_lock = SPIN_LOCK_UNLOCKED;
  static LIST_HEAD(cache);
  static unsigned int cache_num = 0;
diff -uNrp linux-2.6.15-rc5/Documentation/kref.txt linux-2.6.15-rc5-mutex/Documentation/kref.txt
--- linux-2.6.15-rc5/Documentation/kref.txt	2005-06-22 13:51:23.000000000 +0100
+++ linux-2.6.15-rc5-mutex/Documentation/kref.txt	2005-12-15 17:14:56.000000000 +0000
@@ -144,7 +144,7 @@ and kref_get() it.  That violates rule 3
 holding a valid pointer.  You must add locks or semaphores.  For
 instance:
 
-static DECLARE_MUTEX(sem);
+static DECLARE_SEM_MUTEX(sem);
 static LIST_HEAD(q);
 struct my_data
 {
diff -uNrp linux-2.6.15-rc5/block/genhd.c linux-2.6.15-rc5-mutex/block/genhd.c
--- linux-2.6.15-rc5/block/genhd.c	2005-12-08 16:23:37.000000000 +0000
+++ linux-2.6.15-rc5-mutex/block/genhd.c	2005-12-15 17:14:57.000000000 +0000
@@ -20,7 +20,7 @@
 
 static struct subsystem block_subsys;
 
-static DECLARE_MUTEX(block_subsys_sem);
+static DECLARE_SEM_MUTEX(block_subsys_sem);
 
 /*
  * Can be deleted altogether. Later.
diff -uNrp linux-2.6.15-rc5/lib/kernel_lock.c linux-2.6.15-rc5-mutex/lib/kernel_lock.c
--- linux-2.6.15-rc5/lib/kernel_lock.c	2005-11-01 13:19:22.000000000 +0000
+++ linux-2.6.15-rc5-mutex/lib/kernel_lock.c	2005-12-15 17:14:57.000000000 +0000
@@ -24,7 +24,7 @@
  *
  * Don't use in new code.
  */
-static DECLARE_MUTEX(kernel_sem);
+static DECLARE_SEM_MUTEX(kernel_sem);
 
 /*
  * Re-acquire the kernel semaphore.
diff -uNrp linux-2.6.15-rc5/lib/reed_solomon/reed_solomon.c linux-2.6.15-rc5-mutex/lib/reed_solomon/reed_solomon.c
--- linux-2.6.15-rc5/lib/reed_solomon/reed_solomon.c	2005-12-08 16:23:56.000000000 +0000
+++ linux-2.6.15-rc5-mutex/lib/reed_solomon/reed_solomon.c	2005-12-15 17:14:57.000000000 +0000
@@ -49,7 +49,7 @@
 /* This list holds all currently allocated rs control structures */
 static LIST_HEAD (rslist);
 /* Protection for the list */
-static DECLARE_MUTEX(rslistlock);
+static DECLARE_SEM_MUTEX(rslistlock);
 
 /**
  * rs_init - Initialize a Reed-Solomon codec
diff -uNrp linux-2.6.15-rc5/mm/swapfile.c linux-2.6.15-rc5-mutex/mm/swapfile.c
--- linux-2.6.15-rc5/mm/swapfile.c	2005-12-08 16:23:56.000000000 +0000
+++ linux-2.6.15-rc5-mutex/mm/swapfile.c	2005-12-15 17:14:56.000000000 +0000
@@ -45,7 +45,7 @@ struct swap_list_t swap_list = {-1, -1};
 
 struct swap_info_struct swap_info[MAX_SWAPFILES];
 
-static DECLARE_MUTEX(swapon_sem);
+static DECLARE_SEM_MUTEX(swapon_sem);
 
 /*
  * We need this because the bdev->unplug_fn can sleep and we cannot
diff -uNrp linux-2.6.15-rc5/security/keys/process_keys.c linux-2.6.15-rc5-mutex/security/keys/process_keys.c
--- linux-2.6.15-rc5/security/keys/process_keys.c	2005-12-08 16:23:57.000000000 +0000
+++ linux-2.6.15-rc5-mutex/security/keys/process_keys.c	2005-12-15 17:14:56.000000000 +0000
@@ -20,7 +20,7 @@
 #include "internal.h"
 
 /* session keyring create vs join semaphore */
-static DECLARE_MUTEX(key_session_sem);
+static DECLARE_SEM_MUTEX(key_session_sem);
 
 /* the root user's tracking struct */
 struct key_user root_key_user = {
diff -uNrp linux-2.6.15-rc5/security/selinux/selinuxfs.c linux-2.6.15-rc5-mutex/security/selinux/selinuxfs.c
--- linux-2.6.15-rc5/security/selinux/selinuxfs.c	2005-12-08 16:23:57.000000000 +0000
+++ linux-2.6.15-rc5-mutex/security/selinux/selinuxfs.c	2005-12-15 17:14:56.000000000 +0000
@@ -44,7 +44,7 @@ static int __init checkreqprot_setup(cha
 __setup("checkreqprot=", checkreqprot_setup);
 
 
-static DECLARE_MUTEX(sel_sem);
+static DECLARE_SEM_MUTEX(sel_sem);
 
 /* global data for booleans */
 static struct dentry *bool_dir = NULL;
diff -uNrp linux-2.6.15-rc5/security/selinux/ss/services.c linux-2.6.15-rc5-mutex/security/selinux/ss/services.c
--- linux-2.6.15-rc5/security/selinux/ss/services.c	2005-12-08 16:23:57.000000000 +0000
+++ linux-2.6.15-rc5-mutex/security/selinux/ss/services.c	2005-12-15 17:14:56.000000000 +0000
@@ -48,7 +48,7 @@ static DEFINE_RWLOCK(policy_rwlock);
 #define POLICY_RDUNLOCK read_unlock(&policy_rwlock)
 #define POLICY_WRUNLOCK write_unlock_irq(&policy_rwlock)
 
-static DECLARE_MUTEX(load_sem);
+static DECLARE_SEM_MUTEX(load_sem);
 #define LOAD_LOCK down(&load_sem)
 #define LOAD_UNLOCK up(&load_sem)
 

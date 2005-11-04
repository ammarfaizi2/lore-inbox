Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbVKDMGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbVKDMGq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 07:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932730AbVKDMGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 07:06:46 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:31754 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932097AbVKDMGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 07:06:45 -0500
Date: Fri, 4 Nov 2005 13:06:40 +0100
From: Adrian Bunk <bunk@stusta.de>
To: teigland@redhat.com
Cc: linux-cluster@redhat.com, linux-kernel@vger.kernel.org
Subject: [-mm patch] drivers/dlm/: possible cleanups
Message-ID: <20051104120640.GB5587@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- every file should #include the headers containing the prototypes for
  it's global functions
- make needlessly global functions static
- #if 0 the following unused global functions:
  - device.c: dlm_device_free_devices
  - lock.c: dlm_remove_from_waiters
  - lockspace.c: dlm_find_lockspace_name

Please review which of these changes do make sense.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/dlm/ast.c          |    1 +
 drivers/dlm/device.c       |    7 ++++---
 drivers/dlm/dir.c          |    1 +
 drivers/dlm/lock.c         |    4 +++-
 drivers/dlm/lock.h         |    2 --
 drivers/dlm/lockspace.c    |    2 ++
 drivers/dlm/lockspace.h    |    1 -
 drivers/dlm/memory.c       |    1 +
 drivers/dlm/midcomms.c     |    1 +
 drivers/dlm/recover.c      |    1 +
 drivers/dlm/recoverd.c     |    1 +
 drivers/dlm/requestqueue.c |    1 +
 drivers/dlm/util.c         |    1 +
 13 files changed, 17 insertions(+), 7 deletions(-)

--- linux-2.6.14-rc5-mm1-full/drivers/dlm/ast.c.old	2005-11-04 11:21:45.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/dlm/ast.c	2005-11-04 11:21:57.000000000 +0100
@@ -13,6 +13,7 @@
 
 #include "dlm_internal.h"
 #include "lock.h"
+#include "ast.h"
 
 #define WAKE_ASTS  0
 
--- linux-2.6.14-rc5-mm1-full/drivers/dlm/dir.c.old	2005-11-04 11:22:15.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/dlm/dir.c	2005-11-04 11:22:26.000000000 +0100
@@ -21,6 +21,7 @@
 #include "recover.h"
 #include "util.h"
 #include "lock.h"
+#include "dir.h"
 
 
 static void put_free_de(struct dlm_ls *ls, struct dlm_direntry *de)
--- linux-2.6.14-rc5-mm1-full/drivers/dlm/memory.c.old	2005-11-04 11:22:45.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/dlm/memory.c	2005-11-04 11:22:58.000000000 +0100
@@ -13,6 +13,7 @@
 
 #include "dlm_internal.h"
 #include "config.h"
+#include "memory.h"
 
 static kmem_cache_t *lkb_cache;
 
--- linux-2.6.14-rc5-mm1-full/drivers/dlm/device.c.old	2005-11-04 11:25:18.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/dlm/device.c	2005-11-04 11:26:39.000000000 +0100
@@ -39,7 +39,6 @@
 #include <linux/dlm_device.h>
 
 #include "lvb_table.h"
-#include "device.h"
 
 static struct file_operations _dlm_fops;
 static const char *name_prefix="dlm";
@@ -1050,6 +1049,7 @@
 		return status;
 }
 
+#if 0
 /* Called when the cluster is shutdown uncleanly, all lockspaces
    have been summarily removed */
 void dlm_device_free_devices()
@@ -1069,6 +1069,7 @@
 	}
 	up(&user_ls_lock);
 }
+#endif  /*  0  */
 
 static struct file_operations _dlm_fops = {
       .open    = dlm_open,
@@ -1089,7 +1090,7 @@
 /*
  * Create control device
  */
-int __init dlm_device_init(void)
+static int __init dlm_device_init(void)
 {
 	int r;
 
@@ -1110,7 +1111,7 @@
 	return 0;
 }
 
-void __exit dlm_device_exit(void)
+static void __exit dlm_device_exit(void)
 {
 	misc_deregister(&ctl_device);
 }
--- linux-2.6.14-rc5-mm1-full/drivers/dlm/lock.h.old	2005-11-04 11:26:57.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/dlm/lock.h	2005-11-04 11:28:28.000000000 +0100
@@ -13,7 +13,6 @@
 #ifndef __LOCK_DOT_H__
 #define __LOCK_DOT_H__
 
-void dlm_print_lkb(struct dlm_lkb *lkb);
 void dlm_print_rsb(struct dlm_rsb *r);
 int dlm_receive_message(struct dlm_header *hd, int nodeid, int recovery);
 int dlm_modes_compat(int mode1, int mode2);
@@ -22,7 +21,6 @@
 void dlm_put_rsb(struct dlm_rsb *r);
 void dlm_hold_rsb(struct dlm_rsb *r);
 int dlm_put_lkb(struct dlm_lkb *lkb);
-int dlm_remove_from_waiters(struct dlm_lkb *lkb);
 void dlm_scan_rsbs(struct dlm_ls *ls);
 
 int dlm_purge_locks(struct dlm_ls *ls);
--- linux-2.6.14-rc5-mm1-full/drivers/dlm/lock.c.old	2005-11-04 11:27:20.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/dlm/lock.c	2005-11-04 11:28:42.000000000 +0100
@@ -152,7 +152,7 @@
         {0, 0, 0, 0, 0, 0, 0, 0}        /* PD */
 };
 
-void dlm_print_lkb(struct dlm_lkb *lkb)
+static void dlm_print_lkb(struct dlm_lkb *lkb)
 {
 	printk(KERN_ERR "lkb: nodeid %d id %x remid %x exflags %x flags %x\n"
 	       "     status %d rqmode %d grmode %d wait_type %d ast_type %d\n",
@@ -751,10 +751,12 @@
 	return error;
 }
 
+#if 0
 int dlm_remove_from_waiters(struct dlm_lkb *lkb)
 {
 	return remove_from_waiters(lkb);
 }
+#endif  /*  0  */
 
 static void dir_remove(struct dlm_rsb *r)
 {
--- linux-2.6.14-rc5-mm1-full/drivers/dlm/lockspace.h.old	2005-11-04 11:28:59.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/dlm/lockspace.h	2005-11-04 11:29:06.000000000 +0100
@@ -18,7 +18,6 @@
 void dlm_lockspace_exit(void);
 struct dlm_ls *dlm_find_lockspace_global(uint32_t id);
 struct dlm_ls *dlm_find_lockspace_local(void *id);
-struct dlm_ls *dlm_find_lockspace_name(char *name, int namelen);
 void dlm_put_lockspace(struct dlm_ls *ls);
 
 #endif				/* __LOCKSPACE_DOT_H__ */
--- linux-2.6.14-rc5-mm1-full/drivers/dlm/lockspace.c.old	2005-11-04 11:29:17.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/dlm/lockspace.c	2005-11-04 11:43:53.000000000 +0100
@@ -239,10 +239,12 @@
 	return ls;
 }
 
+#if 0
 struct dlm_ls *dlm_find_lockspace_name(char *name, int namelen)
 {
 	return find_lockspace_name(name, namelen);
 }
+#endif  /*  0  */
 
 struct dlm_ls *dlm_find_lockspace_global(uint32_t id)
 {
--- linux-2.6.14-rc5-mm1-full/drivers/dlm/midcomms.c.old	2005-11-04 11:30:11.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/dlm/midcomms.c	2005-11-04 11:30:29.000000000 +0100
@@ -29,6 +29,7 @@
 #include "config.h"
 #include "rcom.h"
 #include "lock.h"
+#include "midcomms.h"
 
 
 static void copy_from_cb(void *dst, const void *base, unsigned offset,
--- linux-2.6.14-rc5-mm1-full/drivers/dlm/recover.c.old	2005-11-04 11:30:58.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/dlm/recover.c	2005-11-04 11:31:11.000000000 +0100
@@ -21,6 +21,7 @@
 #include "lock.h"
 #include "lowcomms.h"
 #include "member.h"
+#include "recover.h"
 
 
 /*
--- linux-2.6.14-rc5-mm1-full/drivers/dlm/recoverd.c.old	2005-11-04 11:31:28.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/dlm/recoverd.c	2005-11-04 11:31:42.000000000 +0100
@@ -20,6 +20,7 @@
 #include "lowcomms.h"
 #include "lock.h"
 #include "requestqueue.h"
+#include "recoverd.h"
 
 
 /* If the start for which we're re-enabling locking (seq) has been superseded
--- linux-2.6.14-rc5-mm1-full/drivers/dlm/requestqueue.c.old	2005-11-04 11:32:04.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/dlm/requestqueue.c	2005-11-04 11:32:15.000000000 +0100
@@ -15,6 +15,7 @@
 #include "lock.h"
 #include "dir.h"
 #include "config.h"
+#include "requestqueue.h"
 
 struct rq_entry {
 	struct list_head list;
--- linux-2.6.14-rc5-mm1-full/drivers/dlm/util.c.old	2005-11-04 11:32:32.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/dlm/util.c	2005-11-04 11:32:40.000000000 +0100
@@ -12,6 +12,7 @@
 
 #include "dlm_internal.h"
 #include "rcom.h"
+#include "util.h"
 
 static void header_out(struct dlm_header *hd)
 {


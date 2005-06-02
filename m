Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261323AbVFBUYB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbVFBUYB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 16:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbVFBUXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 16:23:40 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:9736 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261328AbVFBURu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 16:17:50 -0400
Date: Thu, 2 Jun 2005 22:17:43 +0200
From: Adrian Bunk <bunk@stusta.de>
To: David Teigland <teigland@redhat.com>,
       Patrick Caulfield <pcaulfie@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] drivers/dlm/: make code static
Message-ID: <20050602201743.GH4992@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/dlm/lock.c      |   10 +++++-----
 drivers/dlm/lockspace.c |    6 +++---
 drivers/dlm/main.c      |    4 ++--
 drivers/dlm/member.c    |    6 +++---
 drivers/dlm/recover.c   |    2 +-
 drivers/dlm/recoverd.c  |    2 +-
 6 files changed, 15 insertions(+), 15 deletions(-)

--- linux-2.6.12-rc5-mm2-full/drivers/dlm/lock.c.old	2005-06-02 22:09:02.000000000 +0200
+++ linux-2.6.12-rc5-mm2-full/drivers/dlm/lock.c	2005-06-02 22:10:22.000000000 +0200
@@ -94,7 +94,7 @@
  * Usage: matrix[grmode+1][rqmode+1]  (although m[rq+1][gr+1] is the same)
  */
 
-const int __dlm_compat_matrix[8][8] = {
+static const int __dlm_compat_matrix[8][8] = {
       /* UN NL CR CW PR PW EX PD */
         {1, 1, 1, 1, 1, 1, 1, 0},       /* UN */
         {1, 1, 1, 1, 1, 1, 1, 0},       /* NL */
@@ -141,7 +141,7 @@
  * Usage: matrix[grmode+1][rqmode+1]
  */
 
-const int __quecvt_compat_matrix[8][8] = {
+static const int __quecvt_compat_matrix[8][8] = {
       /* UN NL CR CW PR PW EX PD */
         {0, 0, 0, 0, 0, 0, 0, 0},       /* UN */
         {0, 0, 1, 1, 1, 1, 1, 0},       /* NL */
@@ -1632,8 +1632,8 @@
 	return 0;
 }
 
-int validate_lock_args(struct dlm_ls *ls, struct dlm_lkb *lkb,
-		       struct dlm_args *args)
+static int validate_lock_args(struct dlm_ls *ls, struct dlm_lkb *lkb,
+			      struct dlm_args *args)
 {
 	int rv = -EINVAL;
 
@@ -1687,7 +1687,7 @@
 	return rv;
 }
 
-int validate_unlock_args(struct dlm_lkb *lkb, struct dlm_args *args)
+static int validate_unlock_args(struct dlm_lkb *lkb, struct dlm_args *args)
 {
 	int rv = -EINVAL;
 
--- linux-2.6.12-rc5-mm2-full/drivers/dlm/lockspace.c.old	2005-06-02 22:10:40.000000000 +0200
+++ linux-2.6.12-rc5-mm2-full/drivers/dlm/lockspace.c	2005-06-02 22:10:54.000000000 +0200
@@ -39,7 +39,7 @@
 	return 0;
 }
 
-int dlm_scand(void *data)
+static int dlm_scand(void *data)
 {
 	struct dlm_ls *ls;
 
@@ -52,7 +52,7 @@
 	return 0;
 }
 
-int dlm_scand_start(void)
+static int dlm_scand_start(void)
 {
 	struct task_struct *p;
 	int error = 0;
@@ -65,7 +65,7 @@
 	return error;
 }
 
-void dlm_scand_stop(void)
+static void dlm_scand_stop(void)
 {
 	kthread_stop(scand_task);
 }
--- linux-2.6.12-rc5-mm2-full/drivers/dlm/main.c.old	2005-06-02 22:11:11.000000000 +0200
+++ linux-2.6.12-rc5-mm2-full/drivers/dlm/main.c	2005-06-02 22:11:36.000000000 +0200
@@ -36,7 +36,7 @@
 int dlm_node_ioctl_init(void);
 void dlm_node_ioctl_exit(void);
 
-int __init init_dlm(void)
+static int __init init_dlm(void)
 {
 	int error;
 
@@ -80,7 +80,7 @@
 	return error;
 }
 
-void __exit exit_dlm(void)
+static void __exit exit_dlm(void)
 {
 	dlm_lowcomms_exit();
 	dlm_member_sysfs_exit();
--- linux-2.6.12-rc5-mm2-full/drivers/dlm/member.c.old	2005-06-02 22:11:53.000000000 +0200
+++ linux-2.6.12-rc5-mm2-full/drivers/dlm/member.c	2005-06-02 22:12:20.000000000 +0200
@@ -47,7 +47,7 @@
 	}
 }
 
-int dlm_add_member(struct dlm_ls *ls, int nodeid)
+static int dlm_add_member(struct dlm_ls *ls, int nodeid)
 {
 	struct dlm_member *memb;
 
@@ -61,13 +61,13 @@
 	return 0;
 }
 
-void dlm_remove_member(struct dlm_ls *ls, struct dlm_member *memb)
+static void dlm_remove_member(struct dlm_ls *ls, struct dlm_member *memb)
 {
 	list_move(&memb->list, &ls->ls_nodes_gone);
 	ls->ls_num_nodes--;
 }
 
-int dlm_is_member(struct dlm_ls *ls, int nodeid)
+static int dlm_is_member(struct dlm_ls *ls, int nodeid)
 {
 	struct dlm_member *memb;
 
--- linux-2.6.12-rc5-mm2-full/drivers/dlm/recover.c.old	2005-06-02 22:12:34.000000000 +0200
+++ linux-2.6.12-rc5-mm2-full/drivers/dlm/recover.c	2005-06-02 22:13:18.000000000 +0200
@@ -237,7 +237,7 @@
 	return r;
 }
 
-void recover_list_clear(struct dlm_ls *ls)
+static void recover_list_clear(struct dlm_ls *ls)
 {
 	struct dlm_rsb *r, *s;
 
--- linux-2.6.12-rc5-mm2-full/drivers/dlm/recoverd.c.old	2005-06-02 22:13:28.000000000 +0200
+++ linux-2.6.12-rc5-mm2-full/drivers/dlm/recoverd.c	2005-06-02 22:13:36.000000000 +0200
@@ -658,7 +658,7 @@
 	}
 }
 
-int dlm_recoverd(void *arg)
+static int dlm_recoverd(void *arg)
 {
 	struct dlm_ls *ls;
 


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263291AbVGOKeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263291AbVGOKeP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 06:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263274AbVGOKb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 06:31:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33682 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263275AbVGOKbD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 06:31:03 -0400
Date: Fri, 15 Jul 2005 18:35:56 +0800
From: David Teigland <teigland@redhat.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch 03/12] dlm: make code static
Message-ID: <20050715103556.GF17316@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="add-static.patch"
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: David Teigland <teigland@redhat.com>

Index: linux-2.6.12-mm1/drivers/dlm/lock.c
===================================================================
--- linux-2.6.12-mm1.orig/drivers/dlm/lock.c
+++ linux-2.6.12-mm1/drivers/dlm/lock.c
@@ -92,7 +92,7 @@ static int receive_extralen(struct dlm_m
  * Usage: matrix[grmode+1][rqmode+1]  (although m[rq+1][gr+1] is the same)
  */
 
-const int __dlm_compat_matrix[8][8] = {
+static const int __dlm_compat_matrix[8][8] = {
       /* UN NL CR CW PR PW EX PD */
         {1, 1, 1, 1, 1, 1, 1, 0},       /* UN */
         {1, 1, 1, 1, 1, 1, 1, 0},       /* NL */
@@ -139,7 +139,7 @@ int dlm_modes_compat(int mode1, int mode
  * Usage: matrix[grmode+1][rqmode+1]
  */
 
-const int __quecvt_compat_matrix[8][8] = {
+static const int __quecvt_compat_matrix[8][8] = {
       /* UN NL CR CW PR PW EX PD */
         {0, 0, 0, 0, 0, 0, 0, 0},       /* UN */
         {0, 0, 1, 1, 1, 1, 1, 0},       /* NL */
@@ -1630,8 +1630,8 @@ static int set_unlock_args(uint32_t flag
 	return 0;
 }
 
-int validate_lock_args(struct dlm_ls *ls, struct dlm_lkb *lkb,
-		       struct dlm_args *args)
+static int validate_lock_args(struct dlm_ls *ls, struct dlm_lkb *lkb,
+			      struct dlm_args *args)
 {
 	int rv = -EINVAL;
 
@@ -1685,7 +1685,7 @@ int validate_lock_args(struct dlm_ls *ls
 	return rv;
 }
 
-int validate_unlock_args(struct dlm_lkb *lkb, struct dlm_args *args)
+static int validate_unlock_args(struct dlm_lkb *lkb, struct dlm_args *args)
 {
 	int rv = -EINVAL;
 
Index: linux-2.6.12-mm1/drivers/dlm/lockspace.c
===================================================================
--- linux-2.6.12-mm1.orig/drivers/dlm/lockspace.c
+++ linux-2.6.12-mm1/drivers/dlm/lockspace.c
@@ -47,7 +47,7 @@ int dlm_lockspace_init(void)
 	return 0;
 }
 
-int dlm_scand(void *data)
+static int dlm_scand(void *data)
 {
 	struct dlm_ls *ls;
 
@@ -60,7 +60,7 @@ int dlm_scand(void *data)
 	return 0;
 }
 
-int dlm_scand_start(void)
+static int dlm_scand_start(void)
 {
 	struct task_struct *p;
 	int error = 0;
@@ -73,7 +73,7 @@ int dlm_scand_start(void)
 	return error;
 }
 
-void dlm_scand_stop(void)
+static void dlm_scand_stop(void)
 {
 	kthread_stop(scand_task);
 }
Index: linux-2.6.12-mm1/drivers/dlm/main.c
===================================================================
--- linux-2.6.12-mm1.orig/drivers/dlm/main.c
+++ linux-2.6.12-mm1/drivers/dlm/main.c
@@ -30,7 +30,7 @@ static inline void dlm_unregister_debugf
 int dlm_node_ioctl_init(void);
 void dlm_node_ioctl_exit(void);
 
-int __init init_dlm(void)
+static int __init init_dlm(void)
 {
 	int error;
 
@@ -74,7 +74,7 @@ int __init init_dlm(void)
 	return error;
 }
 
-void __exit exit_dlm(void)
+static void __exit exit_dlm(void)
 {
 	dlm_lowcomms_exit();
 	dlm_member_sysfs_exit();
Index: linux-2.6.12-mm1/drivers/dlm/member.c
===================================================================
--- linux-2.6.12-mm1.orig/drivers/dlm/member.c
+++ linux-2.6.12-mm1/drivers/dlm/member.c
@@ -47,7 +47,7 @@ static void add_ordered_member(struct dl
 	}
 }
 
-int dlm_add_member(struct dlm_ls *ls, int nodeid)
+static int dlm_add_member(struct dlm_ls *ls, int nodeid)
 {
 	struct dlm_member *memb;
 
@@ -61,13 +61,13 @@ int dlm_add_member(struct dlm_ls *ls, in
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
 
Index: linux-2.6.12-mm1/drivers/dlm/recover.c
===================================================================
--- linux-2.6.12-mm1.orig/drivers/dlm/recover.c
+++ linux-2.6.12-mm1/drivers/dlm/recover.c
@@ -235,7 +235,7 @@ static struct dlm_rsb *recover_list_find
 	return r;
 }
 
-void recover_list_clear(struct dlm_ls *ls)
+static void recover_list_clear(struct dlm_ls *ls)
 {
 	struct dlm_rsb *r, *s;
 
Index: linux-2.6.12-mm1/drivers/dlm/recoverd.c
===================================================================
--- linux-2.6.12-mm1.orig/drivers/dlm/recoverd.c
+++ linux-2.6.12-mm1/drivers/dlm/recoverd.c
@@ -658,7 +658,7 @@ static void do_ls_recovery(struct dlm_ls
 	}
 }
 
-int dlm_recoverd(void *arg)
+static int dlm_recoverd(void *arg)
 {
 	struct dlm_ls *ls;
 

--

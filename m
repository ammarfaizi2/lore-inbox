Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263031AbVF3UCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263031AbVF3UCG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 16:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263032AbVF3UAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 16:00:36 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:11914 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263031AbVF3Tqs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 15:46:48 -0400
Date: Thu, 30 Jun 2005 14:52:29 -0500
From: serue@us.ibm.com
To: lkml <linux-kernel@vger.kernel.org>
Cc: Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Michael Halcrow <mhalcrow@us.ibm.com>,
       David Safford <safford@watson.ibm.com>,
       Reiner Sailer <sailer@us.ibm.com>, Gerrit Huizenga <gerrit@us.ibm.com>
Subject: [patch 7/12] lsm stacking v0.2: selinux: update security structs
Message-ID: <20050630195229.GG23538@serge.austin.ibm.com>
References: <20050630194458.GA23439@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050630194458.GA23439@serge.austin.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the struct security_list lsm_list; to each structure which SELinux will be
appending to a kernel object.

Signed-off-by: Serge Hallyn <serue@us.ibm.com>
---
 objsec.h |   19 +++++++++++--------
 1 files changed, 11 insertions(+), 8 deletions(-)

Index: linux-2.6.13-rc1/security/selinux/include/objsec.h
===================================================================
--- linux-2.6.13-rc1.orig/security/selinux/include/objsec.h	2005-06-30 15:32:49.000000000 -0500
+++ linux-2.6.13-rc1/security/selinux/include/objsec.h	2005-06-30 15:33:47.000000000 -0500
@@ -23,11 +23,14 @@
 #include <linux/fs.h>
 #include <linux/binfmts.h>
 #include <linux/in.h>
+#include <linux/security.h>
 #include "flask.h"
 #include "avc.h"
 
+#define SELINUX_LSM_ID 0xB65
+
 struct task_security_struct {
-        unsigned long magic;           /* magic number for this module */
+	struct security_list lsm_list; /* chained security objects */
 	struct task_struct *task;      /* back pointer to task object */
 	u32 osid;            /* SID prior to last execve */
 	u32 sid;             /* current SID */
@@ -37,7 +40,7 @@ struct task_security_struct {
 };
 
 struct inode_security_struct {
-	unsigned long magic;           /* magic number for this module */
+	struct security_list lsm_list; /* chained security objects */
         struct inode *inode;           /* back pointer to inode object */
 	struct list_head list;         /* list of inode_security_struct */
 	u32 task_sid;        /* SID of creating task */
@@ -49,14 +52,14 @@ struct inode_security_struct {
 };
 
 struct file_security_struct {
-	unsigned long magic;            /* magic number for this module */
+	struct security_list lsm_list; /* chained security objects */
 	struct file *file;              /* back pointer to file object */
 	u32 sid;              /* SID of open file description */
 	u32 fown_sid;         /* SID of file owner (for SIGIO) */
 };
 
 struct superblock_security_struct {
-	unsigned long magic;            /* magic number for this module */
+	struct security_list lsm_list; /* chained security objects */
 	struct super_block *sb;         /* back pointer to sb object */
 	struct list_head list;          /* list of superblock_security_struct */
 	u32 sid;              /* SID of file system */
@@ -70,20 +73,20 @@ struct superblock_security_struct {
 };
 
 struct msg_security_struct {
-        unsigned long magic;		/* magic number for this module */
+ 	struct security_list lsm_list; /* chained security objects */
 	struct msg_msg *msg;		/* back pointer */
 	u32 sid;              /* SID of message */
 };
 
 struct ipc_security_struct {
-        unsigned long magic;		/* magic number for this module */
+ 	struct security_list lsm_list; /* chained security objects */
 	struct kern_ipc_perm *ipc_perm; /* back pointer */
 	u16 sclass;	/* security class of this object */
 	u32 sid;              /* SID of IPC resource */
 };
 
 struct bprm_security_struct {
-	unsigned long magic;           /* magic number for this module */
+	struct security_list lsm_list; /* chained security objects */
 	struct linux_binprm *bprm;     /* back pointer to bprm object */
 	u32 sid;                       /* SID for transformed process */
 	unsigned char set;
@@ -102,7 +105,7 @@ struct netif_security_struct {
 };
 
 struct sk_security_struct {
-	unsigned long magic;		/* magic number for this module */
+	struct security_list lsm_list; /* chained security objects */
 	struct sock *sk;		/* back pointer to sk object */
 	u32 peer_sid;			/* SID of peer */
 };

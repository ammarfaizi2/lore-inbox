Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbVLQVaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbVLQVaz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 16:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932657AbVLQVaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 16:30:55 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:36877 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932125AbVLQVay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 16:30:54 -0500
Date: Sat, 17 Dec 2005 22:30:56 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Joel Becker <joel.becker@oracle.com>, Mark Fasheh <mark.fasheh@oracle.com>,
       Kurt Hackel <kurt.hackel@oracle.com>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] fs/ocfs2/: small cleanups
Message-ID: <20051217213056.GS23349@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- cluster/sys.c: make needlessly global code static
- dlm/: "extern" declarations for variables belong into header files
        (and in this case, they are already in dlmdomain.h)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

BTW: Could you add a MAINTAINERS entry for ocfs2?

 fs/ocfs2/cluster/sys.c   |    4 ++--
 fs/ocfs2/dlm/dlmmaster.c |    4 +---
 fs/ocfs2/dlm/dlmthread.c |    3 ---
 3 files changed, 3 insertions(+), 8 deletions(-)

--- linux-2.6.15-rc5-mm3-full/fs/ocfs2/cluster/sys.c.old	2005-12-17 20:07:58.000000000 +0100
+++ linux-2.6.15-rc5-mm3-full/fs/ocfs2/cluster/sys.c	2005-12-17 20:09:46.000000000 +0100
@@ -50,7 +50,7 @@
 	return snprintf(buf, PAGE_SIZE, "%u\n", O2NM_API_VERSION);
 }
 
-O2CB_ATTR(interface_revision, S_IFREG | S_IRUGO, o2cb_interface_revision_show, NULL);
+static O2CB_ATTR(interface_revision, S_IFREG | S_IRUGO, o2cb_interface_revision_show, NULL);
 
 static struct attribute *o2cb_attrs[] = {
 	&o2cb_attr_interface_revision.attr,
@@ -73,7 +73,7 @@
 };
 
 /* gives us o2cb_subsys */
-decl_subsys(o2cb, NULL, NULL);
+static decl_subsys(o2cb, NULL, NULL);
 
 static ssize_t
 o2cb_show(struct kobject * kobj, struct attribute * attr, char * buffer)
--- linux-2.6.15-rc5-mm3-full/fs/ocfs2/dlm/dlmmaster.c.old	2005-12-17 20:10:22.000000000 +0100
+++ linux-2.6.15-rc5-mm3-full/fs/ocfs2/dlm/dlmmaster.c	2005-12-17 20:11:00.000000000 +0100
@@ -48,6 +48,7 @@
 #include "dlmapi.h"
 #include "dlmcommon.h"
 #include "dlmdebug.h"
+#include "dlmdomain.h"
 
 #define MLOG_MASK_PREFIX (ML_DLM|ML_DLM_MASTER)
 #include "cluster/masklog.h"
@@ -173,9 +174,6 @@
 	spin_unlock(&dlm->master_lock);
 }
 
-extern spinlock_t dlm_domain_lock;
-extern struct list_head dlm_domains;
-
 int dlm_dump_all_mles(const char __user *data, unsigned int len)
 {
 	struct list_head *iter;
--- linux-2.6.15-rc5-mm3-full/fs/ocfs2/dlm/dlmthread.c.old	2005-12-17 20:11:11.000000000 +0100
+++ linux-2.6.15-rc5-mm3-full/fs/ocfs2/dlm/dlmthread.c	2005-12-17 20:11:31.000000000 +0100
@@ -52,9 +52,6 @@
 #define MLOG_MASK_PREFIX (ML_DLM|ML_DLM_THREAD)
 #include "cluster/masklog.h"
 
-extern spinlock_t dlm_domain_lock;
-extern struct list_head dlm_domains;
-
 static int dlm_thread(void *data);
 
 static void dlm_flush_asts(struct dlm_ctxt *dlm);


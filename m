Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265400AbSKSOn3>; Tue, 19 Nov 2002 09:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265424AbSKSOn2>; Tue, 19 Nov 2002 09:43:28 -0500
Received: from holomorphy.com ([66.224.33.161]:1509 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265400AbSKSOn1>;
	Tue, 19 Nov 2002 09:43:27 -0500
Date: Tue, 19 Nov 2002 06:47:40 -0800
From: wli@holomorphy.com
To: linux-kernel@vger.kernel.org
Cc: kernel-janitor-discuss@lists.sourceforge.net
Subject: [1/2] privatize sibling functions from sched.h
Message-ID: <0211190647.BccdTchaqcDbBa8bAcgcOcbclc9dAdhc28334@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: patchbomb 0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This privatizes the sibling inlines to sched.c, the sole caller
of them.

 include/linux/sched.h |   24 ------------------------
 kernel/sched.c        |   18 ++++++++++++++++++
 2 files changed, 18 insertions(+), 24 deletions(-)


diff -urpN SRC_DIR/include/linux/sched.h siblings-2.5.48/include/linux/sched.h
--- SRC_DIR/include/linux/sched.h	2002-11-17 20:29:22.000000000 -0800
+++ siblings-2.5.48/include/linux/sched.h	2002-11-19 05:49:43.000000000 -0800
@@ -639,30 +639,6 @@ extern void kick_if_running(task_t * p);
 	add_parent(p, (p)->parent);				\
 	} while (0)
 
-static inline struct task_struct *eldest_child(struct task_struct *p)
-{
-	if (list_empty(&p->children)) return NULL;
-	return list_entry(p->children.next,struct task_struct,sibling);
-}
-
-static inline struct task_struct *youngest_child(struct task_struct *p)
-{
-	if (list_empty(&p->children)) return NULL;
-	return list_entry(p->children.prev,struct task_struct,sibling);
-}
-
-static inline struct task_struct *older_sibling(struct task_struct *p)
-{
-	if (p->sibling.prev==&p->parent->children) return NULL;
-	return list_entry(p->sibling.prev,struct task_struct,sibling);
-}
-
-static inline struct task_struct *younger_sibling(struct task_struct *p)
-{
-	if (p->sibling.next==&p->parent->children) return NULL;
-	return list_entry(p->sibling.next,struct task_struct,sibling);
-}
-
 #define next_task(p)	list_entry((p)->tasks.next, struct task_struct, tasks)
 #define prev_task(p)	list_entry((p)->tasks.prev, struct task_struct, tasks)
 
diff -urpN SRC_DIR/kernel/sched.c siblings-2.5.48/kernel/sched.c
--- SRC_DIR/kernel/sched.c	2002-11-17 20:29:52.000000000 -0800
+++ siblings-2.5.48/kernel/sched.c	2002-11-19 05:49:43.000000000 -0800
@@ -1837,6 +1837,24 @@ out_unlock:
 	return retval;
 }
 
+static inline struct task_struct *eldest_child(struct task_struct *p)
+{
+	if (list_empty(&p->children)) return NULL;
+	return list_entry(p->children.next,struct task_struct,sibling);
+}
+
+static inline struct task_struct *older_sibling(struct task_struct *p)
+{
+	if (p->sibling.prev==&p->parent->children) return NULL;
+	return list_entry(p->sibling.prev,struct task_struct,sibling);
+}
+
+static inline struct task_struct *younger_sibling(struct task_struct *p)
+{
+	if (p->sibling.next==&p->parent->children) return NULL;
+	return list_entry(p->sibling.next,struct task_struct,sibling);
+}
+
 static void show_task(task_t * p)
 {
 	unsigned long free = 0;

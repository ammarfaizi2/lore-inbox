Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262497AbVFJHZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbVFJHZX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 03:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbVFJHZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 03:25:21 -0400
Received: from cncln.online.ln.cn ([218.25.172.144]:9221 "HELO mail.fc-cn.com")
	by vger.kernel.org with SMTP id S262516AbVFJHX1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 03:23:27 -0400
Date: Fri, 10 Jun 2005 15:23:44 +0800
From: Coywolf Qi Hunt <qiyong@fc-cn.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [patch] next_mnt() cleanup
Message-ID: <20050610072344.GA6629@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

This is an obvious cleanup to next_mnt() by making use of list_empty().


Signed-off-by: Coywolf Qi Hunt <coywolf@lovecn.org>

--- linux-2.6.12-rc5-mm2/fs/namespace.c	2005-06-06 09:24:44.000000000 +0800
+++ linux-2.6.12-rc5-mm2-cy/fs/namespace.c	2005-06-10 14:56:47.000000000 +0800
@@ -133,8 +133,7 @@ static void attach_mnt(struct vfsmount *
 
 static struct vfsmount *next_mnt(struct vfsmount *p, struct vfsmount *root)
 {
-	struct list_head *next = p->mnt_mounts.next;
-	if (next == &p->mnt_mounts) {
+	if (list_empty(&p->mnt_mounts)) {
 		while (1) {
 			if (p == root)
 				return NULL;

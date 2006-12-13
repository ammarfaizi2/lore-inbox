Return-Path: <linux-kernel-owner+w=401wt.eu-S964861AbWLMLVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964861AbWLMLVF (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 06:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964873AbWLMLTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 06:19:48 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:57332 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964857AbWLMLTg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 06:19:36 -0500
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: "<Andrew Morton" <akpm@osdl.org>
Cc: <containers@lists.osdl.org>, Oleg Nesterov <oleg@tv-sign.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 1/12] tty:  Make __proc_set_tty static.
Date: Wed, 13 Dec 2006 04:07:45 -0700
Message-Id: <11660080761519-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.g3cd4f
In-Reply-To: <m1y7pcoy5w.fsf@ebiederm.dsl.xmission.com>
References: <m1y7pcoy5w.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently all users of __proc_set_tty are in tty_io.c so
make the function static.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 drivers/char/tty_io.c |    3 ++-
 include/linux/tty.h   |    1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tty_io.c b/drivers/char/tty_io.c
index a333881..bb09e4a 100644
--- a/drivers/char/tty_io.c
+++ b/drivers/char/tty_io.c
@@ -155,6 +155,7 @@ int tty_ioctl(struct inode * inode, struct file * file,
 	      unsigned int cmd, unsigned long arg);
 static int tty_fasync(int fd, struct file * filp, int on);
 static void release_mem(struct tty_struct *tty, int idx);
+static void __proc_set_tty(struct task_struct *tsk, struct tty_struct *tty);
 
 /**
  *	alloc_tty_struct	-	allocate a tty object
@@ -3796,7 +3797,7 @@ void proc_clear_tty(struct task_struct *p)
 }
 EXPORT_SYMBOL(proc_clear_tty);
 
-void __proc_set_tty(struct task_struct *tsk, struct tty_struct *tty)
+static void __proc_set_tty(struct task_struct *tsk, struct tty_struct *tty)
 {
 	if (tty) {
 		tty->session = process_session(tsk);
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 0161a8c..1185bca 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -313,7 +313,6 @@ extern int tty_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
 
 extern dev_t tty_devnum(struct tty_struct *tty);
 extern void proc_clear_tty(struct task_struct *p);
-extern void __proc_set_tty(struct task_struct *tsk, struct tty_struct *tty);
 extern void proc_set_tty(struct task_struct *tsk, struct tty_struct *tty);
 extern struct tty_struct *get_current_tty(void);
 
-- 
1.4.4.1.g278f


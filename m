Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266723AbRGTOAl>; Fri, 20 Jul 2001 10:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266898AbRGTOAc>; Fri, 20 Jul 2001 10:00:32 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:28687 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S266723AbRGTOAZ>; Fri, 20 Jul 2001 10:00:25 -0400
Message-ID: <15192.14679.866099.871164@beta.namesys.com>
Date: Fri, 20 Jul 2001 17:59:51 +0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailer: VM 6.89 under 21.1 (patch 8) "Bryce Canyon" XEmacs Lucid
From: Nikita Danilov <NikitaDanilov@Yahoo.COM>
To: linux-kernel@vger.kernel.org
Subject: patch to fs/proc/base.c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello, 

following patch cures oopses in 2.4.7-pre9 when 
proc_pid_make_inode() is called on task with task->mm == NULL.

Linus, please apply, if you haven't got a bunch of equivalent patches
already, which is doubtful.

Nikita.
------------------------------------------------------------
--- linux-2.4.7-pre9/fs/proc/base.c    Fri Jul 20 14:57:55 2001
+++ linux-2.4.7-pre9.patched/fs/proc/base.c     Fri Jul 20 17:03:23 2001
@@ -670,7 +670,7 @@ static struct inode *proc_pid_make_inode
        inode->u.proc_i.task = task;
        inode->i_uid = 0;
        inode->i_gid = 0;
-       if (ino == PROC_PID_INO || task->mm->dumpable) {
+       if (ino == PROC_PID_INO || (task->mm && task->mm->dumpable)) {
                inode->i_uid = task->euid;
                inode->i_gid = task->egid;
        }
------------------------------------------------------------

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261326AbSJHTOy>; Tue, 8 Oct 2002 15:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261455AbSJHTNy>; Tue, 8 Oct 2002 15:13:54 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28432 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261326AbSJHTIu>; Tue, 8 Oct 2002 15:08:50 -0400
Subject: PATCH: Fix 2.5 signal handling in jffs/jffs2
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 8 Oct 2002 20:05:59 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17yzg7-0004vD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo chamged it again 8)

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/fs/jffs/intrep.c linux.2.5.41-ac1/fs/jffs/intrep.c
--- linux.2.5.41/fs/jffs/intrep.c	2002-10-07 22:12:27.000000000 +0100
+++ linux.2.5.41-ac1/fs/jffs/intrep.c	2002-10-08 00:18:23.000000000 +0100
@@ -3380,9 +3380,9 @@
 
 			spin_lock_irq(&current->sig->siglock);
 			if (current->sig->shared_pending.head)
-				signr = dequeue_signal(&current->sig->shared_pending, &current->blocked, &info);
+				signr = dequeue_signal(&current->sig->shared_pending, &info);
 			if (!signr)
-				signr = dequeue_signal(&current->pending, &current->blocked, &info);
+				signr = dequeue_signal(&current->pending, &info);
 			spin_unlock_irq(&current->sig->siglock);
 
 			switch(signr) {
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/fs/jffs2/background.c linux.2.5.41-ac1/fs/jffs2/background.c
--- linux.2.5.41/fs/jffs2/background.c	2002-10-07 22:12:27.000000000 +0100
+++ linux.2.5.41-ac1/fs/jffs2/background.c	2002-10-08 00:19:01.000000000 +0100
@@ -116,9 +116,9 @@
 
                         spin_lock_irq(&current->sig->siglock);
 			if (current->sig->shared_pending.head)
-				signr = dequeue_signal(&current->sig->shared_pending, &current->blocked, &info);
+				signr = dequeue_signal(&current->sig->shared_pending, &info);
 			if (!signr)
-				signr = dequeue_signal(&current->pending, &current->blocked, &info);
+				signr = dequeue_signal(&current->pending, &info);
                         spin_unlock_irq(&current->sig->siglock);
 
                         switch(signr) {

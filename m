Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129133AbQJ3OGi>; Mon, 30 Oct 2000 09:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129208AbQJ3OGT>; Mon, 30 Oct 2000 09:06:19 -0500
Received: from fe3.rdc-kc.rr.com ([24.94.163.50]:59401 "EHLO mail3.kc.rr.com")
	by vger.kernel.org with ESMTP id <S129133AbQJ3OGJ>;
	Mon, 30 Oct 2000 09:06:09 -0500
Message-Id: <m13qFZf-001qifC@microdog>
Date: Mon, 30 Oct 2000 08:06:07 -0600 (CST)
From: Mike Coleman <mcoleman2@kc.rr.com>
To: torvalds@transmeta.com
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] TracerPid in /proc/<n>/status is wrong
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

This patch fixes the bogus value of the TracerPid field in /proc/<n>/status.

(I thought was patched several months back, but I guess it wasn't, or it got
mistakenly backed out.)

--Mike


--- fs/proc/array.c-dist	Fri Sep  1 16:32:17 2000
+++ fs/proc/array.c	Mon Oct 30 08:02:35 2000
@@ -157,7 +157,7 @@
 		"Uid:\t%d\t%d\t%d\t%d\n"
 		"Gid:\t%d\t%d\t%d\t%d\n",
 		get_task_state(p),
-		p->pid, p->p_opptr->pid, p->p_pptr->pid != p->p_opptr->pid ? p->p_opptr->pid : 0,
+		p->pid, p->p_opptr->pid, p->p_pptr->pid != p->p_opptr->pid ? p->p_pptr->pid : 0,
 		p->uid, p->euid, p->suid, p->fsuid,
 		p->gid, p->egid, p->sgid, p->fsgid);
 	read_unlock(&tasklist_lock);	
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

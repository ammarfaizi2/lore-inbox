Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277154AbRJHVxp>; Mon, 8 Oct 2001 17:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277156AbRJHVxf>; Mon, 8 Oct 2001 17:53:35 -0400
Received: from t2.redhat.com ([199.183.24.243]:58608 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S277154AbRJHVx3>; Mon, 8 Oct 2001 17:53:29 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <E15qcua-00010T-00@the-village.bc.nu> 
In-Reply-To: <E15qcua-00010T-00@the-village.bc.nu> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: dmccr@us.ibm.com (Dave McCracken), torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (Linux Kernel)
Subject: Re: [PATCH] Provide system call to get task id 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 08 Oct 2001 22:53:41 +0100
Message-ID: <12421.1002578021@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


While we're at it, we should probably be exporting the tgid from 
/proc/$pid/status.

Index: fs/proc/array.c
===================================================================
RCS file: /inst/cvs/linux/fs/proc/array.c,v
retrieving revision 1.5.2.32
diff -u -r1.5.2.32 array.c
--- fs/proc/array.c	2001/08/07 08:10:59	1.5.2.32
+++ fs/proc/array.c	2001/10/08 21:52:30
@@ -151,12 +151,13 @@
 	read_lock(&tasklist_lock);
 	buffer += sprintf(buffer,
 		"State:\t%s\n"
+		"Tgid:\t%d\n"
 		"Pid:\t%d\n"
 		"PPid:\t%d\n"
 		"TracerPid:\t%d\n"
 		"Uid:\t%d\t%d\t%d\t%d\n"
 		"Gid:\t%d\t%d\t%d\t%d\n",
-		get_task_state(p),
+		get_task_state(p), p->tgid,
 		p->pid, p->pid ? p->p_opptr->pid : 0, 0,
 		p->uid, p->euid, p->suid, p->fsuid,
 		p->gid, p->egid, p->sgid, p->fsgid);

--
dwmw2



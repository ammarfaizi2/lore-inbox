Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318649AbSIFOb6>; Fri, 6 Sep 2002 10:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318690AbSIFOb6>; Fri, 6 Sep 2002 10:31:58 -0400
Received: from crack.them.org ([65.125.64.184]:22791 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S318649AbSIFOb4>;
	Fri, 6 Sep 2002 10:31:56 -0400
Date: Fri, 6 Sep 2002 10:36:36 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [trivial] Print tracer PID in /proc/<pid>/status
Message-ID: <20020906143636.GA10509@nevyn.them.org>
Mail-Followup-To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We've got a labeled field for showing which process is debugging this one,
but we weren't filling it in.  This is useful in working on the ptrace
code... please apply.

===== array.c 1.26 vs edited =====
--- 1.26/fs/proc/array.c	Wed Jul 24 21:36:09 2002
+++ edited/array.c	Thu Sep  5 16:38:35 2002
@@ -160,7 +160,8 @@
 		"Uid:\t%d\t%d\t%d\t%d\n"
 		"Gid:\t%d\t%d\t%d\t%d\n",
 		get_task_state(p), p->tgid,
-		p->pid, p->pid ? p->real_parent->pid : 0, 0,
+		p->pid, p->pid ? p->real_parent->pid : 0,
+		p->pid && p->ptrace ? p->parent->pid : 0,
 		p->uid, p->euid, p->suid, p->fsuid,
 		p->gid, p->egid, p->sgid, p->fsgid);
 	read_unlock(&tasklist_lock);	


-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer

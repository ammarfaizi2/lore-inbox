Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271310AbRHTPjj>; Mon, 20 Aug 2001 11:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271307AbRHTPj3>; Mon, 20 Aug 2001 11:39:29 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:30911 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S271318AbRHTPjT>;
	Mon, 20 Aug 2001 11:39:19 -0400
Date: Mon, 20 Aug 2001 10:39:20 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.9 Make thread group id visible in /proc/<pid>/status
Message-ID: <92830000.998321960@baldur>
X-Mailer: Mulberry/2.1.0b3 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It would be useful in many contexts to be able to see the thread group id. 
This would make it easier to identify tasks that are part of a 
multi-threaded process, at least for those that are using pthreads.  This 
patch adds a TGid field to the status file.  This will not break ps, since 
ps skips any field in status that it doesn't understand.

Patch is below.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

==========================

--- linux-2.4.9/./fs/proc/array.c	Thu Jul 26 15:42:56 2001
+++ linux-2.4.9-tgid/./fs/proc/array.c	Mon Aug 20 10:05:18 2001
@@ -153,11 +153,12 @@
 		"State:\t%s\n"
 		"Pid:\t%d\n"
 		"PPid:\t%d\n"
+		"TGid:\t%d\n"
 		"TracerPid:\t%d\n"
 		"Uid:\t%d\t%d\t%d\t%d\n"
 		"Gid:\t%d\t%d\t%d\t%d\n",
 		get_task_state(p),
-		p->pid, p->pid ? p->p_opptr->pid : 0, 0,
+		p->pid, p->pid ? p->p_opptr->pid : 0, p->tgid, 0,
 		p->uid, p->euid, p->suid, p->fsuid,
 		p->gid, p->egid, p->sgid, p->fsgid);
 	read_unlock(&tasklist_lock);	


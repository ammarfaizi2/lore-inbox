Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267144AbSLRFqK>; Wed, 18 Dec 2002 00:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267170AbSLRFqK>; Wed, 18 Dec 2002 00:46:10 -0500
Received: from holomorphy.com ([66.224.33.161]:9915 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267144AbSLRFqJ>;
	Wed, 18 Dec 2002 00:46:09 -0500
Date: Tue, 17 Dec 2002 21:53:39 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Jeff Dike <jdike@karaya.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: Re: uml-patch-2.5.52-1
Message-ID: <20021218055339.GF1922@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jeff Dike <jdike@karaya.com>, linux-kernel@vger.kernel.org,
	user-mode-linux-devel@lists.sourceforge.net
References: <200212180054.gBI0s0D11497@karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212180054.gBI0s0D11497@karaya.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2002 at 07:54:00PM -0500, Jeff Dike wrote:
> This patch updates UML to 2.5.52.  As far as UML itself is concerned, this
> is identical to all recent 2.5 UML releases.
> The file corruption that I saw with the 2.5.50 UML seems to be gone; however
> Oleg Drokin is maintaining his own 2.5 UML repo, with forward ports of my 2.4
> updates, and he's reporting corruption with his 2.5.52.  I've exercised this
> patch with kernel builds and various other loads and seen no problem, so it's
> possible the problem is in his pool and not mine - however, caveat user.
> The 2.5.52 UML patch is available at
>         http://uml-pub.ists.dartmouth.edu/uml/uml-patch-2.5.52-1.bz2
> For the other UML mirrors and other downloads, see 
>         http://user-mode-linux.sourceforge.net/dl-sf.html

I have a pending patch against your tree. Could you review this, and if
it pass, include it in your tree?

Thanks,
Bill


get_task() really wants to do find_task_by_pid().
This calls find_task_by_pid() directly.

 process_kern.c |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)


diff -urpN uml-2.5.52-1/arch/um/kernel/process_kern.c uml-2.5.52-2/arch/um/kernel/process_kern.c
--- uml-2.5.52-1/arch/um/kernel/process_kern.c	2002-12-17 19:54:03.000000000 -0800
+++ uml-2.5.52-2/arch/um/kernel/process_kern.c	2002-12-17 21:51:29.000000000 -0800
@@ -52,16 +52,10 @@ struct cpu_task cpu_tasks[NR_CPUS] = { [
 
 struct task_struct *get_task(int pid, int require)
 {
-        struct task_struct *task, *ret;
+        struct task_struct *ret;
 
-        ret = NULL;
         read_lock(&tasklist_lock);
-        for_each_process(task){
-                if(task->pid == pid){
-                        ret = task;
-                        break;
-                }
-        }
+	ret = find_task_by_pid(pid);
         read_unlock(&tasklist_lock);
         if(require && (ret == NULL)) panic("get_task couldn't find a task\n");
         return(ret);

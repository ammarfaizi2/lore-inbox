Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbTEFUIP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 16:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbTEFUIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 16:08:14 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:48092 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S261414AbTEFUIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 16:08:13 -0400
Date: Tue, 6 May 2003 13:20:42 -0700
Message-Id: <200305062020.h46KKg219477@magilla.sf.frob.com>
From: Roland McGrath <roland@frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
X-Fcc: ~/Mail/linus
Subject: [PATCH] core dump psinfo.pr_sname letter fix
X-Shopping-List: (1) Evangelical yies
   (2) Arctic Pigs
   (3) Frilly breath vagrants
   (4) Mix 'n' Match Yies
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed this a long time ago and forgot that it was still broken in 2.5.
This patch makes the state letter in the pr_sname field in core dumps
correct for stopped and zombie threads.  The order needed to be changed when
the TASK_* values changed.  This matches the letters used in sched.c:show_task.


Thanks,
Roland


--- linux-2.5.69/fs/binfmt_elf.c.~1~	Sun May  4 16:53:14 2003
+++ linux-2.5.69/fs/binfmt_elf.c	Tue May  6 13:16:37 2003
@@ -1105,7 +1105,7 @@ static void fill_psinfo(struct elf_prpsi
 
 	i = p->state ? ffz(~p->state) + 1 : 0;
 	psinfo->pr_state = i;
-	psinfo->pr_sname = (i < 0 || i > 5) ? '.' : "RSDZTD"[i];
+	psinfo->pr_sname = (i < 0 || i > 5) ? '.' : "RSDTZW"[i];
 	psinfo->pr_zomb = psinfo->pr_sname == 'Z';
 	psinfo->pr_nice = task_nice(p);
 	psinfo->pr_flag = p->flags;

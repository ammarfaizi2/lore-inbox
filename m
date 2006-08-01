Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030401AbWHACnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030401AbWHACnd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 22:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030402AbWHACnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 22:43:33 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:58686 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030401AbWHACnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 22:43:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=e17nSMVpKo/gDi+vA/gScuY58fYC0pMZULbu5ql9fZUTTkNAPx+XhnwOyVPDH6H7xmRJGEZLskuksKYy0sXJ7HYf+/gGeDPUkJL04ihtXoLLJ75IIop9/1/S1Cwc96p70IfFiVoh/8a/9jGp5uiVvkFJn+OugbC3Z5EU5eNS7gc=
Date: Tue, 1 Aug 2006 06:43:24 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] task_struct: ifdef Missed'em V IPC
Message-ID: <20060801024324.GC7006@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ipc/sem.c only.

$ agrep sysvsem -w -n
ipc/sem.c:912:  undo_list = current->sysvsem.undo_list;
ipc/sem.c:932:  undo_list = current->sysvsem.undo_list;
ipc/sem.c:954:  undo_list = current->sysvsem.undo_list;
ipc/sem.c:963:          current->sysvsem.undo_list = undo_list;
ipc/sem.c:1247:         tsk->sysvsem.undo_list = undo_list;
ipc/sem.c:1249:         tsk->sysvsem.undo_list = NULL;
ipc/sem.c:1271: undo_list = tsk->sysvsem.undo_list;
include/linux/sched.h:876:      struct sysv_sem sysvsem;

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/linux/sched.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -872,8 +872,10 @@ #endif
 				     - initialized normally by flush_old_exec */
 /* file system info */
 	int link_count, total_link_count;
+#ifdef CONFIG_SYSVIPC
 /* ipc stuff */
 	struct sysv_sem sysvsem;
+#endif
 /* CPU-specific state of this task */
 	struct thread_struct thread;
 /* filesystem information */


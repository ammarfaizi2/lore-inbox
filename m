Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751573AbWBDTPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbWBDTPv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 14:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751574AbWBDTPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 14:15:51 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:55017 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751565AbWBDTPu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 14:15:50 -0500
Message-ID: <43E50F78.7C48737F@tv-sign.ru>
Date: Sat, 04 Feb 2006 23:32:56 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH rc1-mm] reparent_thread: use remove_parent/add_parent
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(depends on remove-add_parents-parent-argument.patch)

Trivial, use remove_parent/add_parent instead of open coding.

No changes in kernel/exit.o

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- RC-1/kernel/exit.c~	2006-02-04 22:06:27.000000000 +0300
+++ RC-1/kernel/exit.c	2006-02-04 22:17:54.000000000 +0300
@@ -548,9 +548,9 @@ static void reparent_thread(task_t *p, t
 		 * anyway, so let go of it.
 		 */
 		p->ptrace = 0;
-		list_del_init(&p->sibling);
+		remove_parent(p);
 		p->parent = p->real_parent;
-		list_add_tail(&p->sibling, &p->parent->children);
+		add_parent(p);
 
 		/* If we'd notified the old parent about this child's death,
 		 * also notify the new parent.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932332AbWBFTtV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbWBFTtV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 14:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbWBFTtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 14:49:21 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:60397 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932332AbWBFTtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 14:49:20 -0500
To: <linux-kernel@vger.kernel.org>
Cc: <vserver@list.linux-vserver.org>, Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Kirill Korotaev <dev@sw.ru>, Greg <gkurz@fr.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, Rik van Riel <riel@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
       Andi Kleen <ak@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jes Sorensen <jes@sgi.com>
Subject: [RFC][PATCH 09/20] ptrace: Update ptrace handle pspaces.
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com>
	<m1vevsmgvz.fsf@ebiederm.dsl.xmission.com>
	<m1lkwomgoj.fsf_-_@ebiederm.dsl.xmission.com>
	<m1fymwmgk0.fsf_-_@ebiederm.dsl.xmission.com>
	<m1bqxkmgcv.fsf_-_@ebiederm.dsl.xmission.com>
	<m17j88mg8l.fsf_-_@ebiederm.dsl.xmission.com>
	<m13biwmg4p.fsf_-_@ebiederm.dsl.xmission.com>
	<m1y80ol1gh.fsf_-_@ebiederm.dsl.xmission.com>
	<m1u0bcl1ai.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 06 Feb 2006 12:46:59 -0700
In-Reply-To: <m1u0bcl1ai.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Mon, 06 Feb 2006 12:44:53 -0700")
Message-ID: <m1psm0l170.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 kernel/ptrace.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

38464ccf04964acc267370758e89a9b4813b6191
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 5f33cdb..73dc283 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -455,7 +455,7 @@ struct task_struct *ptrace_get_task_stru
 		return ERR_PTR(-EPERM);
 
 	read_lock(&tasklist_lock);
-	child = find_task_by_pid(pid);
+	child = find_task_by_pid(current->pspace, pid);
 	if (child)
 		get_task_struct(child);
 	read_unlock(&tasklist_lock);
-- 
1.1.5.g3480


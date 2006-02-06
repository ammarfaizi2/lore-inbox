Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbWBFUBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbWBFUBN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 15:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbWBFUBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 15:01:13 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:16768 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932346AbWBFUBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 15:01:11 -0500
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
Subject: [RFC][PATCH 13/20] kthread: Update kthread to work with pspaces.
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com>
	<m1vevsmgvz.fsf@ebiederm.dsl.xmission.com>
	<m1lkwomgoj.fsf_-_@ebiederm.dsl.xmission.com>
	<m1fymwmgk0.fsf_-_@ebiederm.dsl.xmission.com>
	<m1bqxkmgcv.fsf_-_@ebiederm.dsl.xmission.com>
	<m17j88mg8l.fsf_-_@ebiederm.dsl.xmission.com>
	<m13biwmg4p.fsf_-_@ebiederm.dsl.xmission.com>
	<m1y80ol1gh.fsf_-_@ebiederm.dsl.xmission.com>
	<m1u0bcl1ai.fsf_-_@ebiederm.dsl.xmission.com>
	<m1psm0l170.fsf_-_@ebiederm.dsl.xmission.com>
	<m1lkwol133.fsf_-_@ebiederm.dsl.xmission.com>
	<m1hd7cl0yp.fsf_-_@ebiederm.dsl.xmission.com>
	<m1d5i0l0ua.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 06 Feb 2006 12:57:38 -0700
In-Reply-To: <m1d5i0l0ua.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Mon, 06 Feb 2006 12:54:37 -0700")
Message-ID: <m18xsol0p9.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 kernel/kthread.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

4dbaead60e8ba1ef38aea6059d1abb6f6a10fd1b
diff --git a/kernel/kthread.c b/kernel/kthread.c
index e75950a..0b4fa7b 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -12,6 +12,7 @@
 #include <linux/unistd.h>
 #include <linux/file.h>
 #include <linux/module.h>
+#include <linux/pspace.h>
 #include <asm/semaphore.h>
 
 /*
@@ -114,7 +115,7 @@ static void keventd_create_kthread(void 
 		create->result = ERR_PTR(pid);
 	} else {
 		wait_for_completion(&create->started);
-		create->result = find_task_by_pid(pid);
+		create->result = find_task_by_pid(current->pspace, pid);
 	}
 	complete(&create->done);
 }
-- 
1.1.5.g3480


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261295AbTAaOgI>; Fri, 31 Jan 2003 09:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261302AbTAaOgI>; Fri, 31 Jan 2003 09:36:08 -0500
Received: from 5-116.ctame701-1.telepar.net.br ([200.193.163.116]:60607 "EHLO
	5-116.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S261295AbTAaOgH>; Fri, 31 Jan 2003 09:36:07 -0500
Date: Fri, 31 Jan 2003 12:45:11 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
cc: linux-kernel@vger.kernel.org, "" <linux-mm@kvack.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [PATCH] rmap 15c
In-Reply-To: <200301301709.09692.m.c.p@wolk-project.de>
Message-ID: <Pine.LNX.4.50L.0301311244280.2429-100000@imladris.surriel.com>
References: <Pine.LNX.4.50L.0301301131220.27926-100000@imladris.surriel.com>
 <200301301709.09692.m.c.p@wolk-project.de>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jan 2003, Marc-Christian Petersen wrote:
> On Thursday 30 January 2003 14:32, Rik van Riel wrote:
>
> Hi Rik,
>
> > rmap 15c:
> >   - backport and audit akpm's reliable pte_chain alloc
> >     code from 2.5                                         (me)
> >   - reintroduce cache size tuning knobs in /proc          (me)
> >     | on very, very popular request
>
> GREAT to see this. Already merged for wolk4.0s-pre10 :)

Better merge this little patch, too.  Arjan spotted this
bug and now I'm not sure why rmap15c worked at all, let
alone why it survived a night of stress testing ... ;)

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.793   -> 1.794
#	           fs/exec.c	1.24    -> 1.25
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/01/31	riel@imladris.surriel.com	1.794
# uh oh, here we could end up freeing a used pte_chain
# (thanks arjan)
# --------------------------------------------
#
diff -Nru a/fs/exec.c b/fs/exec.c
--- a/fs/exec.c	Fri Jan 31 12:44:30 2003
+++ b/fs/exec.c	Fri Jan 31 12:44:30 2003
@@ -308,7 +308,7 @@
 	flush_dcache_page(page);
 	flush_page_to_ram(page);
 	set_pte(pte, pte_mkdirty(pte_mkwrite(mk_pte(page, PAGE_COPY))));
-	page_add_rmap(page, pte, pte_chain);
+	pte_chain = page_add_rmap(page, pte, pte_chain);
 	tsk->mm->rss++;
 	pte_unmap(pte);
 	spin_unlock(&tsk->mm->page_table_lock);

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

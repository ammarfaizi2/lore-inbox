Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261318AbSJPTZw>; Wed, 16 Oct 2002 15:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261278AbSJPTZw>; Wed, 16 Oct 2002 15:25:52 -0400
Received: from 2-136.ctame701-1.telepar.net.br ([200.193.160.136]:15577 "EHLO
	2-136.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S261340AbSJPTYa>; Wed, 16 Oct 2002 15:24:30 -0400
Date: Wed, 16 Oct 2002 17:30:04 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][DOC]  kernelnewbies helpful hint #1
Message-ID: <Pine.LNX.4.44L.0210161729140.22993-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this little patch documents a point in the scheduler where many people
seem to get confused.


===== kernel/sched.c 1.140 vs edited =====
--- 1.140/kernel/sched.c	Mon Oct 14 10:30:06 2002
+++ edited/kernel/sched.c	Wed Oct 16 17:28:29 2002
@@ -1035,6 +1035,12 @@

 		prepare_arch_switch(rq, next);
 		prev = context_switch(prev, next);
+		/*
+		 * Kernelnewbies hint:  at this point the current process
+		 * has switched from prev to next.  Prev is sitting on the
+		 * run queue and next unlocks the runqueue, either here or
+		 * in ret_from_fork (for newly forked processes).
+		 */
 		barrier();
 		rq = this_rq();
 		finish_arch_switch(rq, prev);

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://distro.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>


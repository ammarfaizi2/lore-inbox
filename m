Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267854AbTBVUWe>; Sat, 22 Feb 2003 15:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267878AbTBVUWe>; Sat, 22 Feb 2003 15:22:34 -0500
Received: from 5-077.ctame701-1.telepar.net.br ([200.193.163.77]:40590 "EHLO
	5-077.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S267854AbTBVUWd>; Sat, 22 Feb 2003 15:22:33 -0500
Date: Sat, 22 Feb 2003 17:32:33 -0300 (BRT)
From: Rik van Riel <riel@imladris.surriel.com>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: oom killer and its superior braindamage in 2.4
In-Reply-To: <Pine.LNX.4.50L.0302221711100.2206-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.50L.0302221732010.2206-100000@imladris.surriel.com>
References: <200302222025.48129.m.c.p@wolk-project.de>
 <Pine.LNX.4.50L.0302221711100.2206-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Feb 2003, Rik van Riel wrote:
> On Sat, 22 Feb 2003, Marc-Christian Petersen wrote:
>
> > - Feb 21 10:04:57 codeman kernel: Out of Memory: Killed process 2657 (apache).
> >
> > The above log entry (apache) appeared for about 4 hours every some
> > seconds (same PID) until I thought about sysrq-b
>
> > Is there any chance we can fix this up?
>
> Yes.

Never mind my last idea, it can be done much simpler ;)

Does the below patch fix your problem ?

Rik
-- 
Engineers don't grow up, they grow sideways.
http://www.surriel.com/		http://kernelnewbies.org/


===== mm/oom_kill.c 1.11 vs edited =====
--- 1.11/mm/oom_kill.c	Fri Aug 16 10:59:46 2002
+++ edited/mm/oom_kill.c	Sat Feb 22 17:31:49 2003
@@ -61,6 +61,9 @@

 	if (!p->mm)
 		return 0;
+
+	if (p->flags & PF_MEMDIE)
+		return 0;
 	/*
 	 * The memory size of the process is the basis for the badness.
 	 */

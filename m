Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267847AbTBVUEd>; Sat, 22 Feb 2003 15:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267848AbTBVUEd>; Sat, 22 Feb 2003 15:04:33 -0500
Received: from 5-077.ctame701-1.telepar.net.br ([200.193.163.77]:32909 "EHLO
	5-077.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S267847AbTBVUEc>; Sat, 22 Feb 2003 15:04:32 -0500
Date: Sat, 22 Feb 2003 17:14:18 -0300 (BRT)
From: Rik van Riel <riel@imladris.surriel.com>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: oom killer and its superior braindamage in 2.4
In-Reply-To: <200302222025.48129.m.c.p@wolk-project.de>
Message-ID: <Pine.LNX.4.50L.0302221711100.2206-100000@imladris.surriel.com>
References: <200302222025.48129.m.c.p@wolk-project.de>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Feb 2003, Marc-Christian Petersen wrote:

> - Feb 21 10:04:57 codeman kernel: Out of Memory: Killed process 2657 (apache).
>
> The above log entry (apache) appeared for about 4 hours every some
> seconds (same PID) until I thought about sysrq-b

> Is there any chance we can fix this up?

Yes.

1) add a VM_KILLED flag
2) set this flag on the p->mm->def_flags when you kill a
   process/thread from oom_kill.c
3) clear the flag on process exit

4) on a new call to oom_kill, skip processes when
   (p->mm->def_flags & VM_KILLED) by returning 0
   points for such a process

cheers,

Rik
-- 
Engineers don't grow up, they grow sideways.
http://www.surriel.com/		http://kernelnewbies.org/

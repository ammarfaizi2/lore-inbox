Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264329AbRFSPtN>; Tue, 19 Jun 2001 11:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264330AbRFSPtD>; Tue, 19 Jun 2001 11:49:03 -0400
Received: from isimail.interactivesi.com ([207.8.4.3]:22536 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S264329AbRFSPs7>; Tue, 19 Jun 2001 11:48:59 -0400
Date: Tue, 19 Jun 2001 10:48:48 -0500
From: Timur Tabi <ttabi@interactivesi.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <635DA093636@vcnet.vc.cvut.cz>
Subject: Re: gnu asm help...
X-Mailer: The Polarbar Mailer; version=1.19a; build=73
Message-ID: <giuPyB.A.JvE.jR3L7@dinero.interactivesi.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

** Reply to message from "Petr Vandrovec" <VANDROVE@vc.cvut.cz> on Tue, 19 Jun
2001 01:36:26 MET-1


> No. Another CPU might increment value between LOCK INCL and
> fetching v->counter. On ia32 architecture you are almost out of
> luck. You can either try building atomic_inc around CMPXCHG,
> using it as conditional store (but CMPXCHG is not available 
> on i386), or you can just guard your atomic variable with 
> spinlock - but in that case there is no reason for using atomic_t 
> at all.

Oh, I see the problem.  You could do something like this:

cli
mov %0, %%eax
inc %%eax
mov %%eax, %0
sti

and then return eax, but that won't work on SMP (whereas the "lock inc" does).
Doing a global cli might work, though.


-- 
Timur Tabi - ttabi@interactivesi.com
Interactive Silicon - http://www.interactivesi.com


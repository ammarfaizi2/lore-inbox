Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132580AbRDEJQq>; Thu, 5 Apr 2001 05:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132583AbRDEJQh>; Thu, 5 Apr 2001 05:16:37 -0400
Received: from [212.115.175.146] ([212.115.175.146]:38132 "EHLO
	ftrs1.intranet.FTR.NL") by vger.kernel.org with ESMTP
	id <S132580AbRDEJQ1>; Thu, 5 Apr 2001 05:16:27 -0400
Message-ID: <27525795B28BD311B28D00500481B7601F1169@ftrs1.intranet.ftr.nl>
From: "Heusden, Folkert van" <f.v.heusden@ftr.nl>
To: manfred@colorfullife.com
Cc: linux-kernel@vger.kernel.org
Subject: RE: random PIDs
Date: Thu, 5 Apr 2001 11:15:13 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  Finished & tested my random PID kernel/fork.c:get_pid() replacement. 
> > This one keeps track of the last N (default is 64) pids who have exited.

> > These are then not used. So, one cannot have more then 32767 - (64 + 1 
> > (init) + 1 (idle)) = 32761 processes :o) 
> DW> Huh, should be 32701, right?! 
> You're absolutely right. It must've been the victory trance :o) 
M> Have you actually tried to create lots of threads?

No

M> IIRC get_pid will loop forever if it doesn't find a free pid, and in the
M> worst case you can trigger that with ~11000 running threads.

Ah, ok. But why would you have 11.000 running threads?

M> And the current code can create multiple threads with the same pid (I
M> never tried to trigger that bug, but it seems to be possible)

mine will do that too:

        if (flags & CLONE_PID)
                return current->pid;

As far as my knowledge reaches, threads are cloned which triggers the
code I quoted above.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132587AbRDEKAO>; Thu, 5 Apr 2001 06:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132592AbRDEKAE>; Thu, 5 Apr 2001 06:00:04 -0400
Received: from [202.54.26.202] ([202.54.26.202]:5269 "EHLO hindon.hss.co.in")
	by vger.kernel.org with ESMTP id <S132587AbRDEJ7w>;
	Thu, 5 Apr 2001 05:59:52 -0400
X-Lotus-FromDomain: HSS
From: alad@hss.hns.com
To: "Heusden, Folkert van" <f.v.heusden@ftr.nl>
cc: manfred@colorfullife.com, linux-kernel@vger.kernel.org
Message-ID: <65256A25.003515C5.00@sandesh.hss.hns.com>
Date: Thu, 5 Apr 2001 15:16:45 +0530
Subject: RE: random PIDs
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org








"Heusden, Folkert van" <f.v.heusden@ftr.nl> on 04/05/2001 03:45:13 PM

To:   manfred@colorfullife.com
cc:   linux-kernel@vger.kernel.org (bcc: Amol Lad/HSS)

Subject:  RE: random PIDs




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

>>>> cloning of threads never means that all the clome flags are set.. AFAIK
CLONE_PID flag is used only by swpapper
process (pid- 0) during boot-up and then never used again....
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/





Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132736AbRDDHzq>; Wed, 4 Apr 2001 03:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132759AbRDDHzg>; Wed, 4 Apr 2001 03:55:36 -0400
Received: from chiara.elte.hu ([157.181.150.200]:26124 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S132736AbRDDHz2>;
	Wed, 4 Apr 2001 03:55:28 -0400
Date: Wed, 4 Apr 2001 08:53:36 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Fabio Riccardi <fabio@chromium.com>
Cc: Mike Kravetz <mkravetz@sequent.com>, <frankeh@us.ibm.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: a quest for a better scheduler
In-Reply-To: <3ACA683A.89D24DED@chromium.com>
Message-ID: <Pine.LNX.4.30.0104040835470.1708-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 3 Apr 2001, Fabio Riccardi wrote:

> I've spent my afternoon running some benchmarks to see if MQ patches
> would degrade performance in the "normal case".

no doubt priority-queue can run almost as fast as the current scheduler.
What i'm worried about is the restriction of the 'priority' of processes,
it cannot depend on previous processes (and other 'current state')
anymore.

to so we have two separate issues:

#1: priority-queue: has the fundamental goodness() design limitation.

#2: per-CPU-runqueues: changes semantics, makes scheduler less
    effective due to nonglobal decisions.

about #1: while right now the prev->mm rule appears to be a tiny issue (it
might not affect performance significantly), but forbidding it by
hardcoding the assumption into data structures is a limitation of *future*
goodness() functions. Eg. with the possible emergence of CPU-level
threading and other, new multiprocessing technologies, this could be a
*big* mistake.

the Linux scheduler is not designed for the case of 1000 runnable
processes.

	Ingo


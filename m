Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132755AbRDDQLd>; Wed, 4 Apr 2001 12:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132784AbRDDQLY>; Wed, 4 Apr 2001 12:11:24 -0400
Received: from dns-229.dhcp-248.nai.com ([161.69.248.229]:25024 "HELO
	localdomain") by vger.kernel.org with SMTP id <S132755AbRDDQLM>;
	Wed, 4 Apr 2001 12:11:12 -0400
Message-ID: <XFMail.20010404091254.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.30.0104040835470.1708-100000@elte.hu>
Date: Wed, 04 Apr 2001 09:12:54 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: a quest for a better scheduler
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>, frankeh@us.ibm.com,
        Mike Kravetz <mkravetz@sequent.com>,
        Fabio Riccardi <fabio@chromium.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 04-Apr-2001 Ingo Molnar wrote:
> 
> On Tue, 3 Apr 2001, Fabio Riccardi wrote:
> 
>> I've spent my afternoon running some benchmarks to see if MQ patches
>> would degrade performance in the "normal case".
> 
> no doubt priority-queue can run almost as fast as the current scheduler.
> What i'm worried about is the restriction of the 'priority' of processes,
> it cannot depend on previous processes (and other 'current state')
> anymore.
> 
> to so we have two separate issues:
> 
>#1: priority-queue: has the fundamental goodness() design limitation.
> 
>#2: per-CPU-runqueues: changes semantics, makes scheduler less
>     effective due to nonglobal decisions.
> 
> about #1: while right now the prev->mm rule appears to be a tiny issue (it
> might not affect performance significantly), but forbidding it by
> hardcoding the assumption into data structures is a limitation of *future*
> goodness() functions. Eg. with the possible emergence of CPU-level
> threading and other, new multiprocessing technologies, this could be a
> *big* mistake.

This is not correct Ingo. I haven't seen the HP code but if You store processes
in slots S :

S = FS( goodness(p, p->processor, p->mm) )

and You start scanning from the higher slots, as soon as you find a task with a
goodness G' that is equal to the max goodness in slot You can choose that
process to run.
Again, if You haven't found such a goodness during the slot scan but You've
found a task with a goodness G' :

G' >= SG - DD

where :

SG = max slot goodness
DD = SG(i) - SG(i - 1)

You can select that task as the next to spin.
This was the behaviour that was implemented in my scheduler patch about 2 years
ago.
Beside this, I this that with such loads We've more serious problem to face
with inside the kernel.



- Davide


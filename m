Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132860AbRDDRSp>; Wed, 4 Apr 2001 13:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132861AbRDDRSf>; Wed, 4 Apr 2001 13:18:35 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:14216 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S132860AbRDDRS2>;
	Wed, 4 Apr 2001 13:18:28 -0400
Importance: Normal
Subject: Re: a quest for a better scheduler
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OFD82F9D22.584E5FF7-ON85256A24.005DB7E0@pok.ibm.com>
From: "Hubertus Franke" <frankeh@us.ibm.com>
Date: Wed, 4 Apr 2001 13:17:38 -0400
X-MIMETrack: Serialize by Router on D01ML244/01/M/IBM(Release 5.0.7 |March 21, 2001) at
 04/04/2001 01:17:40 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well put, this how we can eliminate searching all bins or lists and that's
how we do it under.
http://lse.sourceforge.net/scheduling/2.4.1-pre8-prioSched.

If you have a list per priority level, then you can even pick the first one
you find if its on
the same level. That's what I tried in a more recent implementation. Also
combined that
with using a bitmask to represent non-empty tasks.

Hubertus Franke
Enterprise Linux Group (Mgr),  Linux Technology Center (Member Scalability)
, OS-PIC (Chair)
email: frankeh@us.ibm.com
(w) 914-945-2003    (fax) 914-945-4425   TL: 862-2003



Davide Libenzi <davidel@xmailserver.org>@ewok.dev.mycio.com on 04/04/2001
12:12:54 PM

Sent by:  davidel@ewok.dev.mycio.com


To:   Ingo Molnar <mingo@elte.hu>
cc:   Linus Torvalds <torvalds@transmeta.com>, Alan Cox
      <alan@lxorguk.ukuu.org.uk>, Linux Kernel List
      <linux-kernel@vger.kernel.org>, Hubertus Franke/Watson/IBM@IBMUS,
      Mike Kravetz <mkravetz@sequent.com>, Fabio Riccardi
      <fabio@chromium.com>
Subject:  Re: a quest for a better scheduler




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
> about #1: while right now the prev->mm rule appears to be a tiny issue
(it
> might not affect performance significantly), but forbidding it by
> hardcoding the assumption into data structures is a limitation of
*future*
> goodness() functions. Eg. with the possible emergence of CPU-level
> threading and other, new multiprocessing technologies, this could be a
> *big* mistake.

This is not correct Ingo. I haven't seen the HP code but if You store
processes
in slots S :

S = FS( goodness(p, p->processor, p->mm) )

and You start scanning from the higher slots, as soon as you find a task
with a
goodness G' that is equal to the max goodness in slot You can choose that
process to run.
Again, if You haven't found such a goodness during the slot scan but You've
found a task with a goodness G' :

G' >= SG - DD

where :

SG = max slot goodness
DD = SG(i) - SG(i - 1)

You can select that task as the next to spin.
This was the behaviour that was implemented in my scheduler patch about 2
years
ago.
Beside this, I this that with such loads We've more serious problem to face
with inside the kernel.



- Davide





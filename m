Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292309AbSBUCax>; Wed, 20 Feb 2002 21:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292310AbSBUCao>; Wed, 20 Feb 2002 21:30:44 -0500
Received: from rcpt-expgw.biglobe.ne.jp ([210.147.6.232]:14837 "EHLO
	rcpt-expgw.biglobe.ne.jp") by vger.kernel.org with ESMTP
	id <S292309AbSBUCab>; Wed, 20 Feb 2002 21:30:31 -0500
X-Biglobe-Sender: <k-suganuma@mvj.biglobe.ne.jp>
Date: Wed, 20 Feb 2002 18:29:43 -0800
From: Kimio Suganuma <k-suganuma@mvj.biglobe.ne.jp>
To: Paul Jackson <pj@engr.sgi.com>
Subject: Re: [Lse-tech] Re: [PATCH] O(1) scheduler set_cpus_allowed for non-current tasks
Cc: Erich Focht <focht@ess.nec.de>, Robert Love <rml@tech9.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>, Matthew Dobson <colpatch@us.ibm.com>,
        lse-tech@lists.sourceforge.net
In-Reply-To: <Pine.SGI.4.21.0202201757150.566479-100000@sam.engr.sgi.com>
In-Reply-To: <20020220173242.2BDF.K-SUGANUMA@mvj.biglobe.ne.jp> <Pine.SGI.4.21.0202201757150.566479-100000@sam.engr.sgi.com>
Message-Id: <20020220181141.2BE2.K-SUGANUMA@mvj.biglobe.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.00.05
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 20 Feb 2002 18:04:49 -0800
Paul Jackson <pj@engr.sgi.com> wrote:

> On Wed, 20 Feb 2002, Kimio Suganuma wrote:
> > 
> > CPU hotplug needs to change cpus_allowed in definite time.
> > When a process is sleeping for 100000 seconds, how can we offline
> > a CPU the process belongs?
> 
> Good - I figured I'd hear from you on this - thanks.
> 
> Are you thinking "definite time" on the order of a second?
> I presume you don't require millisecond response time, and that
> minute response time would be too slow, right?

Exactly.

> And just brainstorming ... if a process is sleeping for a long
> time, and the last cpu it executed on is being taken offline,
> what need is there to wake up the process?  Let the process
> stay asleep, and find it a new home when it wakes up for other
> reasons.

In such the case, the waken up process's p->cpu must be changed
by another process or in interrupt, not by itself.
So, we cannot assume that p->cpu, or p->cpus_allowed, must be
changed by itself, right?

> In other words, perhaps  the goal of having the smallest,
> simplest, least intrusive, most clearly correct code is more
> important here than waking up a process just to tell it that
> it's last cpu went offline.

Smallest, simplest and correct...
I wish I could figure out such codes. :(

Regards,
Kimi

-- 
Kimio Suganuma <k-suganuma@mvj.biglobe.ne.jp>


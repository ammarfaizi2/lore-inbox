Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279250AbRKFNle>; Tue, 6 Nov 2001 08:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279264AbRKFNlZ>; Tue, 6 Nov 2001 08:41:25 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:24080 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S279250AbRKFNlT>; Tue, 6 Nov 2001 08:41:19 -0500
Date: Tue, 6 Nov 2001 10:22:02 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrea Arcangeli <andrea@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: out_of_memory() heuristic broken for different mem configurations
In-Reply-To: <20011106143108.6ef304d5.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.21.0111061015190.9867-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 6 Nov 2001, Stephan von Krawczynski wrote:

> On Tue, 6 Nov 2001 09:40:51 -0200 (BRST) Marcelo Tosatti
> <marcelo@conectiva.com.br> wrote:
> 
> > Well, yes, its seems to be just a wrong magic number for this
> > setup/workload.
> 
> Well, first time I read the code I thought that this will happen. Simply think
> of a _slow_ system with _lots_ of mem. Chances are high you cannot match the
> seconds-rule. 
> 
> > Linus, any suggestion to "fix" that ? 
> 
> How about this really stupid idea: oom means allocs fail, so why not simply
> count failed 0-order allocs, if one succeeds, reset counter. If a page is freed
> reset counter. If counter reaches <new magic number> then you're oom. No timing
> involved, which means you can have as much mem or as slow host as you like.

> It isn't even really interesting, if you have swap or not, because a
> failed 0-order alloc tells you whatever mem you have, there is surely
> not much left. 

Wrong. If we have swap available, we are able to swapout anonymous data,
so we are _not_ OOM. This is an important point on this whole OOM killer
nightmare.

Keep in mind that we don't want to destroy anonymous data from userspace
(OOM kill).

> I'd try about 100 as magic number.

I think your suggestion will work well in practice (except that we have to
check the swap).

I'll try that later.

> > /proc tunable (eeek) ? 
> 
> NoNoNo, please don't do that!

Note that even if your suggestion works, we may want to make the magic
value /proc tunable.

The thing is that the point where tasks should be killed is also an admin
decision, not a complete kernel decision.


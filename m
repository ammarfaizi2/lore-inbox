Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262707AbSJaRZb>; Thu, 31 Oct 2002 12:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262712AbSJaRZb>; Thu, 31 Oct 2002 12:25:31 -0500
Received: from nameservices.net ([208.234.25.16]:42729 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S262707AbSJaRZ0>;
	Thu, 31 Oct 2002 12:25:26 -0500
Message-ID: <3DC169FA.86C9D497@opersys.com>
Date: Thu, 31 Oct 2002 12:35:54 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: bob <bob@watson.ibm.com>, Linus Torvalds <torvalds@transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       okrieg@watson.ibm.com, okrieg@us.ibm.com, frankeh@us.ibm.com,
       LTT-Dev <ltt-dev@shafik.org>
Subject: Re: Is your idea good?  [was: Re: LTT for inclusion into 2.5]
References: <Pine.LNX.4.44.0210301823120.1396-100000@home.transmeta.com> <3DC0A01B.15B8B535@opersys.com> <15809.21188.456354.71271@k42.watson.ibm.com> <20021031081921.D27620@work.bitmover.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Larry,

First, thanks for your feedback.

I understand and share you concern about the use of micro-benchmarks
to qualify/quantify the impact additional code on the kernel. This is
precisely the reason why I chose not to use micro-benchmarks in the
Usenix article I presented about LTT at the 2000 annual technical
conference. I was suprised to see some of the selection commitee
members actually come up to me and say: "I'm so glad to see a paper
that doesn't use micro-benchmarks."

That's why we elected to create 2 separate sets of benchmarks, one
using real-life applications (kernel build, bzip2, etc.) and one
using LMbench. Personnally, I would have been satisfied with just the
real-life applications, but I know that many folks on the LKML want
to see LMbench numbers, so we included those too. That said, I find
it very positive that you keep a healthy dose of self-criticism towards
your own tool, this is exactly the kind of stuff that makes LMbench so
good. So too is it with LTT. I've always been on the lookout for
reducing costs here and there while acheiving maximal functionality.

Fortunately, repeated testing and analysis on LTT by many parties
using many tools have confirmed that the current LTT has very low
impact on many fronts, including static code modifications.

So, for example, we had one example run of LMbench where we ran kernel
compiles in the background (i.e. a script restarted the kernel
compile every time it ended). To make it as simple as possible, here's
the elapsed time taken to run LMbench on 4x SMP system in the various
configurations:
---------------------------------------------------------------------
vanilla                         14:27
vanilla+ltt+ltt off             14:26
vanilla+ltt+ltt on              14:31
vanilla+ltt+ltt on+daemon on    14:32

vanilla+ltt+ltt on+kernel compile               15:03
vanilla+ltt+ltt on+kernel compiles+daemon on    15:13
---------------------------------------------------------------------

As you can see, the differences in percentages are all within the 2%
range we mentioned earlier.

To address the specific metrics you mentioned:

>     Code changes:
We've posted diffstats with every patch we published on the LKML.

>     Call depth:
We're talking 3 for syscalls and 2 for all other events in order to
reach the core tracing function proper (this could easily be reduced
by 1 if it's really a problem). Add 1 for locking scheme and 3 for
the non-locking scheme. I'm not counting the calls we make to kernel
services, which somewhat goes to show that this is a flawed measure
because I've never seen any thorough analysis of call depths for
kernel services. Can't say that it wouldn't be an interesting
research project to see someone do that for the entire kernel, we
may find some interesting results.

>     Stack size:
This really depends on the quantity of data being passed to the tracer,
which varies greatly from one event to the other. I can say this, however:
in all the testing I've seen done on LTT in the past, there has never
been a stack problem. This isn't an invitation for being reckless. I am
aware of stack issues and have been on the lookout for the any related
problem.

>     Cache misses:
Bob has said it best. I think the best that we can do about this is
to follow the known-to-be-good guidelines about cache interference.
The discussion Ingo and Bob had on this issue in relation to LTT,
for example, shows that we've thought this through.

Beyond everything I've said above, I'd invite you to download LTT and
try it out. I'm sure you'll see why this is important for Linux users.

BTW, while I'm on the subject of LMbench, I've been trying to find a
way to run it on an embedded system. The problem is that this thing
needs a compiler and that would mean having to cross-compile gcc itself
and so on, which creates storage problems etc. Are there any plans to
make a mini-LMbench?

Thanks again,

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================

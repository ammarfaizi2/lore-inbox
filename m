Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316970AbSGJEMP>; Wed, 10 Jul 2002 00:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317214AbSGJEMO>; Wed, 10 Jul 2002 00:12:14 -0400
Received: from relay04.valueweb.net ([216.219.253.238]:6413 "EHLO
	relay04.valueweb.net") by vger.kernel.org with ESMTP
	id <S316970AbSGJEMN>; Wed, 10 Jul 2002 00:12:13 -0400
Message-ID: <3D2BB505.889304A8@opersys.com>
Date: Wed, 10 Jul 2002 00:16:05 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: John Levon <movement@marcelothewonderpenguin.com>
CC: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@zip.com.au>,
       Andrea Arcangeli <andrea@suse.de>, Rik van Riel <riel@conectiva.com.br>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       linux-kernel@vger.kernel.org, Richard Moore <richardj_moore@uk.ibm.com>,
       bob <bob@watson.ibm.com>
Subject: Re: Enhanced profiling support (was Re: vm lock contention reduction)
References: <Pine.LNX.4.44.0207081039390.2921-100000@home.transmeta.com> <3D29DCBC.5ADB7BE8@opersys.com> <20020710022208.GA56823@compsoc.man.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


John Levon wrote:
> I'm dubious as to the utility of a general tracing mechanism.
...
> I just don't see a really good reason to introduce insidious tracing
> throughout. Both tracing and profiling are ugly ugly things to be doing
> by their very nature, and I'd much prefer to keep such intrusions to a
> bare minimum.

Tracing is essential for an entire category of problems which can only
be solved by obtaining the raw data which describesg the dynamic behavior
of the kernel.

Have you ever tried to solve an inter-process synchronization problem
using strace or gdb? In reality, only tracing built into the kernel can
enable a developer to solve such problems.

Have you ever tried to follow the exact reaction applications have
to kernel input? It took lots of ad-hoc experimentation to isolate the
thundering hurd problem. Tracing would have shown this immediately.

Can you list the exact sequence of processes that are scheduled
in reaction to input when you press the keyboard while running a
terminal in X? This is out of reach of most user-space programmers but
a trace shows this quite nicely.

Ever had a box saturated with IRQs and still showing 0% CPU usage? This
problem has been reported time and again. Lately someone was asking
about the utility which soaks-up CPU cycles to show this sort of
situation. Once more, tracing shows this right away ... without soaking
up CPU cycles.

Ever tried to get the exact time spent by an application in user-space
vs. kernel space? Even better, can you tell the actually syscall which
cost the most in kernel time? You can indeed get closer using random sampling,
but it's just one more thing tracing gives you without any difficulty.

And the list goes on.

The fact that so many kernel subsystems already have their own tracing
built-in (see other posting) clearly shows that there is a fundamental
need for such a utility even for driver developers. If many driver
developers can't develop drivers adequately without tracing, can we
expect user-space developers to efficiently use the kernel if they have
absolutely no idea about the dynamic interaction their processes have
with the kernel and how this interaction is influenced by and influences
the interaction with other processes?

> The entry.S examine-the-registers approach is simple enough, but it's
> not much more tasteful than sys_call_table hackery IMHO

I guess we won't agree on this. From my point of view it is much better
to have the code directly within entry.S for all to see instead of
having some external software play around with the syscall table in a
way kernel users can't trace back to the kernel's own code.

Cheers,

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266886AbTBXMDf>; Mon, 24 Feb 2003 07:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266888AbTBXMDf>; Mon, 24 Feb 2003 07:03:35 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:41477 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S266886AbTBXMDe>;
	Mon, 24 Feb 2003 07:03:34 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200302241213.h1OCDeP343797@saturn.cs.uml.edu>
Subject: Re: [patch] procfs/procps threading performance speedup, 2.5.62
To: procps-list@redhat.com
Date: Mon, 24 Feb 2003 07:13:39 -0500 (EST)
Cc: torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org,
       alexl@redhat.com, viro@math.psu.edu (Alexander Viro), mingo@redhat.com
In-Reply-To: <Pine.LNX.4.44.0302241030350.20254-100000@localhost.localdomain> from "Ingo Molnar" at Feb 24, 2003 10:38:40 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar writes:
> On Sun, 23 Feb 2003, Albert D. Cahalan wrote:

>> The kernel does not provide proper support for grouping threads by
>> process. Hacks exist to group them anyway, but such hacks will falsely
>> group similar tasks and will fail to group tasks due to race conditions.
>> The hacks are also slow. As none of this is acceptable in a critical
>> system tool, task grouping is not currently available.
>
> Albert, here you make the mistake of connecting 'thread directories'
> to 'raceless task state displaying'. There's no such connection,
> and there's no way to get rid of said 'race conditions'.

There are races with serious consequences, and ones without.
That we have race conditions is no excuse to be adding more!
I never did claim that /proc would provide an atomic snapshot.
I don't even claim that the race conditions are because of
your code, but you were passing up an opportunity to fix a few.

As long as there is a way to determine all tasks belonging
to a POSIX process (TIDs in a TGID, or whatever) without
reading damn near everything, then things can be sane.

> here's an offer: propose a sane /proc based mechanism that
> is totally race-free, and i'll implement it. If you think
> that thread-directories solve the races then you are dead wrong.

All or nothing? I would value a few improvements.

Thread directories are one. Alternately, add per-task lists
of tasks with the same VM or a mapping file.

I just went looking for that syscall which was supposed to
allow opening a file relative to a directory file descriptor.
Hmmm, not there. Was that one shot down for some security
concern related to file descriptor passing? It would help
with the process death and PID-wrap-around races at least.

Per-task UUID values could help. Reset one on exec, and one
for every operation that would set an existing ID.

> (Btw., i too would like to see thread directories, and if
> you look at the first NPTL patches you'll see that i've
> proposed them as the superior solution.) This is a hard
> problem, and if you think it's "just" the matter of kernel
> support then you vastly underestimate the complexity involved.

There are many problems, some of which are hard.

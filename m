Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265815AbTBXJ2t>; Mon, 24 Feb 2003 04:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265865AbTBXJ2t>; Mon, 24 Feb 2003 04:28:49 -0500
Received: from mx2.elte.hu ([157.181.151.9]:60577 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S265815AbTBXJ2s>;
	Mon, 24 Feb 2003 04:28:48 -0500
Date: Mon, 24 Feb 2003 10:38:40 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: procps-list@redhat.com
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       <alexl@redhat.com>, Alexander Viro <viro@math.psu.edu>,
       <mingo@redhat.com>
Subject: Re: [patch] procfs/procps threading performance speedup, 2.5.62
In-Reply-To: <200302232151.h1NLp1x260213@saturn.cs.uml.edu>
Message-ID: <Pine.LNX.4.44.0302241030350.20254-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 23 Feb 2003, Albert D. Cahalan wrote:

> The kernel does not provide proper support for grouping threads by
> process. Hacks exist to group them anyway, but such hacks will falsely
> group similar tasks and will fail to group tasks due to race conditions.
> The hacks are also slow. As none of this is acceptable in a critical
> system tool, task grouping is not currently available.

Albert, here you make the mistake of connecting 'thread directories' to
'raceless task state displaying'. There's no such connection, and there's
no way to get rid of said 'race conditions'. There's just no way, and in
fact no desire to get a completely race-free task state from /proc. It's
simply not possible. readdir() and /proc is just fundamentally non-atomic
- i challenge you to show me a single mainstream OS in existence that can
display a completely race-free and accurate snapshot of task state.

here's an offer: propose a sane /proc based mechanism that is totally
race-free, and i'll implement it. If you think that thread-directories
solve the races then you are dead wrong. (Btw., i too would like to see
thread directories, and if you look at the first NPTL patches you'll see
that i've proposed them as the superior solution.) This is a hard problem,
and if you think it's "just" the matter of kernel support then you vastly
underestimate the complexity involved.

	Ingo


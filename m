Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266224AbTBXLQ4>; Mon, 24 Feb 2003 06:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266640AbTBXLQ4>; Mon, 24 Feb 2003 06:16:56 -0500
Received: from mx1.elte.hu ([157.181.1.137]:33709 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S266224AbTBXLQz>;
	Mon, 24 Feb 2003 06:16:55 -0500
Date: Mon, 24 Feb 2003 12:26:19 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: procps-list@redhat.com, Linus Torvalds <torvalds@transmeta.com>,
       <linux-kernel@vger.kernel.org>, <alexl@redhat.com>, <viro@math.psu.edu>
Subject: Re: [patch] procfs/procps threading performance speedup, 2.5.62
In-Reply-To: <200302241112.h1OBCBX273068@saturn.cs.uml.edu>
Message-ID: <Pine.LNX.4.44.0302241214290.22804-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 24 Feb 2003, Albert D. Cahalan wrote:

> By grouping I mean something roughly like this:
> 
> PID TID
> 123 123
> 123 222
> 444 444
> 444 456

Albert, do you realize the simple fact that the procps enhancements we did
change absolutely nothing for the 'ps m' case? All thread PIDs are still
scanned and sorted.

And mind you, thread-directories do not change much in this area - the
PIDs within the thread-directory will still be largely unsorted, and it
will not make the reading & sorting of 20K threads any faster.

> Anyway, to quote Linus:

and to quote myself:

> [...] i'd be the last one arguing against a tree-based approach to
> thread groups. It's much easier to find threads belonging to a single
> 'process' via /proc this way  [...]

so i'm in full agreement with Linus. And here's an email of mine from more 
than 7 months ago:

> and yet another issue, what do you think about not listing every
> CLONE_THREAD_GROUP thread in /proc, but to list them in the group
> leader's directory - something like /proc/12345/threads/567/... This
> will remove much of the runtime overhead of massively threaded
> applications, where there are lots of native threads.

so in fact _i_ came up with this whole issue 7 months ago. I just dont
share many of _your_ largely bogus arguments that seem to miss the point.  
Can we finally stop this storm in a teapot?

	Ingo


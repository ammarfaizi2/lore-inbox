Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263760AbTBXMTY>; Mon, 24 Feb 2003 07:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264844AbTBXMTY>; Mon, 24 Feb 2003 07:19:24 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:4358 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S263760AbTBXMTW>;
	Mon, 24 Feb 2003 07:19:22 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200302241229.h1OCTRF331287@saturn.cs.uml.edu>
Subject: Re: [patch] procfs/procps threading performance speedup, 2.5.62
To: mingo@elte.hu
Date: Mon, 24 Feb 2003 07:29:26 -0500 (EST)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan), procps-list@redhat.com,
       torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org,
       alexl@redhat.com, viro@math.psu.edu
In-Reply-To: <Pine.LNX.4.44.0302241214290.22804-100000@localhost.localdomain> from "Ingo Molnar" at Feb 24, 2003 12:26:19 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Albert, do you realize the simple fact that the procps
> enhancements we did change absolutely nothing for the 'ps m'
> case? All thread PIDs are still scanned and sorted.

That is a contradiction. There is no sorting with "ps m".
Any ordering is from the /proc directory itself.

Sorting is not default because of the memory requirements
and because there have been many kernel bugs that cause
ps to hang when it hits a particular process. Sorting may
mean that ps hangs or is killed before producing anything.

> And mind you, thread-directories do not change much in
> this area - the PIDs within the thread-directory will
> still be largely unsorted, and it will not make the
> reading & sorting of 20K threads any faster.

That's OK. I need in-kernel grouping, not in-kernel sorting.
It's fine to mix up thread order, but bad to interleave the
threads of unrelated processes.

> so in fact _i_ came up with this whole issue 7 months ago. I just dont
> share many of _your_ largely bogus arguments that seem to miss the point.  
> Can we finally stop this storm in a teapot?

Glad to, assuming you understand the importance of grouping.
I hope I have now done a better job of explaining it.

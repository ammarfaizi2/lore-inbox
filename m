Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268146AbUJOQYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268146AbUJOQYI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 12:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268136AbUJOQVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 12:21:32 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:26243 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S268134AbUJOQUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 12:20:12 -0400
Date: Fri, 15 Oct 2004 18:20:00 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Albert Cahalan <albert@users.sf.net>
Cc: Hugh Dickins <hugh@veritas.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton OSDL <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Albert Cahalan <albert@users.sourceforge.net>
Subject: Re: per-process shared information
Message-ID: <20041015162000.GB17849@dualathlon.random>
References: <Pine.LNX.4.44.0410151207140.5682-100000@localhost.localdomain> <1097846353.2674.13298.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097846353.2674.13298.camel@cube>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2004 at 09:19:13AM -0400, Albert Cahalan wrote:
> I don't see why it is such trouble to provide the old data.

I agree with you w.r.t. binary compatibility, here it's even a "source
compatibility" matter, a recompile wouldn't fix it.

However I wasn't exactly advocating to keep it 100% backwards
compatible in this case: somebody already broke it from 2.5.x to
2.6.9-rc, and since there was a very good reason for that, we should
probably declare it broken.  Here there has been a very strong technical
reason to break statm, but they didn't break binary and source
compatibility gratuitously like some solaris kernel developer seems to
think in some blog.

the problem is that when ps xav wants to know the RSS it reads statm,
so we just cannot hurt ps xav to show the "old shared" information that
would be extremely slow to collect.

I was only not happy about dropping the old feature completely instead
of providing it with a different new API. Now I think the solution Hugh
just proposed with the anon_rss should mimic the old behaviour well
enough and it's probably the right way to go, it's still not literally
the same, but I doubt most people from userspace could notice the
difference, and most important it provides useful information, which is
the number of _physical_ pages mapped that aren't anonymous memory, this
is very valuable info and it's basically the same info that people was
getting from the old "shared". So I like it.

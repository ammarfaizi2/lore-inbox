Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270040AbTGPByV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 21:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270047AbTGPByV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 21:54:21 -0400
Received: from code.and.org ([63.113.167.33]:39593 "EHLO mail.and.org")
	by vger.kernel.org with ESMTP id S270040AbTGPByT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 21:54:19 -0400
To: "David Schwartz" <davids@webmaster.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [Patch][RFC] epoll and half closed TCP connections
References: <MDEHLPKNGKAHNMBLJOLKIEFBEGAA.davids@webmaster.com>
From: James Antill <james@and.org>
Content-Type: text/plain; charset=US-ASCII
Date: 15 Jul 2003 22:09:06 -0400
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKIEFBEGAA.davids@webmaster.com>
Message-ID: <m3ptkb2pfh.fsf@code.and.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David Schwartz" <davids@webmaster.com> writes:

> > "David Schwartz" <davids@webmaster.com> writes:
> 
> > > 	This is really just due to bad coding in 'poll', or more
> > > precisely very bad
> > > for this case. For example, why is it allocating a wait queue
> > > buffer if the
> > > odds that it will need to wait are basically zero? Why is it adding file
> > > descriptors to the wait queue before it has determined that it needs to
> > > wait?
> 
> > Because this is much easier to do in userspace, it's just not very
> > well documented that you should almost always call poll() with a zero
> > timeout first.
> 
> 	It's neither easier to do nor harder, it's basically the same code in
> either place. However, doing it in kernel space saves the extra user/kernel
> transition, poll set allocations, and copies across the u/k boundary in the
> case where we do actually need to wait.

 Optimizing for the waiting case doesn't sound like the right
approach, IMO. And all things being equal, doing it outside the kernel
rules.
 Plus it's possible that someone could come up with a case where you
don't want to do it.

> > However it's been there for years, and things have used
> > it[1].
> 
> 	The thing is, for some reason it (it being the cost of calling poll with a
> constant timeout for 1,024 file descriptors) is exceptionally bad on Linux.
> Worse than every other OS I've tested.

 I'd put money on that being drastically reduced if the allocation
didn't happen every call though.

> > There are still optimizations that could have been done to poll() to
> > speed it up but Linus has generally refused to add them.
> 
> 	Yep, so we invent new APIs to fix the deficiencies in the most common API's
> implementation. Whatever.

 No, we know that there are conditions where whatever you do to poll()
the latency kills you. And to fix that we need new APIs. Personally
I'd prefer to have poll() be as good a level triggered event mechanism
as it could be and have epoll just as good for edge triggered events
as it could be ... but I'm not the one you need to convince.

-- 
# James Antill -- james@and.org
:0:
* ^From: .*james@and\.org
/dev/null

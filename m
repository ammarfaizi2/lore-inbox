Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262712AbUCRP4R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 10:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262718AbUCRP4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 10:56:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:33466 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262712AbUCRP4P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 10:56:15 -0500
Date: Thu, 18 Mar 2004 07:55:54 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
cc: Ingo Molnar <mingo@elte.hu>, Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: sched_setaffinity usability
In-Reply-To: <20040318120709.A27841@infradead.org>
Message-ID: <Pine.LNX.4.58.0403180748070.24088@ppc970.osdl.org>
References: <40595842.5070708@redhat.com> <20040318112913.GA13981@elte.hu>
 <20040318120709.A27841@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 18 Mar 2004, Christoph Hellwig wrote:
> 
> Like, umm, the long overdue sysconf()?  For the time beeing a sysctl might
> be the easiest thing..

"sysconf" has not been "long-overdue". It's just that glibc hasn't (after 
years of pleading) just fixed it.

sysconf() MUST NOT be done in kernel space. A lot of the sysconf() options
are pure user space stuff that the kernel has no idea about. Take a quick
look at some of those things, and realize that there are things like
"_SC_EXPR_NEST_MAX" etc that are _most_ of the values. And the kernel is
simply not involved in any of this.

So I will tell this one more time (and I bet I'll have to repeat myself
again in a year or two, and I bet I'll be ignored then too).

sysconf() is a user-level implementation issue, and so is something like
"number of CPU's". Damn, the simplest way to do it is as a environment
variable, for christ sake! Just make a magic environment variable called
__SC_ARRAY, and make it be some kind of binary encoding if you worry about
performance.

Or make a "/etc/sysconf/array" file, and just map it and look up the 
values there.

Please don't raise this issue again.

		Linus

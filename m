Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261604AbVG1QCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbVG1QCm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 12:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbVG1PtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 11:49:04 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:34698 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261577AbVG1Pro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 11:47:44 -0400
Subject: Re: [PATCH] speed up on find_first_bit for i386 (let compiler do
	the work)
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Daniel Walker <dwalker@mvista.com>
In-Reply-To: <Pine.LNX.4.58.0507280823210.3227@g5.osdl.org>
References: <1122473595.29823.60.camel@localhost.localdomain>
	 <1122512420.5014.6.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <1122513928.29823.150.camel@localhost.localdomain>
	 <1122519999.29823.165.camel@localhost.localdomain>
	 <1122521538.29823.177.camel@localhost.localdomain>
	 <1122522328.29823.186.camel@localhost.localdomain>
	 <42E8564B.9070407@yahoo.com.au>
	 <1122551014.29823.205.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0507280823210.3227@g5.osdl.org>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 28 Jul 2005 11:47:19 -0400
Message-Id: <1122565640.29823.242.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-28 at 08:30 -0700, Linus Torvalds wrote:
> 
> I suspect the old "rep scas" has always been slower than 
> compiler-generated code, at least under your test conditions. Many of the 
> old asm's are actually _very_ old, and some of them come from pre-0.01 
> days and are more about me learning the i386 (and gcc inline asm).

I've been playing with different approaches, (still all hot cache
though), and inspecting the generated code. It's not that the gcc
generated code is always better for the normal case. But since it sees
more and everything is not hidden in asm, it can optimise what is being
used, and how it's used.

> 
> That said, I don't much like your benchmarking methodology. I suspect that 
> quite often, the code in question runs from L2 cache, not in a tight loop, 
> and so that "run a million times" approach is not necessarily the best 
> one.

Well, I never said I was a test benchmark writer :-).  If you know of a
better way to benchmark these, then let me know.  I also thought that
having all in a hot cache could help with showing the differences.  But
I guess I would need to test this in other ways.
> 
> I'll apply this one as obvious: I doubt the compiler generates bigger code
> or has any real downsides, but I just wanted to say that in general I just
> wish people didn't always time the hot-cache case ;)

I've just finished a version of find_first_zero_bit too.  It has the
same comparisons as the find_first_bit but not as drastic. Do you want
this too, and if so, as a separate patch on top of the first one, or
against 2.6.12.2 (that's the kernel I'm working with right now) or do
you want me to submit a new patch with both changes?

-- Steve



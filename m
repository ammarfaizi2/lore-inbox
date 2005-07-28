Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261517AbVG1Pea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbVG1Pea (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 11:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVG1Pcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 11:32:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19122 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261567AbVG1Paq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 11:30:46 -0400
Date: Thu, 28 Jul 2005 08:30:08 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Steven Rostedt <rostedt@goodmis.org>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH] speed up on find_first_bit for i386 (let compiler do
 the work)
In-Reply-To: <1122551014.29823.205.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0507280823210.3227@g5.osdl.org>
References: <1122473595.29823.60.camel@localhost.localdomain> 
 <1122512420.5014.6.camel@c-67-188-6-232.hsd1.ca.comcast.net> 
 <1122513928.29823.150.camel@localhost.localdomain> 
 <1122519999.29823.165.camel@localhost.localdomain> 
 <1122521538.29823.177.camel@localhost.localdomain> 
 <1122522328.29823.186.camel@localhost.localdomain>  <42E8564B.9070407@yahoo.com.au>
 <1122551014.29823.205.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 28 Jul 2005, Steven Rostedt wrote:
>
> In the thread "[RFC][PATCH] Make MAX_RT_PRIO and MAX_USER_RT_PRIO
> configurable" I discovered that a C version of find_first_bit is faster
> than the asm version now when compiled against gcc 3.3.6 and gcc 4.0.1
> (both from versions of Debian unstable).  I wrote a benchmark (attached)
> that runs the code 1,000,000 times.

I suspect the old "rep scas" has always been slower than 
compiler-generated code, at least under your test conditions. Many of the 
old asm's are actually _very_ old, and some of them come from pre-0.01 
days and are more about me learning the i386 (and gcc inline asm).

That said, I don't much like your benchmarking methodology. I suspect that 
quite often, the code in question runs from L2 cache, not in a tight loop, 
and so that "run a million times" approach is not necessarily the best 
one.

I'll apply this one as obvious: I doubt the compiler generates bigger code
or has any real downsides, but I just wanted to say that in general I just
wish people didn't always time the hot-cache case ;)

		Linus

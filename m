Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266931AbSLJCDz>; Mon, 9 Dec 2002 21:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266933AbSLJCDz>; Mon, 9 Dec 2002 21:03:55 -0500
Received: from holomorphy.com ([66.224.33.161]:50074 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266931AbSLJCDx>;
	Mon, 9 Dec 2002 21:03:53 -0500
Date: Mon, 9 Dec 2002 18:11:07 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Jim Houston <jim.houston@attbi.com>
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org, george@mvista.com
Subject: Re: [PATCH 3/3] High-res-timers part 3 (posix to hrposix) take 20
Message-ID: <20021210021107.GD9882@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jim Houston <jim.houston@attbi.com>, akpm@digeo.com,
	linux-kernel@vger.kernel.org, george@mvista.com
References: <3DF4B5C1.D36D4CCF@attbi.com> <20021209223515.GC20686@holomorphy.com> <3DF549A3.5D63B4B0@attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DF549A3.5D63B4B0@attbi.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> My original allocator(s) used a radix tree structured bitmap like this
>> in order to provide hard constant time bounds, but statically-allocated
>> them. Static allocation didn't fit in with larger pid space, though.

On Mon, Dec 09, 2002 at 08:55:47PM -0500, Jim Houston wrote:
> Gee Bill, what can I say?  I'm sorry I misattributed your work to Ingo.

Ingo did a large bit of work wrt. mergeability, the for_each_task_pid()
macro, folded the separately allocated idtag structures into the task_t,
redid the pid allocator to handle thelarger spaces, and fixed several
severe bugs, so he should be given due credit. I'd say it was a
collaborative effort, though separated somewhat by the times we
actually worked on it.


On Mon, Dec 09, 2002 at 08:55:47PM -0500, Jim Houston wrote:
> I'm curious about the reaction to recursion.  I use the obvious loop
> for the lookup path, but the allocate and remove cases start getting
> ugly as an iterative solution.

Deep call stacks are not cheap on all arches, ISTR SPARC(64?) and S/390
having some relatively obscene overheads. Going iterative didn't
actually look that bad here, but sleeping etc. for memory weren't in
the picture for me.


Bill

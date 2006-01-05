Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWAEWQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWAEWQG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 17:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbWAEWQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 17:16:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:61642 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750702AbWAEWQD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 17:16:03 -0500
Date: Thu, 5 Jan 2006 14:08:06 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Matt Mackall <mpm@selenic.com>
cc: Martin Bligh <mbligh@mbligh.org>, Arjan van de Ven <arjan@infradead.org>,
       Chuck Ebbert <76306.1226@compuserve.com>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>,
       Tim Schmielau <tim@physik3.uni-rostock.de>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer  compilers
In-Reply-To: <20060105213442.GM3356@waste.org>
Message-ID: <Pine.LNX.4.64.0601051402550.3169@g5.osdl.org>
References: <200601041959_MC3-1-B550-5EE2@compuserve.com> <43BC716A.5080204@mbligh.org>
 <1136463553.2920.22.camel@laptopd505.fenrus.org> <20060105170255.GK3356@waste.org>
 <43BD5E6F.1040000@mbligh.org> <Pine.LNX.4.64.0601051112070.3169@g5.osdl.org>
 <Pine.LNX.4.64.0601051126570.3169@g5.osdl.org> <20060105213442.GM3356@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 5 Jan 2006, Matt Mackall wrote:
> 
> I think it's a mistake to interleave this data into the C source. It's
> expensive and tedious to change relative to its volatility.

I don't believe it is actually all _that_ volatile. Yes, it would be a 
huge issue _initially_, but the incremental effects shouldn't be that big, 
or there is something wrong with the approach.

> What I was proposing was something like, say, arch/i386/popularity.lst, 
> which would simply contain a list of the most popular n% of functions 
> sorted by popularity. As text, of course.

I suspect that would certainlty work for pure function-based popularity, 
and yes, it has the advantage of being simple (especially for something 
that ends up being almost totally separated from the compiler: if we're 
using this purely to modify link scripts etc with special tools).

But what about the unlikely/likely conditional hints that we currently do 
by hand? How are you going to sanely maintain a list of those without 
doing that in source code?

			Linus

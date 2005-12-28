Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964886AbVL1TRi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbVL1TRi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 14:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964882AbVL1TRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 14:17:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45988 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964886AbVL1TRi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 14:17:38 -0500
Date: Wed, 28 Dec 2005 11:17:20 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Matt Mackall <mpm@selenic.com>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
In-Reply-To: <20051228114637.GA3003@elte.hu>
Message-ID: <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org>
References: <20051228114637.GA3003@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 28 Dec 2005, Ingo Molnar wrote:
>
> this patchset (for the 2.6.16 tree) consists of two patches:
> 
>   gcc-no-forced-inlining.patch
>   gcc-unit-at-a-time.patch

Why do you mix the two up? I'd assume they are independent, and if they 
aren't, please explain why?

The forced inlining is not just a good idea. Several versions of gcc would 
NOT COMPILE the kernel without it. The fact that it works with your 
configurations and your particular compiler version has absolutely ZERO 
relevance.

Gcc has had horrible mistakes in inlining functions. Inlining too much, 
and quite often, not inlining things that absolutely _have_ to be inlined. 
Trivial things that inline to an instruction or two, but that look 
complicated because they have a big switch-statement that just happens to 
be known at compile-time.

And not inlining them not only results in horribly bad code (dynamic tests 
for something that should be static), but also results in link errors when 
cases that should be statically unreachable suddenly become reachable 
after all.

So the fact that your gcc-4.x version happens to get things right for your 
case in no way means that you can do this in general.

Also, the inlining patch apparently makes code larger in some cases, so 
it's not even a unconditional win.

What's the effect of _just_ the "unit-at-a-time" thing which we can (and 
you did) much more easily make gcc-version-dependent?

			Linus

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422653AbWJPXEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422653AbWJPXEG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 19:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161159AbWJPXEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 19:04:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23220 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161157AbWJPXED (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 19:04:03 -0400
Date: Mon, 16 Oct 2006 16:04:00 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Simple script that locks up my box with recent kernels
In-Reply-To: <9a8748490610161545i309c416aja4f39edef8ea04e2@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0610161554140.3962@g5.osdl.org>
References: <9a8748490610061636r555f1be4x3c53813ceadc9fb2@mail.gmail.com> 
 <Pine.LNX.4.64.0610062000281.3952@g5.osdl.org> 
 <9a8748490610071402m4450365kedff5615d008fcd5@mail.gmail.com> 
 <Pine.LNX.4.64.0610071408220.3952@g5.osdl.org> 
 <9a8748490610081633k7bf011d1q131b2f9e06f2808d@mail.gmail.com>
 <9a8748490610161545i309c416aja4f39edef8ea04e2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Oct 2006, Jesper Juhl wrote:
>
> Ok, finally got to the end of the bisection (see below; quoting all of
> my previous email since my concerns from that one are still valid).

Ok. It does smell like you marked somethign good that wasn't. That commit 
1db27c11 was the last one you claimed was bad, of course, so it's the one 
git will claim caused it, when you've marked its parent good.

> Where do I go from here?   The problem is still there...    I'll test
> 2.6.19-rc2 tomorrow, but apart from that I don't know how to proceed
> apart from trying to capture a sysrq+t dump when the box locks up...
> any ideas?

Yeah, trying to do sysrq when it locks is probably worth it. As is 
enabling debugging things (netconsole, page-alloc, slab alloc, lockdep 
etc).

But if nothing seems to really give any clues, you might just try 
to restart bisection with

	git bisect reset
	git bisect start
	git bisect good v2.6.17
	git bisect bad 1db27c11

and just run the resulting kernel version for a day or two. If an hour 
wasn't really good enough, it's not as repeatable as we'd have wished, but 
even if it takes a few days to narrow it down by just two bisections or 
so, it will cut things down from ten thousand commits to "just" 2500..

		Linus

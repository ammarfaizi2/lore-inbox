Return-Path: <linux-kernel-owner+willy=40w.ods.org-S281009AbUKBDMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S281009AbUKBDMJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 22:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267382AbUKAW7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 17:59:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:16314 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S274216AbUKAVqh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 16:46:37 -0500
Date: Mon, 1 Nov 2004 13:46:22 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: linux-os@analogic.com
cc: dean gaudet <dean-list-linux-kernel@arctic.org>,
       Andreas Steinmetz <ast@domdv.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Richard Henderson <rth@redhat.com>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, Jan Hubicka <jh@suse.cz>
Subject: Re: Semaphore assembly-code bug
In-Reply-To: <Pine.LNX.4.58.0411011327400.28839@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0411011342090.28839@ppc970.osdl.org>
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org> 
 <417550FB.8020404@drdos.com>  <1098218286.8675.82.camel@mentorng.gurulabs.com>
  <41757478.4090402@drdos.com>  <20041020034524.GD10638@michonline.com> 
 <1098245904.23628.84.camel@krustophenia.net> <1098247307.23628.91.camel@krustophenia.net>
 <Pine.LNX.4.61.0410200744310.10521@chaos.analogic.com>
 <Pine.LNX.4.61.0410290805570.11823@chaos.analogic.com>
 <Pine.LNX.4.58.0410290740120.28839@ppc970.osdl.org> <41826A7E.6020801@domdv.de>
 <Pine.LNX.4.61.0410291255400.17270@chaos.analogic.com>
 <Pine.LNX.4.58.0410291103000.28839@ppc970.osdl.org>
 <Pine.LNX.4.61.0410291424180.4870@chaos.analogic.com>
 <Pine.LNX.4.58.0410291209170.28839@ppc970.osdl.org>
 <Pine.LNX.4.61.0410312024150.19538@chaos.analogic.com>
 <Pine.LNX.4.61.0411011219200.8483@twinlark.arctic.org>
 <Pine.LNX.4.61.0411011542430.24533@chaos.analogic.com>
 <Pine.LNX.4.58.0411011327400.28839@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 1 Nov 2004, Linus Torvalds wrote:
> 
> So can you _please_ just admit that you were wrong? On a P4, the pop/pop 
> is the same cost as lea/pop, and on a Pentium M the pop/pop is faster, 
> according to this test. Your contention that "pop" has to be slower than 
> "lea" is WRONG. 

Btw, I'd like to emphasize "this test". Modern OoO CPU's are complex 
animals. They have pipeline quirks etc that just means that things depend 
on alignment, on code around it, and on register usage patterns of the 
instructions that you test _and_ the instructions around those 
instructions. So take any proof with a pinch of salt, because there are 
bound to be other circumstances where factors around the code just change 
the assumptions.

In short, any time you're looking at single cycle timings, you should be 
very aware of the fact that your measurements are suspect. The best way to 
avoid most of the problem is to never try to measure single cycles. 
Measure performance on a program, not on a single instruction.

			Linus

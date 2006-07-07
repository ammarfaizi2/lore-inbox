Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbWGGWGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbWGGWGb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 18:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbWGGWGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 18:06:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27549 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932340AbWGGWGa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 18:06:30 -0400
Date: Fri, 7 Jul 2006 15:06:10 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
cc: Krzysztof Halasa <khc@pm.waw.pl>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       Linux kernel <linux-kernel@vger.kernel.org>, arjan@infradead.org
Subject: Re: [patch] spinlocks: remove 'volatile'
In-Reply-To: <Pine.LNX.4.64.0607071456430.3869@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0607071500150.3869@g5.osdl.org>
References: <20060705114630.GA3134@elte.hu><20060705101059.66a762bf.akpm@osdl.org><20060705193551.GA13070@elte.hu><20060705131824.52fa20ec.akpm@osdl.org><Pine.LNX.4.64.0607051332430.12404@g5.osdl.org><20060705204727.GA16615@elte.hu><Pine.LNX.4.64.0607051411460.12404@g5.osdl.org><20060705214502.GA27597@elte.hu><Pine.LNX.4.64.0607051458200.12404@g5.osdl.org><Pine.LNX.4.64.0607051555140.12404@g5.osdl.org><20060706081639.GA24179@elte.hu><Pine.LNX.4.61.0607060756050.8312@chaos.analogic.com><Pine.LNX.4.64.0607060856080.12404@g5.osdl.org><Pine.LNX.4.64.0607060911530.12404@g5.osdl.org><Pine.LNX.4.61.0607061333450.11071@chaos.analogic.com>
 <m34pxt8emn.fsf@defiant.localdomain> <Pine.LNX.4.61.0607071535020.13007@chaos.analogic.com>
 <Pine.LNX.4.64.0607071318570.3869@g5.osdl.org> <Pine.LNX.4.61.0607071657580.15580@chaos.analogic.com>
 <Pine.LNX.4.64.0607071456430.3869@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 7 Jul 2006, Linus Torvalds wrote:
> 
> It still makes a difference for code generation, OF COURSE. But it's the 
> wrong thing to use.

And if you don't realize that my argument wasn't "bait-and-switch", it's 
exactly the same thing. You pointed out a place where "volatile" would 
make the code "work".

AND I POINTED OUT THAT EVEN IN YOUR TRIVIAL EXAMPLE, VOLATILE WAS 
ACTUALLY THE WRONG THING TO DO.

And that's _exactly_ because the language environment (in this case the 
CPU itself) has evolved past the point it was 30 years ago.

And my point is that this is _always_ true. There are basically no valid 
uses where you can use "volatile" today, where there isn't some reason why 
you _should_ have done it another way entirely. Either you should have 
used proper locking, or you should have used the proper IO accessor 
functions, or you should have used something like "cpu_relax()", OR ANY 
NUMBER OF OTHER MECHANISMS.

(I did give a few examples of where "volatile" can be valid, but they are 
very limited)

Yes, "volatile" is convenient - at the cost of making the compiler 
generate crap code even when it shouldn't need to. Yes, "volatile" 
sometimes allows you to be lazy and not do the proper thing. Yes, 
"volatile" can hide bugs when you _tried_ to do the proper thing but 
screwed up.

But can't you see that _none_ of those 'Yes, "volatile" ...' actually 
means that you should _use_ "volatile". 

			Linus

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750906AbVLIJfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbVLIJfm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 04:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbVLIJfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 04:35:42 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:28381 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750757AbVLIJfl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 04:35:41 -0500
Date: Fri, 9 Dec 2005 11:29:14 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Matt Mackall <mpm@selenic.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] Reduce number of pointer derefs in various files (kernel/exit.c used as example)
Message-ID: <20051209102914.GA16164@elte.hu>
References: <200512062302.06933.jesper.juhl@gmail.com> <20051206221528.GA12358@elte.hu> <20051209014658.GA11856@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051209014658.GA11856@waste.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Matt Mackall <mpm@selenic.com> wrote:

> > > Ohh, and before I forget, besides the fact that this should speed 
> > > things up a little bit it also has the added benefit of reducing the 
> > > size of the generated code. The original kernel/exit.o file was 19604 
> > > bytes in size, the patched one is 19508 bytes in size.
> > 
> > nice. Just to underline your point, on x86, with gcc 4.0.2, i'm getting 
> > this with your patch:
> > 
> >    text    data     bss     dec     hex filename
> >   11077       0       0   11077    2b45 exit.o.orig
> >   10997       0       0   10997    2af5 exit.o
> > 
> > so 80 bytes shaved off. I think such patches also increase readability.
> 
> Readability improved: good.
> 37 lines of patch for 80-100 bytes saved: not so good.

i'd take a 37 lines readability patch even if it didnt give us a byte of 
text back. The fact that it also reduces text size on the latest gcc in 
rawhide is an added bonus. (of course the patch is 2.6.16 material)

in fact we frequently apply patches that _reduce_ readability but which 
e.g. reduce the number of 'current->' dereferences. (That too is 
something the compiler could figure out.)

also, besides the size reduction effect, this patch is also a 
speed-micro-optimization.

> So while this is a good style direction, I don't think it's worth the 
> churn. And unlike kzalloc and the like, this particular optimization 
> is perfectly doable by a compiler. So I'd rather wait for the compiler 
> to get smarter than change code for such modest improvements.
> 
> FYI, much other low-hanging size-reduction fruit remains in the 
> kernel. Lots of it in the form of duplicate code.

i agree with you that other low-hanging fruits exist, but this does not 
diminish the value of this patch. The patch is obviously correct, it is 
cleaner and improves size and speed. Size reduction alone does not 
necessarily trump cleanliness, but in this particular case all factors 
show towards acceptance.

furthermore, i think that even if it's a small step, we should encourage 
every effort that reduces the kernel's text size. The 2.4 -> 2.6 
transition blew up the kernel by ~50%, and we've got to win back some of 
that. (Kernel size is one of the main disadvantages of Linux in the 
embedded market, compared to other OSs.)

	Ingo

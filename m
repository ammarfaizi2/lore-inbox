Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964851AbVLIS2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbVLIS2q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 13:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964864AbVLIS2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 13:28:46 -0500
Received: from waste.org ([64.81.244.121]:29351 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S964851AbVLIS2p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 13:28:45 -0500
Date: Fri, 9 Dec 2005 10:22:55 -0800
From: Matt Mackall <mpm@selenic.com>
To: Oliver Neukum <oliver@neukum.org>
Cc: Ingo Molnar <mingo@elte.hu>, Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] Reduce number of pointer derefs in various files (kernel/exit.c used as example)
Message-ID: <20051209182255.GQ8637@waste.org>
References: <200512062302.06933.jesper.juhl@gmail.com> <20051206221528.GA12358@elte.hu> <20051209014658.GA11856@waste.org> <200512090914.21436.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512090914.21436.oliver@neukum.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2005 at 09:14:21AM +0100, Oliver Neukum wrote:
> Am Freitag, 9. Dezember 2005 02:46 schrieb Matt Mackall:
> > On Tue, Dec 06, 2005 at 11:15:28PM +0100, Ingo Molnar wrote:
> > > 
> > > * Jesper Juhl <jesper.juhl@gmail.com> wrote:
> > > 
> > > > Ohh, and before I forget, besides the fact that this should speed 
> > > > things up a little bit it also has the added benefit of reducing the 
> > > > size of the generated code. The original kernel/exit.o file was 19604 
> > > > bytes in size, the patched one is 19508 bytes in size.
> > > 
> > > nice. Just to underline your point, on x86, with gcc 4.0.2, i'm getting 
> > > this with your patch:
> > > 
> > >    text    data     bss     dec     hex filename
> > >   11077       0       0   11077    2b45 exit.o.orig
> > >   10997       0       0   10997    2af5 exit.o
> > > 
> > > so 80 bytes shaved off. I think such patches also increase readability.
> > 
> > Readability improved: good.
> > 37 lines of patch for 80-100 bytes saved: not so good.
> > 
> > So while this is a good style direction, I don't think it's worth the
> > churn. And unlike kzalloc and the like, this particular optimization
> > is perfectly doable by a compiler. So I'd rather wait for the compiler
> > to get smarter than change code for such modest improvements.
> 
> How can the compiler do it? If a function call is between two evaluations
> of a pointer chain, the compiler would have to make sure no pointer in
> the chain is touched. For the case of a computed function call, it is
> impossible in principle.

Excellent point. It'd require marking functions const, which might not
be a bad idea.

-- 
Mathematics is the supreme nostalgia of our time.

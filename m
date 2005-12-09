Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932502AbVLIIOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932502AbVLIIOV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 03:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbVLIIOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 03:14:21 -0500
Received: from mail1.kontent.de ([81.88.34.36]:62642 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S932502AbVLIIOU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 03:14:20 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Matt Mackall <mpm@selenic.com>
Subject: Re: [RFC][PATCH] Reduce number of pointer derefs in various files (kernel/exit.c used as example)
Date: Fri, 9 Dec 2005 09:14:21 +0100
User-Agent: KMail/1.8
Cc: Ingo Molnar <mingo@elte.hu>, Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <200512062302.06933.jesper.juhl@gmail.com> <20051206221528.GA12358@elte.hu> <20051209014658.GA11856@waste.org>
In-Reply-To: <20051209014658.GA11856@waste.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512090914.21436.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 9. Dezember 2005 02:46 schrieb Matt Mackall:
> On Tue, Dec 06, 2005 at 11:15:28PM +0100, Ingo Molnar wrote:
> > 
> > * Jesper Juhl <jesper.juhl@gmail.com> wrote:
> > 
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
> 
> So while this is a good style direction, I don't think it's worth the
> churn. And unlike kzalloc and the like, this particular optimization
> is perfectly doable by a compiler. So I'd rather wait for the compiler
> to get smarter than change code for such modest improvements.

How can the compiler do it? If a function call is between two evaluations
of a pointer chain, the compiler would have to make sure no pointer in
the chain is touched. For the case of a computed function call, it is
impossible in principle.

	Regards
		Oliver

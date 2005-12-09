Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750893AbVLIBw1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbVLIBw1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 20:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750901AbVLIBw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 20:52:26 -0500
Received: from waste.org ([64.81.244.121]:21385 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1750885AbVLIBw0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 20:52:26 -0500
Date: Thu, 8 Dec 2005 17:46:59 -0800
From: Matt Mackall <mpm@selenic.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] Reduce number of pointer derefs in various files (kernel/exit.c used as example)
Message-ID: <20051209014658.GA11856@waste.org>
References: <200512062302.06933.jesper.juhl@gmail.com> <20051206221528.GA12358@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051206221528.GA12358@elte.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2005 at 11:15:28PM +0100, Ingo Molnar wrote:
> 
> * Jesper Juhl <jesper.juhl@gmail.com> wrote:
> 
> > Ohh, and before I forget, besides the fact that this should speed 
> > things up a little bit it also has the added benefit of reducing the 
> > size of the generated code. The original kernel/exit.o file was 19604 
> > bytes in size, the patched one is 19508 bytes in size.
> 
> nice. Just to underline your point, on x86, with gcc 4.0.2, i'm getting 
> this with your patch:
> 
>    text    data     bss     dec     hex filename
>   11077       0       0   11077    2b45 exit.o.orig
>   10997       0       0   10997    2af5 exit.o
> 
> so 80 bytes shaved off. I think such patches also increase readability.

Readability improved: good.
37 lines of patch for 80-100 bytes saved: not so good.

So while this is a good style direction, I don't think it's worth the
churn. And unlike kzalloc and the like, this particular optimization
is perfectly doable by a compiler. So I'd rather wait for the compiler
to get smarter than change code for such modest improvements.

FYI, much other low-hanging size-reduction fruit remains in the
kernel. Lots of it in the form of duplicate code.

-- 
Mathematics is the supreme nostalgia of our time.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280656AbRKFXIS>; Tue, 6 Nov 2001 18:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280672AbRKFXIC>; Tue, 6 Nov 2001 18:08:02 -0500
Received: from [195.63.194.11] ([195.63.194.11]:61704 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S280656AbRKFXHr>; Tue, 6 Nov 2001 18:07:47 -0500
Message-ID: <3BE879A0.E06DE631@evision-ventures.com>
Date: Wed, 07 Nov 2001 01:00:32 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Using %cr2 to reference "current"
In-Reply-To: <E161AkQ-0001Fp-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > "get_current" interrupt safe (ie switching tasks is totally atomic, as
> > it's the one single "movl ..,%esp" instruction that does the real switch
> > as far as the kernel is concerned).
> >
> > It does require using an order-2 allocation, which the current VM will
> > allow anyway, but which is obviously nastier than an order-1.
> 
> I've seen boxes dead in the water from 8K NFS (ie 16K order-2 allocations),
> let alone the huge memory hit. Michael's rtlinux approach looks even more
> interesting and I may have to play with that (using the TSS to ident the
> cpu)
> 
> Our memory bloat is already pretty gross in 2.4 without adding 16K task
> stacks to the oversided struct page, bootmem and excess double linked lists.

If we are talking about memmory bload. Let's usk a question. Is somebody
there
working seriously on changing the default function call conventions on
IA32
from stack parameter pushing to register passing throughout the
kernel? The implications on in esp. the I-cache pressure seem to be
quite significant and apparently one of there areas where the GCC got
much better is precisely this. The recent comparisions of gcc against
the intel compiler show as well that this may be really worth it.

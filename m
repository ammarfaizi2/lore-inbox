Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310515AbSCGUjb>; Thu, 7 Mar 2002 15:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310517AbSCGUjZ>; Thu, 7 Mar 2002 15:39:25 -0500
Received: from chaos.analogic.com ([204.178.40.224]:14466 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S310515AbSCGUjL>; Thu, 7 Mar 2002 15:39:11 -0500
Date: Thu, 7 Mar 2002 15:38:09 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
        riel@surriel.com, hch@infradead.org, phillips@bonn-fries.net
Subject: Re: 2.4.19pre2aa1
In-Reply-To: <20020307201819.GF786@holomorphy.com>
Message-ID: <Pine.LNX.3.95.1020307152948.22256A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Mar 2002, William Lee Irwin III wrote:

> On Thu, Mar 07, 2002 at 06:03:00PM +0100, Andrea Arcangeli wrote:
> > For the other points I think you shouldn't really complain (both at
> > runtime and in code style as well, please see how clean it is with the
> > wait_table_t thing), I made a definitive improvement to your code, the
> > only not obvious part is the hashfn but I really cannot see yours
> > beating mine because of the total random input, infact it could be the
> > other way around due the fact if something there's the probability the
> > pages are physically consecutive and I take care of that fine.
> 
> 
> I don't know whose definition of clean code this is:
> 
> +static inline wait_queue_head_t * wait_table_hashfn(struct page * page, wait_table_t * wait_table)
> +{
> +#define i (((unsigned long) page)/(sizeof(struct page) & ~ (sizeof(struct page) - 1)))
> +#define s(x) ((x)+((x)>>wait_table->shift))
> +	return wait_table->head + (s(i) & (wait_table->size-1));
> +#undef i
> +#undef s
> +}
> 
> 
> I'm not sure I want to find out.
> 
> 
> Bill

Methinks there is entirely too much white-space in the code. It
is almost readable *;). It probably could be fixed up to slip through
the compiler with no possibility of human interpretation, but that would
take a bit more work ;^)

The choice of temporaries makes me think of a former President
who, when confronted with a lie, said; "It depends upon what 'is' is!"
Keep up the good work!

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (799.53 BogoMips).

	Bill Gates? Who?


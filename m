Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRAIH2N>; Tue, 9 Jan 2001 02:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129383AbRAIH2E>; Tue, 9 Jan 2001 02:28:04 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:14094 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129267AbRAIH1p>; Tue, 9 Jan 2001 02:27:45 -0500
Date: Mon, 8 Jan 2001 23:27:15 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: zlatko@iskon.hr, Rik van Riel <riel@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: Subtle MM bug
In-Reply-To: <m1wvc5gsad.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.10.10101082322030.1222-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 8 Jan 2001, Eric W. Biederman wrote:

> Zlatko Calusic <zlatko@iskon.hr> writes:> 
> > 
> > Yes, but a lot more data on the swap also means degraded performance,
> > because the disk head has to seek around in the much bigger area. Are
> > you sure this is all OK?
> 
> I don't think we have more data on the swap, just more data has an
> allocated home on the swap.

I think Zlatko's point is that because of the extra allocations, we will
have worse locality (more seeks etc). 

Clearly we should not actually do any more actual IO. But the sticky
allocation _might_ make the IO we do be more spread out.

To offset that, I think the sticky allocation makes us much better able to
handle things like clustering etc more intelligently, which is why I think
it's very much worth it.  But let's not close our eyes to potential
downsides.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

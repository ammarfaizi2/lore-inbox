Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S159809AbRA2HWo>; Mon, 29 Jan 2001 02:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S159825AbRA2HWf>; Mon, 29 Jan 2001 02:22:35 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:41477 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S159809AbRA2HWY>; Mon, 29 Jan 2001 02:22:24 -0500
Date: Sun, 28 Jan 2001 23:21:53 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Aaron Tiensivu <mojomofo@mojomofo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: PCI IRQ routing problem in 2.4.0 (SiS results part 2)
In-Reply-To: <004e01c089c2$a3a11ec0$0300a8c0@methusela>
Message-ID: <Pine.LNX.4.10.10101282318402.5605-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 29 Jan 2001, Aaron Tiensivu wrote:
> | Which one was it you got a PIRQ conflict for before? as it te device at
> | 00:01.00 with the strange "0x62" entry?
> 
> Yes.

You've got the pirq setup from hell.

Mind doing that "dump_pirq" thing, preferably run on an _unmodified_ 2.4.0
kernel (ie none of my test-hacks) or on a 2.2.x kernel (that doesn't even
_try_ to do any routing at all - or you can get the same effect by just
making "set_sis_pirq()" always just return 0 without doing anything)?

I don't want to get quantum effects of the observer changing what is being
observed..

> | How about you try adding the line
> | pirq = (pirq-1) & 3;
> | at the top of both pirq_sis_get() and pirq_sis_set() (with my "alternate"
> | SiS routines). What happens then?
> 
> Done.

Not any better. The thing just moves around, it seems.

I'll think about this, and try to find the SiS irq routing register spec
somewhere..

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

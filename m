Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S145262AbRA2Fv7>; Mon, 29 Jan 2001 00:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S145277AbRA2Fvu>; Mon, 29 Jan 2001 00:51:50 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:20499 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S145262AbRA2Fvm>; Mon, 29 Jan 2001 00:51:42 -0500
Date: Sun, 28 Jan 2001 21:50:15 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Aaron Tiensivu <mojomofo@mojomofo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: PCI IRQ routing problem in 2.4.0 (SiS results)
In-Reply-To: <000b01c089b4$7e0aa7c0$0300a8c0@methusela>
Message-ID: <Pine.LNX.4.10.10101282143570.5509-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 29 Jan 2001, Aaron Tiensivu wrote:
> 
> My ASUS SP97-V complains about PIRQ conflicts so I gave this a whirl
> (It is SiS 5598 based)

Your pirq values are different - they are in the 0x41-0x44 range, like the
old SiS router code assumes. Except for one that has value 0x62, which the
old SiS code actually refused to set because it refused anything that
matches (x & 0x20).

I suspect that the low bits are the "PCI interrupt number", and that the
high bits are some other state information. (ie 0x02, 0x42 and 0x62 all
imply PCI irq INTB, just with different flags set for some reason).

Which one was it you got a PIRQ conflict for before? as it te device at
00:01.00 with the strange "0x62" entry?

How about you try adding the line

	pirq = (pirq-1) & 3;

at the top of both pirq_sis_get() and pirq_sis_set() (with my "alternate"
SiS routines). What happens then?

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

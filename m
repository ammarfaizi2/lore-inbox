Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317262AbSFLCZP>; Tue, 11 Jun 2002 22:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317309AbSFLCZO>; Tue, 11 Jun 2002 22:25:14 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:48134 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317262AbSFLCZN>; Tue, 11 Jun 2002 22:25:13 -0400
Date: Tue, 11 Jun 2002 19:25:27 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Peter Chubb <peter@chubb.wattle.id.au>
cc: linux-kernel@vger.kernel.org, <hermes@gibson.dropbear.id.au>,
        <alan@lxorguk.ukuu.org.uk>
Subject: Re: yenta_socket driver PCI irq routing fix
In-Reply-To: <15622.44011.587251.752252@wombat.chubb.wattle.id.au>
Message-ID: <Pine.LNX.4.44.0206111914210.32482-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 12 Jun 2002, Peter Chubb wrote:
>
> The symptoms were that no interupts were ever received from the card;
> the BIOS reported it had assigned INTA to IRQ 10; but the yenta
> driver reported IRQ 17.

Looks reasonable. It probably _was_ on IRQ10 with the serial irq, but
since we try to figure out the PCI irq routing (which we have to do in
general, since there are no good alternatives available to us), we got the
true PCI irq.

An even better solution _might_ be to just detect when the chip is set up
for serial irq, pick up the irq from there, and use that for the card
events and 16-bit stuff (while the INTA line is used for the actual PCI
interrupts off a cardbus card). That gives potentially nicer interrupt
distribution.

Would you mind looking into that approach? I've applied your patch to
2.5.x, but judging by the patch you _do_ understand the problem well
enough that I think you'd get the alternate solution going too, and it
would get you better interrupt performance for the cardbus cards you
connect. AND it would be nice to have alternate approaches in case
somebody has problems with this one.

(That said, I just cannot imagine how you could not hook up the INTA/B
lines correctly, and still have a working setup. So this approach of just
forcing the use of INTA and ignoring the old ISA serial interrupt should
be quite robust as far as I can tell).

Any other TI 1410 users out there? Oh, and 1250 users too, since ti
appears you made this happen for that chip too.. (Not that I disagree)

		Linus


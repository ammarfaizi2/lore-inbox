Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129636AbQLGC7K>; Wed, 6 Dec 2000 21:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129640AbQLGC7A>; Wed, 6 Dec 2000 21:59:00 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:523 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129636AbQLGC6v>; Wed, 6 Dec 2000 21:58:51 -0500
Date: Wed, 6 Dec 2000 18:27:56 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Miles Lane <miles@megapathdsl.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: The horrible hack from hell called A20
In-Reply-To: <3A2EBF17.9010509@megapathdsl.net>
Message-ID: <Pine.LNX.4.10.10012061814020.7391-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Dec 2000, Miles Lane wrote:
> 
> Here is what goes wrong:
> 
> Dec  6 04:21:32 agate kernel: eth0: Host error, FIFO diagnostic register  0000.

But it continues to work, right?

I bet that your ethernet card is just unhappy that it couldn't get DMA in
time, because the bus was so busy. Many of the busmastering ethernet
devices will start the packet send early, happy in the knowledge that
they'll usually have plenty of time to DMA the data by the time they need
it.

This works fine most of the time, but if you have a busy PCI bus and
you're doing things over a (potentially slow) PCI bridge like the Cardbus
bridge, you're taking chances. And sometimes those chances do not work out
ok.. Especially if you have slow memory, which most laptops have.

I suspect that the worst result of this is just a noisy driver: both on
the network (runt packets) and on the console. And it obviously will cause
performance to suffer too, due to retransmitting packets that failed,
and/or losing packets.

There may be some rule for the threshold for sending packets or something
else to make this happen less, so this is probably tweakable. But it
doesn't sound deadly (unless the driver causes this to result in a dead
network - does it?)

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

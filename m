Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129994AbQKNBtQ>; Mon, 13 Nov 2000 20:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130031AbQKNBtH>; Mon, 13 Nov 2000 20:49:07 -0500
Received: from vp175103.reshsg.uci.edu ([128.195.175.103]:60422 "EHLO
	moisil.dev.hydraweb.com") by vger.kernel.org with ESMTP
	id <S129994AbQKNBs7>; Mon, 13 Nov 2000 20:48:59 -0500
Date: Mon, 13 Nov 2000 17:18:56 -0800
Message-Id: <200011140118.eAE1IuV17166@moisil.dev.hydraweb.com>
From: Ion Badulescu <ionut@moisil.cs.columbia.edu>
To: David Hinds <dhinds@valinux.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: Pcmcia/Cardbus/xircom_tulip in 2.4.0-test10.
In-Reply-To: <20001113121833.A1725@valinux.com>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.2.18pre21 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Nov 2000 12:18:33 -0800, David Hinds <dhinds@valinux.com> wrote:

> The effect of "ifconfig eth0 -multicast" (which should be a no-op) is
> that it calls set_rx_mode() with the same set of parameters it was
> called with before.  Doing this one or more times may kick the card so
> that it starts working.  The number of times is constant for a given
> network configuration, and varies between 0 and 3.

If you want another datapoint, this doesn't help on my own Xircom card.
The only way to make it receive packets while not in promisc mode was
to add back the "+ 4" to the buffer address in the descriptor -- reverting
one of the changes that went into 3.1.21.

Anything else I've tried didn't help: filling up all slots with my MAC,
adding them at the end of the list, at the beginning, as little/big endian,
in reverse order... you name it. The "+ 4" however made it work reliably.

The card is a Xircom RealPort CardBus Ethernet 10/100, code RBE-100. This
is the lspci entry for it:

20:00.0 Class 0200: 115d:0003 (rev 03)
        Subsystem: 115d:0181
        Flags: bus master, medium devsel, latency 64, IRQ 11
        I/O ports at 0200
        Memory at a000d000 (32-bit, non-prefetchable)
        Memory at a000c000 (32-bit, non-prefetchable)
        Expansion ROM at a0008000 [disabled]
        Capabilities: [dc] Power Management version 1

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

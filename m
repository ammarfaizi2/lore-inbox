Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132707AbRDIJEa>; Mon, 9 Apr 2001 05:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132709AbRDIJET>; Mon, 9 Apr 2001 05:04:19 -0400
Received: from t2.redhat.com ([199.183.24.243]:22524 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S132707AbRDIJEH>; Mon, 9 Apr 2001 05:04:07 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.30.0104081846460.16728-100000@mackman.net> 
In-Reply-To: <Pine.LNX.4.30.0104081846460.16728-100000@mackman.net> 
To: Ryan Mack <rmack@mackman.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [QUESTIONS] Transision from pcmcia-cs to 2.4 built-in PCMCIA 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 09 Apr 2001 10:04:00 +0100
Message-ID: <12964.986807040@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


rmack@mackman.net said:
>  First, why have I stopped needing cs and cb_enabler?

cs is built into pcmcia_core.o, cb_enabler should still be there though. 
It's feasible that you only need cb_enabler for the old CardBus drivers, 
though - I'm not sure.

> Second, why is yenta_socket only compiled if I enable CardBus support
> in the kernel?  I'm running an Orinoco card on another machine, and
> since I don't think it's CardBus (am I wrong?), I didn't enable CB in
> the kernel. The i82365 driver is the only one compiled, but it seems
> to work fine on that machine.  Should I enable CardBus support and use
> yenta_socket instead?

yenta_socket is the driver for CardBus i82365-compatible sockets.
i82365 no longer drives CardBus sockets, only PCMCIA.

> Third, on the first machine with both cards, neither card works if I
> use i82365 instead of yenta_socket, why?  The Orinoco gets Tx timeouts
> on every packet, and inserting the 3c595 causes the controller
> (socket) to time out waiting for reset and it doesn't recognize the
> 3c595.

The PCMCIA card ought to work. It's probably screwed up the IRQ routing - 
it no longer knows about some of the differences between CardBus and PCMCIA 
bridges. What exactly is the bridge in this machine?

--
dwmw2



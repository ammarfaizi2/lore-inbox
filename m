Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129652AbRBUWXh>; Wed, 21 Feb 2001 17:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129674AbRBUWX2>; Wed, 21 Feb 2001 17:23:28 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:41485 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129652AbRBUWXO>; Wed, 21 Feb 2001 17:23:14 -0500
Subject: Re: Very high bandwith packet based interface and performance problems
To: nyet@curtis.curtisfong.org (Nye Liu)
Date: Wed, 21 Feb 2001 22:25:54 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010221141157.A8457@curtis.curtisfong.org> from "Nye Liu" at Feb 21, 2001 02:11:57 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Vhhu-0002tn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I can think of a couple possible solutions. our interface has a HUGE
> amount of hardware buffers, so I can easily simply stop reading for
> a small time if we detect conjestion... can you suggest a nice clean
> mechanism for this?

If you have a lot of buffers you can try one thing to see if its IRQ load,
turn the IRQ off, set a fast timer running and hook the buffer handling to
the timer irq.

Next obvious step would be using the timer based irq handling to limit the
number of buffers you use netif_rx() on and discard any others.

Finally don't rule out memory bandwidth, if the ram is main memory then the
dma engine could be pretty much driving the cpu off the bus  at high data
rates.

Alan


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265439AbRFVPXl>; Fri, 22 Jun 2001 11:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265442AbRFVPXb>; Fri, 22 Jun 2001 11:23:31 -0400
Received: from geos.coastside.net ([207.213.212.4]:2191 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S265439AbRFVPXU>; Fri, 22 Jun 2001 11:23:20 -0400
Mime-Version: 1.0
Message-Id: <p05100303b759128e0e65@[207.213.214.37]>
In-Reply-To: <070001c0fb22$69d68460$294b82ce@connecttech.com>
In-Reply-To: <Pine.LNX.4.21.0106220846150.11538-100000@schoen3.schoen.nl>
 <070001c0fb22$69d68460$294b82ce@connecttech.com>
Date: Fri, 22 Jun 2001 08:23:08 -0700
To: "Stuart MacDonald" <stuartm@connecttech.com>, "kees" <kees@schoen.nl>,
        <linux-kernel@vger.kernel.org>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: Q serial.c
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 9:51 AM -0400 2001-06-22, Stuart MacDonald wrote:
>From: "kees" <kees@schoen.nl>
>>  What may happen on a SMP machine if a serial port has been closed and the
>>  closing stage is at shutdown() in serial.c in the call to free_IRQ  and
>>  BEFORE the IRQ is really shutdown, a new character arrives which causes an
>>  IRQ? Is it possible that the OTHER cpu  takes this interrupt and causes a
>>  crash?
>
>I'm looking at serial-5.05/serial.c. You'll notice at the
>beginning of shutdown the saveflags(); cli(); calls.
>This disables interrupts. The uart will not be able to
>generate IRQs even if new characters arrive.

The other CPU servicing the interrupt, was the question. cli() 
doesn't affect that. This could presumably happen if shutdown() gets 
run on a non-interrupt-servicing CPU, or if interrupts are 
dynamically routed (eg round-robin).

Where can I find the 5.05 driver?
-- 
/Jonathan Lundell.

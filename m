Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129339AbQKHSk4>; Wed, 8 Nov 2000 13:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129470AbQKHSkq>; Wed, 8 Nov 2000 13:40:46 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:59626 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S129339AbQKHSk3>;
	Wed, 8 Nov 2000 13:40:29 -0500
Date: Wed, 8 Nov 2000 10:20:42 -0800
From: Jean Tourrilhes <jt@spica.hpl.hp.com>
To: Dag Brattli <dagb@fast.no>
Cc: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk, jgarzik@mandrakesoft.com,
        linux-kernel@vger.rutgers.edu
Subject: Re: [RANT] Linux-IrDA status
Message-ID: <20001108102042.A24811@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <Pine.LNX.4.10.10011072027520.15254-100000@penguin.transmeta.com> <200011081204.MAA68767@tepid.osl.fast.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <200011081204.MAA68767@tepid.osl.fast.no>; from dagb@fast.no on Wed, Nov 08, 2000 at 12:04:05PM +0000
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2000 at 12:04:05PM +0000, Dag Brattli wrote:
> 
> Hi,
> 
> It was implemented this way because the IrDA device drivers are implemented
> like normal network device drivers and didn't want to mess with struct netdevice
> in order to change the speed of the driver. I decided to use ioctl since it had to
> be possible to do this from user-space (sniffers) as well as from the IrDA stack. 
> The only thing the IrDA stack knows about is the netdevice. Some frames we
> receive will trigger a speed change which we must handle from within the
> stack (so it's inside the bh and not actually in the "hard" interrupt)
> 
> What do you suggest I do?
> 
> 1. Add a change_speed() function to struct netdevice
> 2. Add a protocol specific pointer to struct netdevice
> 3. Embed the speed in skb->cb and send down empty frames
>     when I want to change the speed without transmitting anything.
> 4. Anything else?

	If somebody tell us which is the "right way", I'll try to code
that ASAP. We take any feedback very seriously ;-)
	I personally would go with #1, because "struct netdevice" is
full of protocol specific stuff anyway... And if we do our job right,
it can be reused for other stuff.

	Any comments ?

> -- Dag

	Jean
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266710AbRGKOtK>; Wed, 11 Jul 2001 10:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267326AbRGKOtB>; Wed, 11 Jul 2001 10:49:01 -0400
Received: from age.cs.columbia.edu ([128.59.22.100]:24328 "EHLO
	age.cs.columbia.edu") by vger.kernel.org with ESMTP
	id <S266710AbRGKOso>; Wed, 11 Jul 2001 10:48:44 -0400
Date: Wed, 11 Jul 2001 07:48:38 -0700 (PDT)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Juri Haberland <juri@koschikode.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] starfire net driver update
In-Reply-To: <20010711143310.26965.qmail@babel.spoiled.org>
Message-ID: <Pine.LNX.4.33.0107110739310.16147-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Jul 2001, Juri Haberland wrote:

> This patch breaks my starfire totally:

That's very weird. I really don't see how that could be the result of my 
latest changes.

> With 2.4.6 on a 100Mbit HUB (100fx-HD) it receives but seems to have problems
> to send.

Right, that's the problem I was trying to fix. Basically it was unable to 
send small packets, because the padding was disabled and it would only 
get enabled if the card negotiated a connection other than 100-HD.

> With 2.4.6 and your patch I get the following immediately:
> kernel: NETDEV WATCHDOG: eth5: transmit timed out
> kernel: eth5: Transmit timed out, status 00000000, resetting...

Ok. Can you send me the other stuff the driver prints, especially the line 
speed/duplex detection?

Also, if you feel adventurous, search for these lines in the driver:
        /* Configure the PCI bus bursts and FIFO thresholds. */
        np->tx_mode = 0x0C04;           /* modified when link is up. */
*       writel(0x8000 | np->tx_mode, ioaddr + TxMode);
*       writel(np->tx_mode, ioaddr + TxMode);

and comment out those two marked with a *. At that point you should have 
essentially the 2.4.6 driver, so see if they behaves similarly.

I'll also test it myself when I get home.

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.


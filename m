Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266718AbRGKPQz>; Wed, 11 Jul 2001 11:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266725AbRGKPQg>; Wed, 11 Jul 2001 11:16:36 -0400
Received: from babel.spoiled.org ([212.84.234.227]:33820 "HELO
	babel.spoiled.org") by vger.kernel.org with SMTP id <S266718AbRGKPQ3>;
	Wed, 11 Jul 2001 11:16:29 -0400
Date: 11 Jul 2001 15:16:30 -0000
Message-ID: <20010711151630.7597.qmail@babel.spoiled.org>
From: Juri Haberland <juri@koschikode.com>
To: ionut@cs.columbia.edu (Ion Badulescu)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] starfire net driver update
X-Newsgroups: spoiled.linux.kernel
In-Reply-To: <Pine.LNX.4.33.0107110739310.16147-100000@age.cs.columbia.edu>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (OpenBSD/2.9 (i386))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33.0107110739310.16147-100000@age.cs.columbia.edu> you wrote:
> On 11 Jul 2001, Juri Haberland wrote:
> 
>> This patch breaks my starfire totally:
> 
> That's very weird. I really don't see how that could be the result of my 
> latest changes.
> 
>> With 2.4.6 on a 100Mbit HUB (100fx-HD) it receives but seems to have problems
>> to send.
> 
> Right, that's the problem I was trying to fix. Basically it was unable to 
> send small packets, because the padding was disabled and it would only 
> get enabled if the card negotiated a connection other than 100-HD.
> 
>> With 2.4.6 and your patch I get the following immediately:
>> kernel: NETDEV WATCHDOG: eth5: transmit timed out
>> kernel: eth5: Transmit timed out, status 00000000, resetting...
> 
> Ok. Can you send me the other stuff the driver prints, especially the line 
> speed/duplex detection?

kernel: starfire.c:v1.03 7/26/2000  Written by Donald Becker <becker@scyld.com>
kernel:  Updates and info at http://www.scyld.com/network/starfire.html
kernel:  (unofficial 2.2/2.4 kernel port, version 1.03+LK1.3.3, July 05, 2001)
kernel: eth2: Adaptec Starfire 6915 at 0xc8800000, 00:00:d1:ee:8a:c5, IRQ 15.
kernel: eth2: MII PHY found at address 1, status 0x7809 advertising 01e1.
kernel: eth3: Adaptec Starfire 6915 at 0xc8881000, 00:00:d1:ee:8a:c6, IRQ 14.
kernel: eth3: MII PHY found at address 1, status 0x7809 advertising 01e1.
kernel: eth4: Adaptec Starfire 6915 at 0xc8902000, 00:00:d1:ee:8a:c7, IRQ 11.
kernel: eth4: MII PHY found at address 1, status 0x7809 advertising 01e1.
kernel: eth5: Adaptec Starfire 6915 at 0xc8983000, 00:00:d1:ee:8a:c8, IRQ 10.
kernel: eth5: MII PHY found at address 1, status 0x7809 advertising 01e1.

I couldn't find any other infos related to the starfire. Unfortunately I
cannot reboot the machine today anymore; this must wait until tomorrow.

> Also, if you feel adventurous, search for these lines in the driver:
>         /* Configure the PCI bus bursts and FIFO thresholds. */
>         np->tx_mode = 0x0C04;           /* modified when link is up. */
> *       writel(0x8000 | np->tx_mode, ioaddr + TxMode);
> *       writel(np->tx_mode, ioaddr + TxMode);
> 
> and comment out those two marked with a *. At that point you should have 
> essentially the 2.4.6 driver, so see if they behaves similarly.

I'll try that tomorrow.

Juri

-- 
Juri Haberland  <juri@koschikode.com> 


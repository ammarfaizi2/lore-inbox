Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267621AbRG3T3Y>; Mon, 30 Jul 2001 15:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267585AbRG3T3O>; Mon, 30 Jul 2001 15:29:14 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:4876 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S267518AbRG3T3D>; Mon, 30 Jul 2001 15:29:03 -0400
Message-Id: <200107301929.f6UJT5I20640@aslan.scsiguy.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: mason@suse.com, linux-kernel@vger.kernel.org
Subject: Re: BUG at smp.c:481, 2.4.8-pre2 
In-Reply-To: Your message of "Mon, 30 Jul 2001 10:33:08 PDT."
             <200107301733.f6UHX8H01494@penguin.transmeta.com> 
Date: Mon, 30 Jul 2001 13:29:05 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

>In article <296370000.996508500@tiny> you write:
>>
>>Ok, During boot on 2.4.8-pre2 I'm getting this oops just as it starts to
>>probe my aic7890 card.  Andrea is cc'd because I'm guessing it is due to
>>one of his patches ;-)
>
>It's a sanity check, which I removed (because it's worse to panic in a
>2.4.x kernel than it is to have the sanity problem). But the sanity
>check does show that there is some problem in ahc_pci_map_registers():
>it calls "ioremap()" with interrupts disabled, which is rather broken.
>
>I don't know that driver well enough to understand why the heck it would
>keep interrupts disabled over apparently a _long_ stretch of time during
>probing. The irq disable code seems to be somewhere else..
>
>Justin?

At least in 6.2.0, interrupts are not disabled at all during the probe.
In fact the driver doesn't explicitly disable interrupts ever other
than by way of taking a spinlock.  No spinlocks are held during this
portion of the probe.  Instead, we disable the interrupt line on the card,
and don't enable it until the probe is complete.  I haven't yet checked in
6.1.13, but this hasn't changed in a long time.  I'd be surprised if the
behavior is any different.  Perhaps interrupts are disabled higher in
the food chain?

--
Justin

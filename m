Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266662AbRG3TM4>; Mon, 30 Jul 2001 15:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267241AbRG3TMo>; Mon, 30 Jul 2001 15:12:44 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:2312 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266662AbRG3TMc>; Mon, 30 Jul 2001 15:12:32 -0400
From: Linus Torvalds <torvalds@transmeta.com>
Date: Mon, 30 Jul 2001 10:33:08 -0700
Message-Id: <200107301733.f6UHX8H01494@penguin.transmeta.com>
To: mason@suse.com, linux-kernel@vger.kernel.org,
        "Justin T. Gibbs" <gibbs@scsiguy.com>
Subject: Re: BUG at smp.c:481, 2.4.8-pre2
Newsgroups: linux.dev.kernel
In-Reply-To: <296370000.996508500@tiny>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

In article <296370000.996508500@tiny> you write:
>
>Ok, During boot on 2.4.8-pre2 I'm getting this oops just as it starts to
>probe my aic7890 card.  Andrea is cc'd because I'm guessing it is due to
>one of his patches ;-)

It's a sanity check, which I removed (because it's worse to panic in a
2.4.x kernel than it is to have the sanity problem). But the sanity
check does show that there is some problem in ahc_pci_map_registers():
it calls "ioremap()" with interrupts disabled, which is rather broken.

I don't know that driver well enough to understand why the heck it would
keep interrupts disabled over apparently a _long_ stretch of time during
probing. The irq disable code seems to be somewhere else..

Justin?

		Linus

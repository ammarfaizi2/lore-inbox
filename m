Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288661AbSA0UZh>; Sun, 27 Jan 2002 15:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288685AbSA0UZ2>; Sun, 27 Jan 2002 15:25:28 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:7434 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288671AbSA0UZR>; Sun, 27 Jan 2002 15:25:17 -0500
Subject: Re: Preempt & how long it takes to interrupt (was Re: [2.4.17/18pre] VM and swap - it's really unusable)
To: landley@trommello.org (Rob Landley)
Date: Sun, 27 Jan 2002 20:37:19 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), pavel@suse.cz (Pavel Machek),
        helgehaf@aitel.hist.no (Helge Hafting), linux-kernel@vger.kernel.org
In-Reply-To: <20020122195437.LDTC21740.femail36.sdc1.sfba.home.com@there> from "Rob Landley" at Jan 22, 2002 06:52:29 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Uw3D-0002bm-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >carefully disables an IRQ on the card so that it can avoid spinlocking on 
> >uniprocessor boxes.
> 
> Sounds like a bit of a kludge, but it's not my code.  However, without 
> preempt aren't spinlocks basically NOPs on uniprocessor boxes?  What did I 
> miss?

spin lock is a nop on uniprocessor. That is much of the point of this. Most
ne2000's are in uniprocessor boxes so they are primary target

> An NE2K cannot go faster than 10baseT.  (Never designed to.  It's an old ISA 

Wrong. There are multiple 100Mbit NE2000 clones (notably PCMCIA ones). I
have one in my laptop for example.

> testing the patch complaining about, AND one that seems like it could be 
> addressed by using IRQ disabling as a latency guard in addition to spinlocks.

I dont believe anyone has tested the driver hard with pre-empt. Its not that
this driver can't be fixed. Its that this is one tiny example of maybe 
thousands of other similar flaws lurking. There is no obvious automated way
to find them either.

> If it's holding the lock for several miliseconds, the overhead of acquiring 
> the lock in the first place isn't exactly a show-stopper, is it?

I don't hold the lock with interrupts off for several milliseconds

Alan

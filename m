Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286297AbSAMPvt>; Sun, 13 Jan 2002 10:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286316AbSAMPvk>; Sun, 13 Jan 2002 10:51:40 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:47623 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286297AbSAMPva>; Sun, 13 Jan 2002 10:51:30 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
To: landley@trommello.org (Rob Landley)
Date: Sun, 13 Jan 2002 16:03:13 +0000 (GMT)
Cc: zippel@linux-m68k.org (Roman Zippel), alan@lxorguk.ukuu.org.uk (Alan Cox),
        arjan@fenrus.demon.nl, linux-kernel@vger.kernel.org
In-Reply-To: <20020113070906.OUZZ28486.femail48.sdc1.sfba.home.com@there> from "Rob Landley" at Jan 12, 2002 06:07:10 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Pn6H-0007Ij-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Obvioiusly, Alan, you know more about the networking stack than I do. :)  But 
> could you define "large periods of time running other code"?

10ths of a second if there is a lot to let run instead of this thread. Even
1/100th is bad news. 

> There ISN'T an upper bound on interrupts.  We've got some nasty interrupts in 
> the system.  How long does the PCI bus get tied up with spinning video cards 
> flooding the bus to make their benchmarks look 5% better?  How long of a 

They dont flood the bus with interrupts, the lock the bus off for several
millseconds worst case. Which btw you'll note means that lowlatency already
achieves the best value you can get

> latency spike did we (until recently) get switching between graphics and text 
> consoles?  (I heard that got fixed, moved into a tasklet or some such.  
> Haven't looked at it yet.)  Without Andre's IDE patches, how much latency can 

Been fixed in -ac for ages, and finally made Linus tree.

> the disk insert at random?

IDE with or without Andre's changes can insert multiple millisecond delays
on the bus in some situations. Again pre-empt patch can offer you nothing 
because the hardware limit is easily met by low latency

> One other fun little thing about the scheduler: a process that is submitting 
> network packets probably isn't entirely CPU bound, is it?  It's doing I/O.  

Network packets get submitted from _outside_

Alan

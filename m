Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S155989AbPF2Bzy>; Mon, 28 Jun 1999 21:55:54 -0400
Received: by vger.rutgers.edu id <S155482AbPF2Bj4>; Mon, 28 Jun 1999 21:39:56 -0400
Received: from mole.slip.net ([207.171.193.16]:44194 "EHLO mole.slip.net") by vger.rutgers.edu with ESMTP id <S155600AbPF2BLJ>; Mon, 28 Jun 1999 21:11:09 -0400
Message-ID: <A7C4BC1A6FDBD211B83400A0C9EBCC8F1488D3@exchange1.vertical.com>
From: Steven Guo <StevenG@vertical.com>
To: "'linux-kernel@vger.rutgers.edu'" <linux-kernel@vger.rutgers.edu>
Subject: Re: Improving raw network performance [was Apache performance etc .]
Date: Mon, 28 Jun 1999 18:04:17 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain; charset="iso-8859-1"
Sender: owner-linux-kernel@vger.rutgers.edu

Interrupt Mitigation is common for high speed lan drivers. The DEC chip has
built in support for it. For the chips which do not have the hardware
support, you can always use the kernel timer to poll for packets, you have
to be careful above switching between polling and interrupt though, using
different threshold can make a big difference in different systems. I've
done this under NT(software based interrupt mitigation), it's amazing to see
the difference it makes under heavy load. I am not Linux guy, but I can say
that this has to be done to even have a chance for it to match up against
NT's performance in bench mark tests.

Matthew Wilcox wrote:
> >   1. Interrupt comes in
> >   2. Kernel disables interrupt
> >   3. Driver fetches/sends data.
> >   4. Driver loops back to 3 if there's more data
> >      (many drivers do this already).
> >   5. Driver returns.
> > 
> >   ... timer driven delay ...
> > 
> >   6. Kernel reenables interrupt.
> >   7. If interrupt pending, go to 2.
> 
> You could only do this if the interrupt is not shared.  But if your
> network is normally being hammered then you probably didn't configure
> your network card to be on the same interrupt as your hard disc.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/

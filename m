Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276312AbRKMQpx>; Tue, 13 Nov 2001 11:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276249AbRKMQpw>; Tue, 13 Nov 2001 11:45:52 -0500
Received: from [195.63.194.11] ([195.63.194.11]:22801 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S276312AbRKMQpU>; Tue, 13 Nov 2001 11:45:20 -0500
Message-ID: <3BF15A72.793A1BF2@evision-ventures.com>
Date: Tue, 13 Nov 2001 18:37:54 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: dalecki@evision.ag, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Merge BUG in 2.4.15-pre4 serial.c
In-Reply-To: <E161TWH-0004G9-00@the-village.bc.nu> <3BF14F14.21D66343@evision-ventures.com> <20011113162111.B21298@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> On Tue, Nov 13, 2001 at 05:49:24PM +0100, Martin Dalecki wrote:
> > I have found the following code in serial.c aorund line 5565
> >
> > #ifdef __i386__
> >       if (i == NR_PORTS) {
> >               for (i = 4; i < NR_PORTS; i++)
> >                       if ((rs_table[i].type == PORT_UNKNOWN) &&
> >                           (rs_table[i].count == 0))
> >                               break;
> >       }
> > #endif
> >       if (i == NR_PORTS) {
> >               for (i = 0; i < NR_PORTS; i++)
> >                       if ((rs_table[i].type == PORT_UNKNOWN) &&
> >                           (rs_table[i].count == 0))
> >                               break;
> >       }
> >
> > This is supposedly the result of applying some patch twice.
> > Let me guess the first 8 lines of this can be deleted.
> 
> Look at it closer, in particular the for() loops.
> 
> It's basically there so that on x86, we don't normally use ttyS0-3
> for pcmcia and other similar ports, unless we run out of other ports
> to use.

Well I still think that the 8 lines can be deleted. Once again my famous
notbook is perfectly __i386__ and doesn't contain any devices served by
serial.c
unless I configure IrDA. Pushing the port numbers artificially behind
doesn't make sense for me and makes some setserial unknown tricks
neccessary
for irtty setup.

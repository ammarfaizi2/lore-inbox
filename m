Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129786AbRBFWFF>; Tue, 6 Feb 2001 17:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130298AbRBFWEz>; Tue, 6 Feb 2001 17:04:55 -0500
Received: from THUNK.ORG ([216.175.175.175]:776 "EHLO thunk.org")
	by vger.kernel.org with ESMTP id <S129786AbRBFWEu>;
	Tue, 6 Feb 2001 17:04:50 -0500
Date: Tue, 6 Feb 2001 14:39:19 -0500
From: "Theodore Ts'o" <tytso@thunk.org>
Message-Id: <200102061939.OAA24337@thunk.org>
To: "W. Michael Petullo" <mike@flyn.org>
Cc: edschulz@lucent.com, linux-kernel@vger.kernel.org
Subject: Re: Lucent Microelectronics Venus Modem, serial 5.05, and Linux 2.4.0
In-Reply-To: <20010114201045.A1787@dragon.flyn.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Phone: (781) 391-3464
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 14, 2001 at 08:10:45PM +0100, W. Michael Petullo wrote:
> > In serial.c, you seem to perform a check by writing to a possible
> > modem's interrupt enable register and reading the result.  This seems to
> > be one of the points at which the auto-configuration process occasionally
> > fails.  If I make the following change to this code my modem seems to
> > be auto-detected correctly all of the time:
> 
> >                scratch = serial_inp(info, UART_IER);
> >		serial_outp(info, UART_IER, 0);
> > #ifdef __i386__
> >		outb(0xff, 0x080);
> > #endif
> >		scratch2 = serial_inp(info, UART_IER);
> >		serial_outp(info, UART_IER, 0x0F);
> > #ifdef __i386__
> >		outb(0, 0x080);
> > #endif
> > -             scratch3 = serial_inp(info, UART_IER); /* REMOVE */
> > +             scratch3 = 0x0f                        /* ADD */
> > 		serial_outp(info, UART_IER, scratch);

The problem is that if this doesn't work, there are some serious
questions about the correctness of the Lucent Microelectronic Venus
modem.  I've forwarded this to someone in the Lucent Modem group, who
can hopefully look at this (and maybe can ship me a sample hardware so
I can play with it, although I'd much rather that he tell me how to
work around the hardware bug, or tell me that all you need is a
firmware upgrade to fix the bug in the modem).....

							- Ted

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

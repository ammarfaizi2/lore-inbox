Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129041AbRBFWhd>; Tue, 6 Feb 2001 17:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129168AbRBFWhY>; Tue, 6 Feb 2001 17:37:24 -0500
Received: from ihemail1.lucent.com ([192.11.222.161]:8921 "EHLO
	ihemail1.firewall.lucent.com") by vger.kernel.org with ESMTP
	id <S129093AbRBFWhT>; Tue, 6 Feb 2001 17:37:19 -0500
Message-ID: <3A807C98.C5DE2C67@agere.com>
Date: Tue, 06 Feb 2001 17:37:12 -0500
From: Ed Schulz <edschulz@agere.com>
Organization: Agere Systems
X-Mailer: Mozilla 4.73 [en]C-CCK-MCD EMS-1.4  (Win95; U)
X-Accept-Language: en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@thunk.org>
CC: "W. Michael Petullo" <mike@flyn.org>, linux-kernel@vger.kernel.org
Subject: Re: Lucent Microelectronics Venus Modem, serial 5.05, and Linux 2.4.0
In-Reply-To: <20010114201045.A1787@dragon.flyn.org> <200102061939.OAA24337@thunk.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One editorial correction: Our PCI host-controller modem is based on the
Mars DSP1646 or 1648, not the Venus DSP1673.  Venus modems include the
controller function, so require no special Linux code to work.

I'll forward these notes along to our developers, and let you know the
result.

The "sample hardware" is available quite cheaply from many sources,
although it can be hard to tell what really has Mars inside.  Here are some
brand name PCI modems containing Mars:
- Zoom 3025 (with early Windows V.92 code)
- Zoom 2925L for under $50.
- ActionTec DeskLink Pro PCI for $33.
-- 
Ed Schulz
Agere Systems
edschulz@agere.com

Theodore Ts'o wrote:
> 
> On Sun, Jan 14, 2001 at 08:10:45PM +0100, W. Michael Petullo wrote:
> > > In serial.c, you seem to perform a check by writing to a possible
> > > modem's interrupt enable register and reading the result.  This seems to
> > > be one of the points at which the auto-configuration process occasionally
> > > fails.  If I make the following change to this code my modem seems to
> > > be auto-detected correctly all of the time:
> >
> > >                scratch = serial_inp(info, UART_IER);
> > >             serial_outp(info, UART_IER, 0);
> > > #ifdef __i386__
> > >             outb(0xff, 0x080);
> > > #endif
> > >             scratch2 = serial_inp(info, UART_IER);
> > >             serial_outp(info, UART_IER, 0x0F);
> > > #ifdef __i386__
> > >             outb(0, 0x080);
> > > #endif
> > > -             scratch3 = serial_inp(info, UART_IER); /* REMOVE */
> > > +             scratch3 = 0x0f                        /* ADD */
> > >             serial_outp(info, UART_IER, scratch);
> 
> The problem is that if this doesn't work, there are some serious
> questions about the correctness of the Lucent Microelectronic Venus
> modem.  I've forwarded this to someone in the Lucent Modem group, who
> can hopefully look at this (and maybe can ship me a sample hardware so
> I can play with it, although I'd much rather that he tell me how to
> work around the hardware bug, or tell me that all you need is a
> firmware upgrade to fix the bug in the modem).....
> 
>                                                         - Ted
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

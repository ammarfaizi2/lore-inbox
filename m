Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129093AbRBFXID>; Tue, 6 Feb 2001 18:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129168AbRBFXHy>; Tue, 6 Feb 2001 18:07:54 -0500
Received: from ihemail2.lucent.com ([192.11.222.163]:1932 "EHLO
	ihemail2.firewall.lucent.com") by vger.kernel.org with ESMTP
	id <S129093AbRBFXHo>; Tue, 6 Feb 2001 18:07:44 -0500
Message-ID: <3A8083BD.F50540CF@agere.com>
Date: Tue, 06 Feb 2001 18:07:41 -0500
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

My previous note was probably in error.  W. Michael Petullo probably is
really using a PCI internal Venus DSP1673 modem.  I read too quickly and
assumed that we were talking about the "Linmodem" topic.

I will pass the note around here, and will summarize any replies I get. 
Clearly we should try it under Linux 2.4.

Since Venus modems include the controller function along with RAM and
flash, they're generally more expensive than Mars host-contoller modems. 
Here are some models:
- Zoom 2920
- MultiTech MultiModem ZPX MT5634ZPX-PCI
- Actiontec Call Waiting PCI56012-01CW
-- 
Ed Schulz
Agere Systems
+1 732 949 2066 voice
+1 732 949 5025 fax
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

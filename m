Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263014AbTL2JOG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 04:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbTL2JOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 04:14:06 -0500
Received: from smtp1.att.ne.jp ([165.76.15.137]:5045 "EHLO smtp1.att.ne.jp")
	by vger.kernel.org with ESMTP id S263014AbTL2JOE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 04:14:04 -0500
Message-ID: <00c001c3cdec$10c3f700$2fee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "Russell King" <rmk+lkml@arm.linux.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 modules, hotplug, PCMCIA
Date: Mon, 29 Dec 2003 18:13:25 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I replied to Russell King:

> > > 5.  However, file /etc/pcmcia/serial.opts is still getting ignored under
> > > 2.6.0.
> > > The modem is detected as containing a TI 16750 UART, and whatever
> > > the serial driver does then, it causes the modem to hang up.  The serial
> > > driver in 2.4.20 defaults to the same thing but 2.4.20 reads file
> > > /etc/pcmcia/serial.opts, obeys the line SERIAL_OPTS="uart 16550A", and lets
> > > the modem operate at 33% of its rated speed instead of hanging up.
> >
> > "hang up"?  Do you mean "on-hook" or do you mean "stop working"?  Is
> > there anything in /var/log/messages about this
>
> I think both.  "on-hook" happens immediately, and the only way to try again
> is to eject the card and reinsert it.
>
> > On my RH systems, cardmgr logs a fair amount to the system messages log,
>
> As far as I can tell, in SuSE 8.2 with SuSE's default version of the 2.4.20
> kernel, this isn't happening, but in 2.6.0 it is happening even when I
> didn't ask for it.

Sorry for misstating that.  It's actually the other way around.  2.6.0 is
not giving me a ton of unrequested log syslog messages, but neither is it
giving any reason for the modem to stop working.  It only observes that the
modem hung up with no visible reason, and it doesn't even notice that the
modem cannot be retried until ejection and reinsertion.  In both 2.4.20 and
2.6.0, the serial_cs driver detects the UART as a TI 16750, which either
means that the UART really is a 16750 but the chip and the driver don't
agree on how the chip should be handled, or that the UART is a 16550A (or
something else) being misdetected.

SuSE's 2.4.20 PCMCIA configuration is writing around 6,000 syslog messages
every time I boot it.  I don't think you want that, especially when it's
from 2.4.20 which is obeying my addition in file /etc/pcmcia/serial.opts
saying  SERIAL_OPTS="uart 16550A"


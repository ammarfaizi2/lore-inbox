Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbTL2CF1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 21:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbTL2CF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 21:05:26 -0500
Received: from smtp1.att.ne.jp ([165.76.15.137]:12275 "EHLO smtp1.att.ne.jp")
	by vger.kernel.org with ESMTP id S262323AbTL2CFR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 21:05:17 -0500
Message-ID: <18ce01c3cdb0$29463130$43ee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "Russell King" <rmk+lkml@arm.linux.org.uk>
Cc: <linux-kernel@vger.kernel.org>
References: <173b01c3cceb$05ade850$43ee4ca5@DIAMONDLX60> <20031228110646.A8072@flint.arm.linux.org.uk>
Subject: Re: 2.6.0 modules, hotplug, PCMCIA
Date: Mon, 29 Dec 2003 11:03:47 +0900
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

Russell King replied to me:

> > 4.  SuSE 8.2 defaults to using the kernel PCMCIA package rather than the
> > external PCMCIA package.  This is fine with me so kernel 2.6.0 also uses its
> > own compiled PCMCIA drivers instead of trying to make an external PCMCIA
> > package work with two kernels.  It seems to me that it should be OK to
> > compile PCMCIA as modules instead of built-in, but there were boot-time
> > errors, so I had to change PCMCIA and Yenta to built-in.
>
> What were these errors?

I think it was that the PCMCIA core and Yenta modules didn't even get
loaded, I had to modprobe them.  The need to type "cardmgr &" by hand
remained necessary even after recompiling with them built-in and rebooting.

> It sounds like the SuSE init scripts are being clever and probably only
> know about how their 2.4 situation works.

I agree.

> > 5.  However, file /etc/pcmcia/serial.opts is still getting ignored under
> > 2.6.0.
>
> "still" ?  This is news to me (as the guy who seems to be handling both
> PCMCIA and serial.)

"still" as in "even after compiling the drivers as Y instead of M, and
typing the cardmgr command by hand".  Not "still" as in "[not] same as 2.4"
because this bug does not occur in 2.4.

> > The modem is detected as containing a TI 16750 UART, and whatever
> > the serial driver does then, it causes the modem to hang up.  The serial
> > driver in 2.4.20 defaults to the same thing but 2.4.20 reads file
> > /etc/pcmcia/serial.opts, obeys the line SERIAL_OPTS="uart 16550A", and lets
> > the modem operate at 33% of its rated speed instead of hanging up.
>
> "hang up"?  Do you mean "on-hook" or do you mean "stop working"?  Is
> there anything in /var/log/messages about this?

I think both.  "on-hook" happens immediately, and the only way to try again
is to eject the card and reinsert it.

> On my RH systems, cardmgr logs a fair amount to the system messages log,
> which includes details of any commands run and any failures.  It would
> be really useful to see this.

As far as I can tell, in SuSE 8.2 with SuSE's default version of the 2.4.20
kernel, this isn't happening, but in 2.6.0 it is happening even when I
didn't ask for it.  /var/log/messages gets around 20,000 lines of messages
every day that I experiment with 2.6.0, and 90% of it is PCMCIA stuff.  I
think I'm capable of e-mailing it to you if it will help.  Actually later
today I might have time to experiment with the modem and 2.6.0 again, and
might be able to grep for appropriate stuff in /var/log/messages.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263484AbTDGP2N (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 11:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263487AbTDGP2N (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 11:28:13 -0400
Received: from chaos.analogic.com ([204.178.40.224]:33667 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263484AbTDGP2J (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 11:28:09 -0400
Date: Mon, 7 Apr 2003 11:51:04 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Michael Buesch <freesoftwaredeveloper@web.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: modifying line state manually on ttyS
In-Reply-To: <200304071702.08114.freesoftwaredeveloper@web.de>
Message-ID: <Pine.LNX.4.53.0304071139390.18753@chaos>
References: <200304071702.08114.freesoftwaredeveloper@web.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Apr 2003, Michael Buesch wrote:

> Hi.
>
> I have asked in many other mailing-lists, but I got no good
> solution for my problem, so I try to ask here, although it may
> not be the exaclty correct list for it.
>
> I have developed my own device, that is connected to ttyS0.
> To talk to my device, I need to set the state of the TxD line
> manually to either 0 or 1 (+12v or -12v). What I try to say is,
> I don't want to write a whole byte to the port, but only one single
> bit, that then stays persistent on the line, until I reset its state.
> Better sayed, I want to handle TxD line, like it's possible for
> DTR-line for example.
>
> Is kernel-support by the ttyS driver present for this, or do I
> have to write my own driver for my device. I'm trying to
> implement the driver in user-space, but I didn't find a solution
> to set linestate of TxD.
>
> Regards
> Michael Buesch.

Well ttyS0 is connected to the rest of the machine using a UART.
This means that you can't control TxD directly. I suggest that
you use the parallel printer-port. This port allows you to set
individual bits and they remain <forever> in the last state set.
An ordinary (old-fashioned) printer-port allows you to set or
reset 8 data bits plus three control bits. The newer ones allow
you to read and write up to 16 bits.

Now, if you really need the +/- 12 volts that you think you
will get out of a UART, please measure it first. Many new computers
use I/O chips that only provide +/- 5 volts! Anyway, you can use the
modem-control bits if you need that kind of voltage swing. You can
set/reset modem control bits using the TIOCMGET/TIOCMSET ioctl()
calls. You probably want to disable the SIGHUP signal before
you muck with those bits. Some versions of Linux will send the
hangup signal to the TTY owner even though it's not the controlling
terminal for the process. This could cause your program to exit
for "unknown" reasons; signal(SIGHUP, SIG_IGN) prevents such problems.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


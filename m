Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263016AbVGNTdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263016AbVGNTdu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 15:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263086AbVGNTba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 15:31:30 -0400
Received: from taxbrain.com ([64.162.14.3]:43565 "EHLO petzent.com")
	by vger.kernel.org with ESMTP id S263077AbVGNTa5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 15:30:57 -0400
From: "karl malbrain" <karl@petzent.com>
To: "Russell King" <rmk+lkml@arm.linux.org.uk>
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: 2.6.9: serial_core: uart_open
Date: Thu, 14 Jul 2005 12:30:48 -0700
Message-ID: <NDBBKFNEMLJBNHKPPFILOEAICEAA.karl@petzent.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Importance: Normal
In-Reply-To: <20050714195717.B10410@flint.arm.linux.org.uk>
X-Spam-Processed: petzent.com, Thu, 14 Jul 2005 12:27:02 -0700
	(not processed: message from valid local sender)
X-Return-Path: karl@petzent.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: petzent.com, Thu, 14 Jul 2005 12:27:05 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Russell King [mailto:rmk@arm.linux.org.uk]On Behalf Of Russell
> King
> Sent: Thursday, July 14, 2005 11:57 AM
> To: karl malbrain
> Cc: Linux-Kernel@Vger. Kernel. Org
> Subject: Re: 2.6.9: serial_core: uart_open
>
>
> On Thu, Jul 14, 2005 at 10:16:23AM -0700, karl malbrain wrote:
> > I'd love to do a ps listing for you, but, except for the mouse,
> the system
> > is completely unresponsive after issuing the blocking open("/dev/ttyS1",
> > O_RDRW).
> >
> > Telnet is dead; the console will respond to the mouse, but the
> only thing I
> > can do is close the xterm window and thereby kill the process.
> I can launch
> > a new xterm window from the menu using the mouse, but the new
> window is dead
> > and has no cursor nor bash prompt.
> >
> > The clock on the display is being updated.  After several hours
> the system
> > reboots on its own.
> >
> > I recall from my DOS days that 8250/16550 programming requires that the
> > specific IIR source be responded to, or the chip will immediately
> > turn-around with another interrupt.  It doesn't look like 8250.c is
> > organized to respond directly to the modem-status-change value
> in IIR which
> > requires reading MSR to reset.
>
> Well, at this point interrupts are enabled, and _are_ handled.  The
> only thing we use the IIR for is to answer the question "did this
> device say it had an interrupt?"
>
> If it did, we unconditionally read the MSR without fail.
>
> So, I've no idea what so ever about what's going on here.  I don't
> understand why your system is behaving the way it is.  Therefore,
> I don't think we can progress this any further, sorry.

There is some code inserted at the top of the main receive_chars loop in
8250.c that examines  tty->flip.count and returns without reading UART_RX
under the condition that tty->flip.count is not reset after a call to
tty->flip.work.func.  This would leave the chip RX IIR unserviced and
subject another interrupt request.  Is it possible that this is the cause of
the problem?

karl m

Thanks, karl m




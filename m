Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261617AbVGNRUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbVGNRUK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 13:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262659AbVGNRSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 13:18:18 -0400
Received: from taxbrain.com ([64.162.14.3]:9768 "EHLO petzent.com")
	by vger.kernel.org with ESMTP id S261617AbVGNRQg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 13:16:36 -0400
From: "karl malbrain" <karl@petzent.com>
To: "Russell King" <rmk+lkml@arm.linux.org.uk>
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: 2.6.9: serial_core: uart_open
Date: Thu, 14 Jul 2005 10:16:23 -0700
Message-ID: <NDBBKFNEMLJBNHKPPFILIEAICEAA.karl@petzent.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Importance: Normal
In-Reply-To: <20050714092648.C26322@flint.arm.linux.org.uk>
X-Spam-Processed: petzent.com, Thu, 14 Jul 2005 10:12:41 -0700
	(not processed: message from valid local sender)
X-Return-Path: karl@petzent.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: petzent.com, Thu, 14 Jul 2005 10:12:45 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Russell King
> Sent: Thursday, July 14, 2005 1:27 AM
> To: karl malbrain
> Cc: Linux-Kernel@Vger. Kernel. Org
> Subject: Re: 2.6.9: serial_core: uart_open
>
>
> On Wed, Jul 13, 2005 at 10:53:19AM -0700, karl malbrain wrote:
> > I've also noticed that the boot sequence probes for modems on the serial
> > ports.  Is it possible that 8250.c is having a problem servicing an
> > interrupt from a character/state-change left over from this
> initialization?
>
> I did ask for a process listing a while back.  I don't want to
> speculate on possible causes until we have some real information
> from the system as to what's going on.
>
> Please run up your test program and get the machine into the
> problematic state.  Let it remain like that for about 2 minutes,
> and then run via a telnet session or other window:
>
> ps aux > /tmp/ps-forrmk.txt
>
> and send me that file.

I'd love to do a ps listing for you, but, except for the mouse, the system
is completely unresponsive after issuing the blocking open("/dev/ttyS1",
O_RDRW).

Telnet is dead; the console will respond to the mouse, but the only thing I
can do is close the xterm window and thereby kill the process. I can launch
a new xterm window from the menu using the mouse, but the new window is dead
and has no cursor nor bash prompt.

The clock on the display is being updated.  After several hours the system
reboots on its own.

I recall from my DOS days that 8250/16550 programming requires that the
specific IIR source be responded to, or the chip will immediately
turn-around with another interrupt.  It doesn't look like 8250.c is
organized to respond directly to the modem-status-change value in IIR which
requires reading MSR to reset.

I wish I could be of more assistance.  karl m




Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263345AbVGOQ7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263345AbVGOQ7O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 12:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263324AbVGOQ7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 12:59:07 -0400
Received: from taxbrain.com ([64.162.14.3]:38225 "EHLO petzent.com")
	by vger.kernel.org with ESMTP id S263340AbVGOQ5j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 12:57:39 -0400
From: "karl malbrain" <karl@petzent.com>
To: <linux-os@analogic.com>
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: 2.6.9: serial_core: uart_open
Date: Fri, 15 Jul 2005 09:57:31 -0700
Message-ID: <NDBBKFNEMLJBNHKPPFILCEALCEAA.karl@petzent.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Importance: Normal
In-Reply-To: <Pine.LNX.4.61.0507151150290.11664@chaos.analogic.com>
X-Spam-Processed: petzent.com, Fri, 15 Jul 2005 09:53:46 -0700
	(not processed: message from valid local sender)
X-Return-Path: karl@petzent.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: petzent.com, Fri, 15 Jul 2005 09:53:49 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Richard B. Johnson
> Sent: Friday, July 15, 2005 8:53 AM
> To: karl malbrain
> Cc: Linux-Kernel@Vger. Kernel. Org
> Subject: RE: 2.6.9: serial_core: uart_open
>
>
> On Wed, 13 Jul 2005, karl malbrain wrote:
>
> > I've also noticed that the boot sequence probes for modems on the serial
> > ports.  Is it possible that 8250.c is having a problem servicing an
> > interrupt from a character/state-change left over from this
> initialization?
> >
>
> It doesn't care. Interrupts are edges in the 8250. If an interrupt
> is lost, it's just lost. The change of state gets lost or the character
> gets lost. This is rare, but cannot cause a hung system.

My spec for the NS16550D and my experience show that the specific interrupt
source identified in IIR must be serviced or the chip will initiate a new
interrupt sequence at its first opportunity.

When I wrote a 8250/16550 driver for DOS it was driven from IIR directly.
If you don't take this approach, then you must certify that each and every
path through the irq driver must service all possible interrupt sources.

karl m




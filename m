Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261721AbVCYSQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261721AbVCYSQI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 13:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbVCYSQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 13:16:08 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:50621 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S261721AbVCYSQE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 13:16:04 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: Interesting tidbit: NetMos 9835 card, IRQ, and ACPI
Date: Fri, 25 Mar 2005 11:15:56 -0700
User-Agent: KMail/1.7.2
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <42430EAD.3050605@tls.msk.ru> <20050324191654.D4189@flint.arm.linux.org.uk> <42431B0A.2000407@tls.msk.ru>
In-Reply-To: <42431B0A.2000407@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503251115.56413.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 March 2005 12:54 pm, Michael Tokarev wrote:
> Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
> ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 18 (level, low) -> IRQ 193
> ttyS4 at I/O 0xa400 (irq = 193) is a 16550A
> ttyS5 at I/O 0xa000 (irq = 193) is a 16550A
> 
> And oh.. now the ports are at ttyS[45], I used for them
> to be at ttyS[23]... Oh well...

Someday maybe we should make serial rely on PNP, and only
use the compiled-in table when PNP isn't available or is
turned off.  Then ports would just be numbered sequentially
as they're discovered.  And it would also help with the
current situation where ttyS0/1 are often discovered two
or three times.

> The patch does not apply to 2.6.11 - several hunks, notable
> all the parport stuff, fails.  I'll dig into this a bit
> later today (hopefully).  8250 changes are enouth for the
> serial port to work, parallel port still does not work --
> without the missing patch hunks.

My patch was against the -mm tree, and I think one of the
differences between 2.5.11 and the -mm tree was the
removal of 9835 from parport_pc.  Sounds like you've
figured that out already :-)

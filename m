Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262862AbUCSN22 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 08:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262987AbUCSN22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 08:28:28 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:4332 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262862AbUCSN20
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 08:28:26 -0500
Date: Fri, 19 Mar 2004 14:28:25 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Robert_Hentosh@Dell.com
Cc: fleury@cs.auc.dk, linux-kernel@vger.kernel.org
Subject: RE: spurious 8259A interrupt
In-Reply-To: <6C07122052CB7749A391B01A4C66D31E014BEA49@ausx2kmps304.aus.amer.dell.com>
Message-ID: <Pine.LNX.4.55.0403191426180.18215@jurand.ds.pg.gda.pl>
References: <6C07122052CB7749A391B01A4C66D31E014BEA49@ausx2kmps304.aus.amer.dell.com>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Mar 2004 Robert_Hentosh@Dell.com wrote:

> > Sometimes the processor would unmask IRQ10 almost immediately after
> reading the status
> > register in the NIC, which results in IRQ10 being unmasked before the
> IRQ10 signal has
> > finished going high.  This causes the PIC to think that there is
> another IRQ10, but, 
> > by the time the processor asks for the vector, IRQ10 is no longer
> asserted.
> 
> The PIC defaults to IRQ7 because of its design, when IRQ10 was already
> cleared. Sticking delays in is not viable in a generic ISR routing.  A
> possible fix to this issue would be to issue the EOI after the read to
> the status register on the NIC, and I see some documentation on the PIC
> that actually suggests that this is the way to service an interrupt.
> This seemed like a risky change, since sending the EOI and using the
> mask has been in use for some time and the change would effect all
> devices using interrupts.

 The best way to deal with spurious interrupts is to ack the interrupt at
the device ASAP in the handler, especially if you know that the response
is slow.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbUCVJMP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 04:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261822AbUCVJMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 04:12:15 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:11685 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261809AbUCVJMN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 04:12:13 -0500
Date: Mon, 22 Mar 2004 10:12:12 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Hans-Peter Jansen <hpj@urpla.net>
Cc: root@chaos.analogic.com, Jamie Lokier <jamie@shareable.org>,
       Robert_Hentosh@Dell.com, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: spurious 8259A interrupt
In-Reply-To: <200403211858.07445.hpj@urpla.net>
Message-ID: <Pine.LNX.4.55.0403221003040.6539@jurand.ds.pg.gda.pl>
References: <6C07122052CB7749A391B01A4C66D31E014BEA49@ausx2kmps304.aus.amer.dell.com>
 <20040319130609.GE2650@mail.shareable.org> <Pine.LNX.4.53.0403190825070.929@chaos>
 <200403211858.07445.hpj@urpla.net>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Mar 2004, Hans-Peter Jansen wrote:

> > The IRQ7 spurious is usually an artifact of a crappy motherboard
> > design where the CPU "thinks" it was interrupted, but the
> > controller didn't wiggle the CPUs INT line.
> 
> Thanks for the nice explanation, Richard. 

 Unfortunately this needs not be the reason.  Another possibility is a
crappy driver -- if a device generates a level-triggered interrupt which
does not deassert immediately after getting acked (perhaps because the IRQ
line is firmware-driven) and the handler in the driver doesn't ack it soon
enough, it's possible for the interrupt line to be still asserted after
exiting the handler.  The processor may have enough time to accept the
interrupt again and with the right timing, the line may go inactive right
in a middle of the processor's interrupt acknowledge sequence.  The 8259A
PIC will signal a spurious interrupt in this case.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

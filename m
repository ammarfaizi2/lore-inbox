Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283353AbRK2Rux>; Thu, 29 Nov 2001 12:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283356AbRK2Ruo>; Thu, 29 Nov 2001 12:50:44 -0500
Received: from venus.ci.uw.edu.pl ([193.0.74.207]:53001 "EHLO
	venus.ci.uw.edu.pl") by vger.kernel.org with ESMTP
	id <S283353AbRK2Ru1>; Thu, 29 Nov 2001 12:50:27 -0500
Date: Thu, 29 Nov 2001 18:48:47 +0100 (CET)
From: Jan Slupski <jslupski@email.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Vaio IRQ routing / USB problem
Message-ID: <Pine.LNX.4.21.0111291830400.23765-100000@venus.ci.uw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

I got Sony Vaio PCG-FX240 (on i815), and problems as Tom Winkler 
described.

Maybe you will be interested in my patch, which also makes
USB work...

Maybe it is a little narrower the prevoius ones.
I think it is worth to add 'is_sony_vaio_laptop' check in if condition...

I know that is a rather ugly hack, but maybe it can be added to kernel,
like other sony pathces... Of course it should be implemented somehow
nicer...

--- pci-irq.c	Sun Nov  4 18:31:58 2001
+++ ../../../../linux-2.4.14-pre3/arch/i386/kernel/pci-irq.c	Sun Nov  4 19:01:30 2001
@@ -588,7 +588,7 @@
 		irq = pirq & 0xf;
 		DBG(" -> hardcoded IRQ %d\n", irq);
 		msg = "Hardcoded";
-	} else if (r->get && (irq = r->get(pirq_router_dev, dev, pirq))) {
+	} else if (r->get && (irq=r->get(pirq_router_dev, dev, pirq)) && !(dev->vendor==0x8086 && dev->device==0x2442)) {
 		DBG(" -> got IRQ %d\n", irq);
 		msg = "Found";
 	} else if (newirq && r->set && (dev->class >> 8) != PCI_CLASS_DISPLAY_VGA) {



Plese CC me if you have any additional questions/comments.
I can send some logs, or anything...

Jan

PS.
My eepro100 card works great on 100Mbps net, and has problems
(eepro100: wait_for_cmd_done) on 10Mbs. Even if I set up
speed manually (by option to module)

   _  _  _  _  _____________________________________________
   | |_| |\ |  S L U P S K I              jslupski@email.com
 |_| | | | \|                 http://www.pm.waw.pl/~jslupski  


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264831AbTFBS37 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 14:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264832AbTFBS37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 14:29:59 -0400
Received: from tag.witbe.net ([81.88.96.48]:21517 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S264831AbTFBS36 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 14:29:58 -0400
From: "Paul Rolland" <rol@as2917.net>
To: "'Russell King'" <rmk@arm.linux.org.uk>
Cc: "'Ruud Linders'" <rkmp@xs4all.nl>, <linux-kernel@vger.kernel.org>
Subject: Re: Serial port numbering (ttyS..) wrong for 2.5.61+
Date: Mon, 2 Jun 2003 20:43:24 +0200
Message-ID: <011501c32936$d8fc44d0$3f00a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <20030602185118.B776@flint.arm.linux.org.uk>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


> When we add a port to the system, we try to find in order:
> 
> - a port which matches the base address
> - a port which is unallocated
> 
> Probably the easiest way to stop the "ttyS14" occuring would 
> be to clear the port information at boot when we don't find a port.
> 
>From 8250_pci.c, you have :

/*              
 * Probe one serial board.  Unfortunately, there is no rhyme nor reason
 * to the arrangement of serial ports on a PCI card.
 */             

It seems that your board is reporting the parameters in such an order
that when looking for a port based on the IRQ, I/O port, ... the matching
one has id 14...

You could see this more clearly by setting SERIAL_DEBUG_PCI
at line 1549 to activate the code :
#ifdef SERIAL_DEBUG_PCI
                printk("Setup PCI port: port %x, irq %d, type %d\n",
                       serial_req.port, serial_req.irq, serial_req.io_type);
#endif

that would report to you the order in which ports are found on
your system.

Regards,
Paul



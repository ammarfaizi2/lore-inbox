Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277692AbRJRKi7>; Thu, 18 Oct 2001 06:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277695AbRJRKit>; Thu, 18 Oct 2001 06:38:49 -0400
Received: from leibniz.math.fu-berlin.de ([160.45.40.10]:24549 "HELO
	math.fu-berlin.de") by vger.kernel.org with SMTP id <S277692AbRJRKim>;
	Thu, 18 Oct 2001 06:38:42 -0400
Date: Thu, 18 Oct 2001 12:39:09 +0200 (MEST)
From: Enver Haase <ehaase@inf.fu-berlin.de>
To: linux-kernel@vger.kernel.org
cc: twaugh@redhat.com
Subject: Bug in request_irq() ?
Message-ID: <Pine.GSO.4.20.0110181228080.2862-100000@nidan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi developers,

I have some NetMos card here: 2 parallel ports, PCI.

This card is somewhat funny. I believe it fires interrupts for nothing: I
cannot boot Win98 when the Lexmark 4039 is turned on which is connected to
one of the ports (it crashes).

Back to Linux (2.4.12, "ECP symbol name patch"):

When I configure the card to share the IRQ line with the NE2000 PCI
clone, then the machine hangs as soon as the card is "ifconfig"ed.

When I configure the card to share the IRQ line with the onboard USB, then
the machine hangs as soon as the USB driver is initialized.

When I configure the card to be have an own un-shared interrupt line, and
let the NE2000clone and USB share a line, all works well.

Remember, there is no registered interrupt driver for PCI parallel port
cards. I suspect request_irq() has a problem when a device wants to 
get an IRQ sharing it with a device that fires interrupts but has no own
driver.

A work-around could be disabling interrupts in the parallel port driver,
but that would mean it has to be initialized before all the other devices
sharing the IRQ --- which is prone to errors.


This is all based on more observation than code-reading so there might be
a better explanation: only I don't know it, yet.


Greetings,
Enver


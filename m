Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268779AbRG0F0W>; Fri, 27 Jul 2001 01:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268780AbRG0F0M>; Fri, 27 Jul 2001 01:26:12 -0400
Received: from groucho.maths.monash.edu.au ([130.194.160.211]:55311 "EHLO
	groucho.maths.monash.edu.au") by vger.kernel.org with ESMTP
	id <S268779AbRG0F0A>; Fri, 27 Jul 2001 01:26:00 -0400
From: Robin Humble <rjh@groucho.maths.monash.edu.au>
Message-Id: <200107270526.FAA07475@groucho.maths.monash.edu.au>
Subject: 2.4.7 + VIA Pro266 + 2xUltraTx2 lockups
To: linux-kernel@vger.kernel.org
Date: Fri, 27 Jul 2001 15:26:02 +1000 (EST)
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Are there any known issues with kernel 2.4.7 and VIA pro266 chipsets?

Under high PCI load we're getting repeatable complete system freezes
when accessing two PCI IDE controller cards at the same time... even
the magic sysrq key doesn't work. It's a ASUS cuv266 motherboard which
has a VIA vt8633/vt8233 chipset (Apollo Pro266) with a 1GHz P3 and 512M
of DDR ram.
  http://www.asus.com/products/Motherboard/ddr266/cuv266/index.html
We have two Promise Ultra100 Tx2 IDE controller cards with four 75G
ibm disks on each (8 ibm disks total). We also have a 40G ATA100
Maxtor disk for the OS on the on-board IDE controller.

We've tried kernel 2.4.7 plus the ide.2.4.7-p3.all.07092001.patch from
www.linux-ide.org (required to recognise the Tx2 cards), and with a cvs
2.4.7+XFS kernel with the same ide patch (kgcc was used to compile both
of these), and also with a stock RedHat 7.1 update kernel 2.4.3-12.
They all freeze in the same way.

A test that involves hammering 4 drives on one of the Tx2 cards with
four bonnie++'s works just fine, but running a few bonnies on each
card (making both Tx2 cards work at the same time) causes a freeze
within about a minute - this is very repeatable. A raid5 resync over
the 8 disks causes a fast freeze also. There are no IRQ conflicts and
moving the Tx2 cards to different slots doesn't help.

Note that using the same controllers and drives and all the same
tests except on a motherboard with a BX chipset (Pentium3/450 +
RedHat kernel 2.4.3-12) works without any problems at all.

So the system is stable when driving a single Tx2 card, or on a BX,
but just not two Tx2's together on the pro266 board :-/ So it's
perhaps (I'm guessing here :) a non-trivial Tx2 driver bug or maybe a
VIA Pro266 problem?

Let me know if you want more details or want us to try out anything.

Please CC me in any replies as I'm not subscribed... ta.

cheers,
robin

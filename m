Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267050AbRGIMjh>; Mon, 9 Jul 2001 08:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267054AbRGIMj1>; Mon, 9 Jul 2001 08:39:27 -0400
Received: from mail9.bigmailbox.com ([209.132.220.40]:16144 "EHLO
	mail9.bigmailbox.com") by vger.kernel.org with ESMTP
	id <S267050AbRGIMjK>; Mon, 9 Jul 2001 08:39:10 -0400
Date: Mon, 9 Jul 2001 05:38:55 -0700
Message-Id: <200107091238.FAA11225@mail9.bigmailbox.com>
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: binary
X-Mailer: MIME-tools 4.104 (Entity 4.116)
Mime-Version: 1.0
X-Originating-Ip: [64.40.40.237]
From: "Colin Bayer" <colin_bayer@compnerd.net>
To: linux-kernel@vger.kernel.org
Cc: rddunlap@osdlab.org
Subject: RE: Sticky IO-APIC problem
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

'K, after hours (which seemed like years) of surfing the datasheets of the 82810AA ICH (I/O Controller Hub) from Intel, I've come up with step-by-step hardware-level instructions for enabling the IO-APIC with pre-defined PIRQs (I'm not an assembly guru, so I can't help with the coding of this):

1) Set bit 7 of register PIRQ[n]_ROUT (offset 60h) to 0.
2) Set bits 3:0 of the same register to the (8259) interrupt to be mapped on this PIRQ (big-endian).
3) Set the corresponding bit on the correct 8259s (master is at 21h, slave at A1h) OCW1 register to mask the interrupt; the way I read it, bit 7 of the A1h register is IRQ 15, bit 0 of 21h is IRQ 0.
4) Set bit 8 of GEN_CNTL (starting offset D0h, hehe...) to 1 to enable the I/O APIC.

Anyway, that's as far as I could read into the process.  Hope somebody out there in maintainer-land can create a cogent snippet of code out of it.  If such code exists, plz don't flame me...

     -- Colin


On the first day, man created the computer.  On the second day, God proclaimed from the heavens, "F0 0F C7 C8".

------------------------------------------------------------
The CompNerd Network: http://www.compnerd.com/
Where a nerd can be a nerd.  Get your free webmail@compnerd.net!

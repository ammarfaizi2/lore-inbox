Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130063AbQKQQwI>; Fri, 17 Nov 2000 11:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130061AbQKQQv7>; Fri, 17 Nov 2000 11:51:59 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24330 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129921AbQKQQvq>;
	Fri, 17 Nov 2000 11:51:46 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200011171620.eAHGKgg00324@flint.arm.linux.org.uk>
Subject: VGA PCI IO port reservations
To: linux-kernel@vger.kernel.org
Date: Fri, 17 Nov 2000 16:20:41 +0000 (GMT)
Cc: mj@suse.cz
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been looking at a number of VGA cards recently, and I've started
wondering out the Linux resource management as far as allocation of
IO ports.  I've come to the conclusion that it does not contain all
information necessary to allow allocations to be made safely.

Thus far, VGA cards that I've looked at scatter extra registers through
out the PCI IO memory region without appearing in the PCI BARs.  In fact,
for some cards there wouldn't be enough BARs to list them all.

For example, S3 cards typically use:

 0x0102,  0x42e8,  0x46e8,  0x4ae8,  0x8180 - 0x8200,  0x82e8,  0x86e8,
 0x8ae8,  0x8ee8,  0x92e8,  0x96e8,  0x9ae8,  0x9ee8,  0xa2e8,  0xa6e8,
 0xaae8,  0xaee8,  0xb2e8,  0xb6e8,  0xbae8,  0xbee8,  0xe2e8, 
 0xff00 - 0xff44

And Trident TGUI9440 uses:

 0x2120,  0x43c4

Cyber2000-type cards use:

 0x0102,  0x46e8

These aren't guaranteed to be exhaustive listings either.

Some of these cards require writes to these registers to "wake them up"
so I think we can assume that these cards are listening for accesses to
those ports.  If we allocate another device to use that region, we could
well end up getting IO port clashes.

Surely we should be reserving these regions before we start to allocate
resources to PCI cards?

Comments?
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154302AbQA2UIU>; Sat, 29 Jan 2000 15:08:20 -0500
Received: by vger.rutgers.edu id <S154246AbQA2UHP>; Sat, 29 Jan 2000 15:07:15 -0500
Received: from dyn-225.linux.theplanet.co.uk ([195.92.192.225]:1811 "EHLO caramon.arm.linux.org.uk") by vger.rutgers.edu with ESMTP id <S154386AbQA2UAF>; Sat, 29 Jan 2000 15:00:05 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200001300006.AAA02084@raistlin.arm.linux.org.uk>
Subject: DMA changes in 2.3.41 - how the f* do I get this working on ARM?
To: linux-kernel@vger.rutgers.edu
Date: Sun, 30 Jan 2000 00:06:15 +0000 (GMT)
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

Hi,

I've been looking over the 2.3.41 patch, and have come across a major problem
area for ARM.

On ARM, there is no such thing as "dma coherent" memory.  Unfortunately, the
new PCI code (pci_alloc_consistent) appears to assume that there is a way
of doing this.

I have had ideas about ways to do this on the ARM, but it will not be trivial
changes to the mm layer, and certainly has not been implemented yet.

This effectively means that I seem to have two options:

1. either we loose any hope of IDE DMA for the rest of 2.3 and 2.4, or
2. the IDE DMA code gets the dma_cache_* macros added back in

I would have preferred to have heard about the extent of these changes (and
that the dma_cache_* macros were going to be removed, along with my comments
marking them with my initials) before it was submitted.

For now, I'm adding the dma_cache_* macros back in, and if I don't hear anything,
I will be re-submitting that code back to Linus.

(very pissed)
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | |   http://www.arm.linux.org.uk/~rmk/aboutme.html    /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/

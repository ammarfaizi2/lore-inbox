Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130335AbRAVGb4>; Mon, 22 Jan 2001 01:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130913AbRAVGbq>; Mon, 22 Jan 2001 01:31:46 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12555 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S130335AbRAVGbh>;
	Mon, 22 Jan 2001 01:31:37 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200101212311.f0LNBvm01377@flint.arm.linux.org.uk>
Subject: Re: Inefficient PCI DMA usage (was: [experimental patch] UHCI updates)
To: johannes@erdfelt.com (Johannes Erdfelt)
Date: Sun, 21 Jan 2001 23:11:56 +0000 (GMT)
Cc: manfred@colorfullife.com (Manfred Spraul), linux-kernel@vger.kernel.org
In-Reply-To: <20010121123730.N9156@sventech.com> from "Johannes Erdfelt" at Jan 21, 2001 12:37:31 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

You may have already found out that there's a problem using
pci_alloc_consistent and friends in the USB layer which will
only be obvious on CPUs where they need to do page table remapping
- that is that pci_alloc_consistent/pci_free_consistent aren't
guaranteed to be interrupt-safe.

I'm not sure what the correct way around this is yet, but I do
know its a major problem. ;(

Maybe we need to do a get_free_pages-type thing with this and
keep a set amount of consistent area in reserve for atomic
allocations (as per GFP_ATOMIC)?  Yes, I know its not nice, but
I don't see any other option at the moment with USB.

(yes, I'm hacking the 2.2.18 ohci driver for my own ends to get
something up and running on one of my machines).
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

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272076AbRHVSc5>; Wed, 22 Aug 2001 14:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271975AbRHVScs>; Wed, 22 Aug 2001 14:32:48 -0400
Received: from pizda.ninka.net ([216.101.162.242]:32428 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S271638AbRHVSce>;
	Wed, 22 Aug 2001 14:32:34 -0400
Date: Wed, 22 Aug 2001 11:32:36 -0700 (PDT)
Message-Id: <20010822.113236.48384121.davem@redhat.com>
To: groudier@free.fr
Cc: gibbs@scsiguy.com, axboe@suse.de, skraw@ithnet.com,
        phillips@bonn-fries.net, linux-kernel@vger.kernel.org
Subject: Re: With Daniel Phillips Patch
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20010822195804.R610-100000@gerard>
In-Reply-To: <20010822.080540.35030343.davem@redhat.com>
	<20010822195804.R610-100000@gerard>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=big5
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Gérard Roudier <groudier@free.fr>
   Date: Wed, 22 Aug 2001 20:21:50 +0200 (CEST)
   
   First, let me thank you a LLLOOOOOOTTTTT, David, for you PCI 64 bit
   addressing DMA-mapping. I didn't have looked yet into your patch and
   documentation update, but I will do so ASAP.
   
You're very welcome. :-)

   OTOH, it is a great pleasure for me to hear that you didn't forget what I
   told you about the current limitation of the SYM53C8XX driver. For now,
   the driver would be only able to use 40 bit addresses with all upper bits
   set to zero. This doesn't fit PCI 64 bit implementation of the Alpha
   Monster window for example, and probably doesn't fit most other non-Intel
   PCI 64 bit implementations.
   
It is fully known, in fact, I converted the sym53c8xx.c driver as
one of the examples in the patch.

Alpha can use it, in cases where memory in the system is less than
the addressing limitation of device.

Such logic would reside for Alpha port in pci_dac_cycles_ok()
definition.  IA64 and x86 could act similarly.  This was in fact
how I intended ports to implement pci_dac_cycles_ok().

   But there is an alternate solution for the SYM53C8XX driver by using up to
   16 x 32 bit segment registers. This would (will) allow to address for DMA
   16 x 4GB segments with all upper bits being settable for each 4GB segment.

Note, it relies on no 4GB crossing every occuring.  Jens and I have
decided that we will make this guarentee for devices always.  I know
of 2 devices already which have problems with this (Qlogic,FC and some
buggy variants of Tigon3 chips).

   I have this in my todo-list since months, but haven't had strong reasons
   for implementing it. The strongest reasons would be that I had access to
   64 bit machines with 64 bit PCI, but this isn't possible.

Look for someone to borrow a sparc64 system from.  Or, alternatively
send the patch to me for testing.

On sparc64, you will always be "testing all the bits" since each
DAC address to physical memory has:

	0xfffc000000000000

on the top bits.

Later,
David S. Miller
davem@redhat.com

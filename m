Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129831AbQLGQ7e>; Thu, 7 Dec 2000 11:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129708AbQLGQ7Y>; Thu, 7 Dec 2000 11:59:24 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:49419 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129632AbQLGQ7O>; Thu, 7 Dec 2000 11:59:14 -0500
Subject: Re: [Fwd: 2.4.0-test12-pre7]
To: randy.dunlap@intel.com (Randy Dunlap)
Date: Thu, 7 Dec 2000 16:30:35 +0000 (GMT)
Cc: torvalds@transmeta.com (torvalds@transmeta.com), rmk@arm.linux.org.uk,
        linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <3A2FB558.C4C13106@intel.com> from "Randy Dunlap" at Dec 07, 2000 08:05:44 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1443wL-0002dX-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think that Linus's patch is correct and that
> pci/setup_res.c::pdev_enable_device() shouldn't be doing this:
> 
> 	/* ??? Always turn on bus mastering.  If the device doesn't support
> 	   it, the bit will go into the bucket. */
> 	cmd |= PCI_COMMAND_MASTER;
> 
> First, the ??? makes it iffy.

I would agree. There is hardware you need to enable, reset, configure and
then enable the master bit on otherwise it simply starts spraying random
memory addresses with bus master transfers from uninitialised hardware
registers

> by a soft boot), then the device still knows some memory addresses
> to DMA into, but it shouldn't be using those.  This is addressed

Yep. Seen that happen with amd pcnet32 stuff when net booting. The net
booter left the chip prattling into main memory, not pretty

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

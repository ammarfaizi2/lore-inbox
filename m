Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292902AbSB0TwA>; Wed, 27 Feb 2002 14:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292881AbSB0Tv3>; Wed, 27 Feb 2002 14:51:29 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:59919 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292832AbSB0TuC>; Wed, 27 Feb 2002 14:50:02 -0500
Subject: Re: Dual P4 Xeon i860 system - lockups in 2.4 & no boot in 2.2
To: texas@ludd.luth.se (texas)
Date: Wed, 27 Feb 2002 20:04:51 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSU.4.33.0202272021090.23682-100000@father.ludd.luth.se> from "texas" at Feb 27, 2002 08:29:21 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16gAJn-0005fo-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> However, while booting 2.2.20, the following messages appear:

Make sure you have all the pnp os settings disabled in the bios - the 
below looks awfully like the IRQ routing wasnt set up by the bios

> failure to boot issue in 2.2 can be related to the random lockups in 2.4,
> could that be the case?

Who knows. "Random lockup" you can start at the power supply and work right
through the software - without any more info its very hard to debug

> Feb 27 18:33:22 db2 kernel: hm, page 000f5000 reserved twice.
> Feb 27 18:33:22 db2 kernel: hm, page 000f6000 reserved twice.
> Feb 27 18:33:22 db2 kernel: hm, page 000f1000 reserved twice.
> Feb 27 18:33:22 db2 kernel: hm, page 000f2000 reserved twice.

These are OK

> Feb 27 18:33:22 db2 kernel: OEM ID: OEM00000 Product ID: PROD00000000 APIC
> at: 0xFEE00000

Your BIOS vendor didn't even fill in the MP1.1 table with their info - 
confidence level in BIOS _zero_

> Feb 27 18:33:22 db2 kernel: Processor #0 Unknown CPU [15:2] APIC version
> 17

Curious but should be harmless

> Feb 27 18:33:22 db2 kernel: WARNING: No sibling found for CPU 0.
> Feb 27 18:33:22 db2 kernel: WARNING: No sibling found for CPU 1.

HT but not hyperthreading activated in the kernel (acpismp=force). Again
harmless just might be costing performance if your box is HT capable

> What looks weird here to my untrained eyes are the "Unknown bridge
> resource" messages and that my harddisks run on UDMA33 (the MPS v1.1
> instead of 1.4 is due to running the BIOS in "failsafe" mode - nothing
> that fixed the lockups though).

The unknown resource should be fine. The UDMA33 may well be because the
ide code in the base tree isnt up on i860 hardware yet.

Starting points I'd suggest:
	=	Try a non highmem kernel
	=	See if a single CPU kernel is reliable
		If it is consider swapping the cpus over and retesting
		(might point to software or hardware)
	=	Ensure your ventilation is fine and your PSU is approved
		and to spec for the system

You might want to run a memory test but thats normally seen as random
corruption/oopses not a hang and if you have ECC ram life should be fine

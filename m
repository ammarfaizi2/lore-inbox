Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129957AbQLISVD>; Sat, 9 Dec 2000 13:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131178AbQLISUn>; Sat, 9 Dec 2000 13:20:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37901 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129957AbQLISUk>;
	Sat, 9 Dec 2000 13:20:40 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200012091748.eB9HmaO29722@flint.arm.linux.org.uk>
Subject: Re: pdev_enable_device no longer used ?
To: groudier@club-internet.fr (Gérard Roudier)
Date: Sat, 9 Dec 2000 17:48:36 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), davej@suse.de,
        ink@jurassic.park.msu.ru (Ivan Kokshaysky),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.10.10012091500230.1058-100000@linux.local> from "Gérard Roudier" at Dec 09, 2000 03:26:43 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

=?ISO-8859-1?Q?G=E9rard_Roudier?= writes:
> As a result, in my opinion:
> 
> - A device that requires some non zero cache line size value lower than
> the right value for a given system and that actually use MWIs must not be
> supported on that system, unless we know that the bridge does alias MWI to
> MW. (If such a device can be configured for not using MWI, any value for 
> the PCI cache line size will not break).
> 
> - A driver that blindly shoe-horns some value for the cache-line size must
> be fixed. Basically, it should not change the value if it is not zero and,
> at least, warn user if it has changed the value because it was zero.
> 
> What are the strong reasons that let some POST softwares not fill properly
> the cache line size of PCI devices ?

Erm, stupid observation coming up.  Isn't this what the architecture-
specific 'pcibios_set_master' function is for?  To do any architecture
specific fiddling with the device.

Surely, writing to the cache line size is not something that a driver
should be doing, but something that the architecture specific code
should be doing.  Likewise, fiddling with latency timers without good
reason (eg, broken latency timers) surely is asking for problems.
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

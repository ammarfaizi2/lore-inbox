Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129038AbQKEMVm>; Sun, 5 Nov 2000 07:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129210AbQKEMVW>; Sun, 5 Nov 2000 07:21:22 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44549 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129038AbQKEMVM>;
	Sun, 5 Nov 2000 07:21:12 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200011051003.eA5A3TW06863@flint.arm.linux.org.uk>
Subject: Re: USB init order dependencies.
To: randy.dunlap@intel.com (Dunlap, Randy)
Date: Sun, 5 Nov 2000 10:03:29 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDC2C@orsmsx31.jf.intel.com> from "Dunlap, Randy" at Nov 04, 2000 05:36:51 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dunlap, Randy writes:
> While Jeff and I basically agree on the short-term
> solution (if one is still needed, altho I'm not aware of
> any init order problems in USB in 2.4.0-test10), my
> recollection of Linus's preference (without
> looking it up) is to remove the calls from init/main.c
> and to use __initcalls.

The problem for ARM is that Linux does a lot of the initialisation for
some machines, which basically means the hardware isn't setup for access
to the USB device if the USB initialisation was placed in init/main.c
(this initialisation is done by the very first initcall on ARM).  However,
that said, we may be able to get away with only adding hw_sa1100_init()
before the USB call, but this is only one family of the ARM machine types.

BTW, I've long lost track of what the original problem that sparked off
this thread was, does someone have a quick reference to it?  (please
reply in private mail).  Thanks.
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

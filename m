Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129352AbQKGSVp>; Tue, 7 Nov 2000 13:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129505AbQKGSVf>; Tue, 7 Nov 2000 13:21:35 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54802 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129352AbQKGSVW>;
	Tue, 7 Nov 2000 13:21:22 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200011070726.eA77QfC20051@flint.arm.linux.org.uk>
Subject: Re: USB init order dependencies.
To: randy.dunlap@intel.com (Dunlap, Randy)
Date: Tue, 7 Nov 2000 07:26:41 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDC46@orsmsx31.jf.intel.com> from "Dunlap, Randy" at Nov 06, 2000 03:53:26 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dunlap, Randy writes:
> I'm not following your argument very well.  I've read it
> and reread it several times.
> Does adding a call to usb_init() in init/main.c cause
> USB to be init 2 times?

No.  As I said elsewhere in this thread, the USB OHCI chip is not accessible
until other board-specific initialisation has happened.  This is done via an
initcall.  Unfortunately, moving usb_init() back into init/main.c will mean
that USB is again initialised before any initcalls, which means for these
boards USB will be non-functional without additional changes over and above
just moving usb_init().

I hope this helps you understand the problem.
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

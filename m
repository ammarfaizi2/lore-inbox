Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130760AbQKQR1W>; Fri, 17 Nov 2000 12:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130839AbQKQR1M>; Fri, 17 Nov 2000 12:27:12 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52498 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S130760AbQKQR1I>;
	Fri, 17 Nov 2000 12:27:08 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200011171656.QAA01320@raistlin.arm.linux.org.uk>
Subject: Re: VGA PCI IO port reservations
To: bgerst@didntduck.org (Brian Gerst)
Date: Fri, 17 Nov 2000 16:56:47 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, mj@suse.cz
In-Reply-To: <3A156116.65CDBBE9@didntduck.org> from "Brian Gerst" at Nov 17, 2000 11:47:18 AM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst writes:
> This is an artifact from the ISA 10-bit IO bus.  Many ISA cards do not
> decode all 16 address bits so you get aliases of the 0x100-0x3ff region
> throughout IO space.  PCI cards should only use the first 256 ports of
> any 1k block to avoid aliases unless they claim the base alias.  For
> example, all the xxe8 addresses for the S3 are aliases of 0x02e8 to an
> ISA card.  Video cards are an exception to the general rule because they
> have to support all the legacy VGA crap.

No.  All xxe8 addresses access specific registers.  For example:

  0x9ea8 is the drawing command
  0xa2e8 is the background colour register
  0xa6e8 is the foreground colour register

So, as you see they aren't aliases.

> /*
>  * We need to avoid collisions with `mirrored' VGA ports
>  * and other strange ISA hardware, so we always want the
>  * addresses to be allocated in the 0x000-0x0ff region
>  * modulo 0x400.
>  *
>  * Why? Because some silly external IO cards only decode
>  * the low 10 bits of the IO address. The 0x00-0xff region
>  * is reserved for motherboard devices that decode all 16
>  * bits, so it's ok to allocate at, say, 0x2800-0x28ff,
>  * but we want to try to avoid allocating at 0x2900-0x2bff
>  * which might have be mirrored at 0x0100-0x03ff..
>  */

Ah ha, I'll nick that for the ARM stuff then.  Thanks for pointing it out.
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

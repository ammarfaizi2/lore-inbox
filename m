Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130562AbRAMTD5>; Sat, 13 Jan 2001 14:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131614AbRAMTDi>; Sat, 13 Jan 2001 14:03:38 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39185 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S131131AbRAMTDc>;
	Sat, 13 Jan 2001 14:03:32 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200101131903.f0DJ32M17078@flint.arm.linux.org.uk>
Subject: Re: Where did vm_operations_struct->unmap in 2.4.0 go?
To: dwmw2@infradead.org (David Woodhouse)
Date: Sat, 13 Jan 2001 19:03:02 +0000 (GMT)
Cc: kaos@ocs.com.au (Keith Owens), phoenix@minion.de (Christian Zander),
        linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
In-Reply-To: <Pine.LNX.4.30.0101131413190.21182-100000@imladris.demon.co.uk> from "David Woodhouse" at Jan 13, 2001 03:09:40 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse writes:
> We don't need to overdesign it. get_module_symbol() basically provided
> this for us. The only thing really wrong with it was the lack of use
> count handling, which I fixed a while ago.

And the fact that it doesn't work if you turn module support off, which
you'd want to do on an embedded kernel.  Unfortunately, this is one of
the times when you do want the MTD stuff.  You either have to put up
with no MTD support, write your own, or put up with the extra space of
module symbols.

Therefore, get_module_symbol() as it stood was the wrong interface to
use, and I completely agree with Keiths decision to remove it.  However,
I'm not sure that the inter_* stuff that replaced it is much better for
the reasons David has highlighted previously wrt link ordering.
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

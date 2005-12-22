Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965009AbVLVNHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965009AbVLVNHv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 08:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965016AbVLVNHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 08:07:51 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:40716 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S965009AbVLVNHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 08:07:50 -0500
Date: Thu, 22 Dec 2005 13:07:44 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Meelis Roos <mroos@linux.ee>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Serial: bug in 8250.c when handling PCI or other level triggers
Message-ID: <20051222130744.GA31339@flint.arm.linux.org.uk>
Mail-Followup-To: Meelis Roos <mroos@linux.ee>, alan@lxorguk.ukuu.org.uk,
	linux-kernel@vger.kernel.org
References: <1134573803.25663.35.camel@localhost.localdomain> <20051214160700.7348A14BEA@rhn.tartu-labor> <20051214172445.GF7124@flint.arm.linux.org.uk> <Pine.SOC.4.61.0512212221310.651@math.ut.ee> <20051221221516.GK1736@flint.arm.linux.org.uk> <Pine.SOC.4.61.0512221231430.6200@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOC.4.61.0512221231430.6200@math.ut.ee>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2005 at 12:35:30PM +0200, Meelis Roos wrote:
> But I might have some more information:
> 
> The first bunch of messages did not happen on serial port detection but 
> when "discover" ran and opened the serial port.
> 
> The second bunch of messages happened when minicom opened the port. I 
> then modprobed tulip to see separating lines in dmesg. Then I used cisco 
> remote console and no messages appeared. Then I powered down the cisco 
> and then quited minicom. This took time and produced another bunch of 
> messages.

Thanks for spending the time trying to track this down.

I'm still grasping at straws - it is plainly clear to me from the
debug traces that your machine is _not_ doing what the C code is
asking it to do.

Basically, the characteristics seem to be:

 * if the UART indicates no IRQ on invocation of the interrupt
   handler, we repeatedly loop in the handler and eventually
   hit this "too much work" problem.

 * if the UART indicates IRQ on invocation of the interrupt, and
   subsequently no IRQ, we exit the interrupt handler as per the
   code.

I notice you're using gcc 4.0.3.  Have you tried other compiler
versions?

Are you building the kernel with any additional compiler flags?

Are there any other patches applied to the 8250.c file apart from my
debugging patch?  What's the diff between a vanilla Linus kernel and
the one you built?

If it isn't a compiler bug and there aren't any other patches applied,
I have no idea what to suggest next, apart from your computer seemingly
following a different set of rules to the rest of the universe.  Maybe
you could donate it to some quantum physics lab? 8)

If anyone else has any suggestions, please jump in now.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

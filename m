Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261337AbULMUSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbULMUSp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 15:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbULMUPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 15:15:16 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:36101 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262340AbULMULt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 15:11:49 -0500
Date: Mon, 13 Dec 2004 20:11:43 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Stefan Seyfried <seife@suse.de>,
       Con Kolivas <kernel@kolivas.org>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: dynamic-hz
Message-ID: <20041213201142.G24748@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Stefan Seyfried <seife@suse.de>, Con Kolivas <kernel@kolivas.org>,
	Pavel Machek <pavel@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrea Arcangeli <andrea@suse.de>
References: <20041211142317.GF16322@dualathlon.random> <20041212163547.GB6286@elf.ucw.cz> <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org> <41BD483B.1000704@suse.de> <20041213135820.A24748@flint.arm.linux.org.uk> <1102949565.2687.2.camel@localhost.localdomain> <20041213162355.E24748@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041213162355.E24748@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Mon, Dec 13, 2004 at 04:23:55PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2004 at 04:23:55PM +0000, Russell King wrote:
> There is another twist here though - the Linux kernel kicks itself out
> of idle mode and into some other thread multiple times a second while
> the system is idle.  So far, in all my Linux kernel experience, I've
> yet to see a kernel where it's possible to stay in the idle thread
> for more than half a second.  (The ARM kernels I run are always
> configured with IDLE LED support, so I can _see_ when it gets kicked
> out of the idle thread.)

For futher information only, analysing this further, we keep switching
to the events/0 thread, and it seems to be mainly for:

  - cursor handling every 200ms
  - slab cache reaping about every 2s

The cursor timer is firing all the time that you have a fbcon console
registered, whether or not the cursor should be displayed.  Someone
looking to save power should probably tackle this such that the cursor
timer doesn't needlessly fire.

But I guess the cellphone people would be more interested in this
problem than the big iron desktop-breaking in-need-of-three-phase-supply
boxen. 8)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core

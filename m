Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263142AbVG3UGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263142AbVG3UGY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 16:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263122AbVG3UEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 16:04:22 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:37136 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261487AbVG3UDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 16:03:15 -0400
Date: Sat, 30 Jul 2005 21:03:06 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Hugh Dickins <hugh@veritas.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Ritz <daniel.ritz@gmx.ch>, linux-kernel@vger.kernel.org
Subject: Re: revert yenta free_irq on suspend
Message-ID: <20050730210306.D26592@flint.arm.linux.org.uk>
Mail-Followup-To: Hugh Dickins <hugh@veritas.com>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Daniel Ritz <daniel.ritz@gmx.ch>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0507301952350.3319@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.61.0507301952350.3319@goblin.wat.veritas.com>; from hugh@veritas.com on Sat, Jul 30, 2005 at 08:10:33PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 30, 2005 at 08:10:33PM +0100, Hugh Dickins wrote:
> Please revert the yenta free_irq on suspend patch (below)
> which went into 2.6.13-rc4 after 2.6.13-rc3-git9.
> 
> Sorry Daniel, you may have a box on which resume doesn't work without
> it, but on my laptop APM resume from RAM now fails to work because of
> it - locks up solid.  The patch sounded rather fishy when it went in,
> but I've done an unprejudiced bisection and this turns out to be the
> culprit.  Perhaps it needs something more (I can try further patches),
> but as it stands it's unsuitable for 2.6.13.

What this probably means is that we need some way to turn off interrupts
from devices on suspend, and on resume, keep them off until drivers
have had a chance to quiesce all devices, turn them back on, and then
do full resume.

The "quiesce" stage needs to take account of whether devices are
accessible (eg, USB mice and keyboards won't be because the USB host
controller isn't resumed.)

(and no I don't have a patch for this - I think this requires another
rework of the PM subsystem and drivers.) ;(

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

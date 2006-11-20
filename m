Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965818AbWKTNFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965818AbWKTNFE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 08:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965828AbWKTNFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 08:05:04 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:29963 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S965818AbWKTNFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 08:05:03 -0500
Date: Mon, 20 Nov 2006 13:04:56 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Stefan Roese <ml@stefan-roese.de>, linux-kernel@vger.kernel.org,
       linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] serial: Use real irq on UART0 (IRQ = 0) on PPC4xx systems
Message-ID: <20061120130455.GB22330@flint.arm.linux.org.uk>
Mail-Followup-To: Alan <alan@lxorguk.ukuu.org.uk>,
	Stefan Roese <ml@stefan-roese.de>, linux-kernel@vger.kernel.org,
	linuxppc-embedded@ozlabs.org
References: <200611201200.36780.ml@stefan-roese.de> <20061120114248.60bb0869@localhost.localdomain> <200611201255.37754.ml@stefan-roese.de> <20061120121015.2fb667d0@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061120121015.2fb667d0@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2006 at 12:10:15PM +0000, Alan wrote:
> On Mon, 20 Nov 2006 12:54:32 +0100 (MET)
> Stefan Roese <ml@stefan-roese.de> wrote:
> > Let's see, if I got this right. You mean that on such a platform, where 0 is a 
> > valid physical IRQ, we should assign another value as virtual IRQ number (not 
> > 0 and not -1 of course). And then the platform "pic" implementation should 
> > take care of the remapping of these virtual IRQ numbers to the physical 
> > numbers.
> > 
> > Correct?
> 
> Absolutely correct in all the detail.

Since IRQ0 is not valid, can we arrange for the generic interrupt
infrastructure to always fail it's allocation, and then remove the
utterly unused bloatful irq_desc[0] ?

Didn't think so since x86 folk would scream.  Wait a moment, x86 can
map IRQ0 to some other number for the timer interrupt, just like
other architectures are being forced to map their UART interrupts.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266311AbUFZRP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266311AbUFZRP5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 13:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266314AbUFZRP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 13:15:57 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:28421 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266311AbUFZRPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 13:15:55 -0400
Date: Sat, 26 Jun 2004 18:15:52 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>, mcgrof@ruslug.rutgers.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: Assuming someone else called the IRQ
Message-ID: <20040626181552.C30532@flint.arm.linux.org.uk>
Mail-Followup-To: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
	mcgrof@ruslug.rutgers.edu, linux-kernel@vger.kernel.org
References: <200406261808.31860.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200406261808.31860.s0348365@sms.ed.ac.uk>; from s0348365@sms.ed.ac.uk on Sat, Jun 26, 2004 at 06:08:31PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 26, 2004 at 06:08:31PM +0100, Alistair John Strachan wrote:
> Every kernel in the 2.6 serious so far has exhibited the same problem; after 
> some time of running my desktop system, I get:
> 
> Assuming someone else called the IRQ
>...
>  19:    8748235   IO-APIC-level  ohci1394, yenta, eth0

You don't say what eth0 is.  At a guess, it's a prism54 card, because the
only place I find that message in the kernel is in the prism54 driver:

drivers/net/wireless/prism54/islpci_dev.c:
	printk(KERN_DEBUG "Assuming someone else called the IRQ\n");

I'd imagine that the OHCI1394 generates a fair number of interrupts,
so... this highlights the problem of leaving debugging printk's,
even at KERN_DEBUG level in a driver interrupt path.

At a guess, Luis R. Rodriguez may be the maintainer for prism54,
so...

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core

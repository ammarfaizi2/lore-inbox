Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751259AbWGWSaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbWGWSaI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 14:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbWGWSaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 14:30:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35482 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751259AbWGWSaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 14:30:06 -0400
Date: Sun, 23 Jul 2006 11:30:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Cross platform method for detecting hot unplug in irq handler
Message-Id: <20060723113001.3fdd426d.akpm@osdl.org>
In-Reply-To: <44C37565.6090009@superbug.co.uk>
References: <44C37565.6090009@superbug.co.uk>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jul 2006 14:11:01 +0100
James Courtier-Dutton <James@superbug.co.uk> wrote:

> Hi,
> 
> I am writing a driver for a PCMCIA device.
> When the card is removed, the driver's IRQ handler is called.
> The first thing the IRQ handler does is read a status register from the
> card's IOPORT. On the ia32 (i386) platform, the resulting status read
> will return 0xffffffff. If the driver reads this value, it assumes the
> card has been removed and acts accordingly.
> 
> Is this a reliable way of detecting PCMCIA or Hotplug card removal
> inside an IRQ handler?
> Is it consistent cross platforms. E.g. ia64, amd64, PPC, MIPS etc.?
> Does a more reliable detection method exist in the kernel?

Cardbus has detection pins, ad they can be queried via the controller.  But
it's too slow and afaik cardbus will reliably rern 0xffffffff for a removed
card.

Lots of drivers treat a read of all-ones as indicating a removed card.  It
works.

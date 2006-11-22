Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756935AbWKVHJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756935AbWKVHJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 02:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756936AbWKVHJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 02:09:27 -0500
Received: from gate.crashing.org ([63.228.1.57]:55717 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1756934AbWKVHJ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 02:09:26 -0500
Subject: Re: [PATCH] Disable INTx when enabling MSI in forcedeth
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Daniel Barkalow <barkalow@iabervon.org>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, David Miller <davem@davemloft.net>,
       Roland Dreier <rdreier@cisco.com>, Ayaz Abdulla <aabdulla@nvidia.com>
In-Reply-To: <Pine.LNX.4.64.0611211839540.3338@woody.osdl.org>
References: <Pine.LNX.4.64.0611212118540.20138@iabervon.org>
	 <Pine.LNX.4.64.0611211839540.3338@woody.osdl.org>
Content-Type: text/plain
Date: Wed, 22 Nov 2006 18:09:45 +1100
Message-Id: <1164179385.5653.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-21 at 18:42 -0800, Linus Torvalds wrote:
> 
> On Tue, 21 Nov 2006, Daniel Barkalow wrote:
> >
> > My nVidia ethernet card doesn't disable its own INTx when MSI is
> > enabled. This causes a steady stream of spurious interrupts that
> > eventually kills my SATA IRQ if MSI is used with forcedeth, which is
> > true by default. Simply disabling the INTx interrupt takes care of it.
> > 
> > This is against -stable, and would be suitable once someone who knows the 
> > code verifies that it's correct.
> 
> I _really_ think that we should do this in pci_msi_enable().

Agreed.

> Screw cards that are not PCI-2.3 compliant - just make the rule be that if 
> you use MSI, you _have_ to allow us to set the disable-INTx bit. It's then 
> up to the drivers to decide if they can use MSI or not.
> 
> (Even a number of cards that are not PCI-2.3 may simply not _implement_ 
> the disable-INTx bit, and in that case, they can use MSI if they disable 
> INTx automatically - the ).
> 
> Comments?

Do we know of any card that wants MSIs _and_ uses that bit for some
non-compliant purpose ?

Ben.


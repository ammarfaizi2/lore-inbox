Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031696AbWLABNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031696AbWLABNl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 20:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031692AbWLABNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 20:13:36 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:41399 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1031689AbWLABNc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 20:13:32 -0500
Date: Thu, 30 Nov 2006 17:16:57 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Daniel Barkalow <barkalow@iabervon.org>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, David Miller <davem@davemloft.net>,
       Roland Dreier <rdreier@cisco.com>, Ayaz Abdulla <aabdulla@nvidia.com>
Subject: Re: [PATCH] Disable INTx when enabling MSI in forcedeth
Message-ID: <20061201011657.GD6602@sequoia.sous-sol.org>
References: <Pine.LNX.4.64.0611212118540.20138@iabervon.org> <Pine.LNX.4.64.0611211839540.3338@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611211839540.3338@woody.osdl.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Torvalds (torvalds@osdl.org) wrote:
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
> 
> Screw cards that are not PCI-2.3 compliant - just make the rule be that if 
> you use MSI, you _have_ to allow us to set the disable-INTx bit. It's then 
> up to the drivers to decide if they can use MSI or not.
> 
> (Even a number of cards that are not PCI-2.3 may simply not _implement_ 
> the disable-INTx bit, and in that case, they can use MSI if they disable 
> INTx automatically - the ).

Hmm, what do you recommend we do in the meantime, since it's a real
problem and the -stable tree has no fix?  Only issue I had with Daniel's
patch is that it's only half-tested.

thanks,
-chris

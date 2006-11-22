Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031268AbWKVCnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031268AbWKVCnz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 21:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031449AbWKVCnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 21:43:55 -0500
Received: from smtp.osdl.org ([65.172.181.25]:31924 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1031268AbWKVCny (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 21:43:54 -0500
Date: Tue, 21 Nov 2006 18:42:25 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Daniel Barkalow <barkalow@iabervon.org>
cc: linux-kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>,
       David Miller <davem@davemloft.net>, Roland Dreier <rdreier@cisco.com>,
       Ayaz Abdulla <aabdulla@nvidia.com>
Subject: Re: [PATCH] Disable INTx when enabling MSI in forcedeth
In-Reply-To: <Pine.LNX.4.64.0611212118540.20138@iabervon.org>
Message-ID: <Pine.LNX.4.64.0611211839540.3338@woody.osdl.org>
References: <Pine.LNX.4.64.0611212118540.20138@iabervon.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 21 Nov 2006, Daniel Barkalow wrote:
>
> My nVidia ethernet card doesn't disable its own INTx when MSI is
> enabled. This causes a steady stream of spurious interrupts that
> eventually kills my SATA IRQ if MSI is used with forcedeth, which is
> true by default. Simply disabling the INTx interrupt takes care of it.
> 
> This is against -stable, and would be suitable once someone who knows the 
> code verifies that it's correct.

I _really_ think that we should do this in pci_msi_enable().

Screw cards that are not PCI-2.3 compliant - just make the rule be that if 
you use MSI, you _have_ to allow us to set the disable-INTx bit. It's then 
up to the drivers to decide if they can use MSI or not.

(Even a number of cards that are not PCI-2.3 may simply not _implement_ 
the disable-INTx bit, and in that case, they can use MSI if they disable 
INTx automatically - the ).

Comments?

		Linus


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163538AbWLGWbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163538AbWLGWbf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 17:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163539AbWLGWbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 17:31:35 -0500
Received: from iabervon.org ([66.92.72.58]:4279 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163538AbWLGWbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 17:31:35 -0500
Date: Thu, 7 Dec 2006 17:31:33 -0500 (EST)
From: Daniel Barkalow <barkalow@iabervon.org>
To: gregkh@suse.de
cc: Jeff Garzik <jeff@garzik.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Disable INTx when enabling MSI
Message-ID: <Pine.LNX.4.64.0612071659010.20138@iabervon.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some device manufacturers seem to think it's the OS's responsibility to 
disable legacy interrupt delivery when using MSI. If the driver doesn't 
handle it (which they generally don't), and the device isn't PCI-Express, 
a steady stream of legacy interrupts will be delivered in addition to the 
MSI ones, eventually leading to the legacy IRQ getting disabled, which 
kills any device that shares it.

Jeff proposed a patch in http://lkml.org/lkml/2006/11/21/332 when Linus 
wanted to do it in the PCI layer, but nobody seems to have told the actual 
PCI maintainer.

I'm trying to get a patch into -stable to do pci_intx in exactly the same 
situations, but only for forcedeth (which is the device that's causing 
problems for me), but that requires that the real solution be merged in 
the mainline.

	-Daniel
*This .sig left intentionally blank*

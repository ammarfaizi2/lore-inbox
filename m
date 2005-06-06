Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261792AbVFGABl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261792AbVFGABl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 20:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbVFGAAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 20:00:48 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:27582
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261792AbVFFX6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 19:58:43 -0400
Date: Mon, 06 Jun 2005 16:58:19 -0700 (PDT)
Message-Id: <20050606.165819.74748316.davem@davemloft.net>
To: jgarzik@pobox.com
Cc: gregkh@suse.de, tom.l.nguyen@intel.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, roland@topspin.com
Subject: Re: pci_enable_msi() for everyone?
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <42A4E213.8050102@pobox.com>
References: <42A4D771.7080400@pobox.com>
	<20050606231325.GA11610@suse.de>
	<42A4E213.8050102@pobox.com>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Garzik <jgarzik@pobox.com>
Date: Mon, 06 Jun 2005 19:53:55 -0400

> A technology (MSI) allows one to more efficiently call interrupt 
> handlers, with fewer bus reads...  and you want to add a test to each 
> interrupt handler -- a test which adds several bus reads to the hot path 
> of every MSI driver?

I think he's saying something different.

He is saying this test goes in the spot where you select
which interrupt handler to register, in place of the current
logic which call pci_enable_msi() and checks the return value.

MSI unaware drivers are OK because they can only assume
looser semantics (shared interrupts possible, no DMA ordering
guarentees wrt. interrupt delivery etc.) in their interrupt
handlers.

So I guess what Greg is proposing is not a bad idea afterall.

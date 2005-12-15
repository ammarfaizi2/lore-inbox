Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750995AbVLOVMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbVLOVMF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 16:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751071AbVLOVMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 16:12:05 -0500
Received: from gate.crashing.org ([63.228.1.57]:37815 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750995AbVLOVMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 16:12:03 -0500
Subject: Re: MSI and driver APIs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Roland Dreier <rdreier@cisco.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>
In-Reply-To: <adamzj2nk76.fsf@cisco.com>
References: <1134617893.16880.17.camel@gaston>  <adamzj2nk76.fsf@cisco.com>
Content-Type: text/plain
Date: Fri, 16 Dec 2005 08:08:02 +1100
Message-Id: <1134680882.16880.37.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It seems OK to me to say that a driver's probe routine could be called
> with MSI enabled.  A naive driver would just use the irq number from
> the PCI device struct and never care whether interrupts were INTx or
> MSI.  This does fall down for hardware like tg3, where something
> beyond the simple PCI header manipulation is required to turn on MSI use.
> 
> Full MSI-X would be much harder to handle transparently, since
> handling multiple different interrupts typically requires a lot more
> logic in the driver.

You can have multiple MSIs too (they just have to be contiguous in
numbers and aligned on the nearest power of 2).

I'm tempted to leave them enabled and only disable them when
request_irq() is done on the legacy INTx... Does anybody see a problem
with this approach ?

Ben.



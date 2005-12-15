Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbVLOVWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbVLOVWS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 16:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbVLOVWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 16:22:18 -0500
Received: from gate.crashing.org ([63.228.1.57]:51895 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751106AbVLOVWS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 16:22:18 -0500
Subject: Re: MSI and driver APIs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Roland Dreier <rdreier@cisco.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>
In-Reply-To: <adaek4enjoz.fsf@cisco.com>
References: <1134617893.16880.17.camel@gaston> <adamzj2nk76.fsf@cisco.com>
	 <1134680882.16880.37.camel@gaston>  <adaek4enjoz.fsf@cisco.com>
Content-Type: text/plain
Date: Fri, 16 Dec 2005 08:18:17 +1100
Message-Id: <1134681498.16880.39.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-15 at 13:18 -0800, Roland Dreier wrote:
>     Benjamin> You can have multiple MSIs too (they just have to be
>     Benjamin> contiguous in numbers and aligned on the nearest power
>     Benjamin> of 2).
> 
> Good point.  I just got too used to the x86-ism of the current MSI
> code, which can't handle allocating contiguous vectors.
> 
>     Benjamin> I'm tempted to leave them enabled and only disable them
>     Benjamin> when request_irq() is done on the legacy INTx... Does
>     Benjamin> anybody see a problem with this approach ?
> 
> You might run into trouble on hardware (think tg3 or its ilk again)
> where you might have to do something beyond disabling MSI in the PCI
> header to switch the chip out of MSI mode.

But won't the driver call pci_enable/disable_msi() in those cases ? If
not, it's easy enough to add (explicit disable rather than not-enabled).

I'm mostly concerned about "dumb" drivers that don't know about MSI at
all...

Ben.



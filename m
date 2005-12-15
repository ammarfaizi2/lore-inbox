Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750947AbVLOWA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbVLOWA0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 17:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbVLOWA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 17:00:26 -0500
Received: from gate.crashing.org ([63.228.1.57]:28856 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750947AbVLOWA0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 17:00:26 -0500
Subject: Re: MSI and driver APIs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: rdreier@cisco.com, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <20051215.134216.18400210.davem@davemloft.net>
References: <adamzj2nk76.fsf@cisco.com> <1134680882.16880.37.camel@gaston>
	 <adaek4enjoz.fsf@cisco.com>  <20051215.134216.18400210.davem@davemloft.net>
Content-Type: text/plain
Date: Fri, 16 Dec 2005 08:56:06 +1100
Message-Id: <1134683766.16880.45.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I think because of kinds of cases and other issues, going with
> MSI by default is a non-starter.
> 
> Perhaps a better approach is to use a flag in the pci_driver_struct or
> similar that says "you can have MSI enabled by default".  And
> gradually convert drivers over which we know will handle it properly.
> 
> Doing some tom foolery with request_irq() sounds like a half-baked
> idea at best.  The biggest argument against that is that this is
> not a PCI interface, so expecting it to have PCI side effects is
> really asking for trouble.

Hrm... true enough. I'll look into the driver flags option. I can
probably always fallback to just turning MSI off everywhere at boot time
and "reserve" an MSI number per device by simply holding on what was
allocated by the firmware.

I was thinking that I might be able to not return the firmware allocated
MSIs to the firmware, but just disable MSI in the device config space
myself and keep track that N MSIs are still associated with the device
even if not currently used. However, the way the IBM architecture is
worded, it's unclear if that will work, that is, it's unclear that if I
don't actually disable the MSIs with a firmware call (and thus return
them), the interrupt controller will accept the INTx, chances are that
it won't in fact.

Ben.



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbVLOVnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbVLOVnN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 16:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbVLOVnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 16:43:13 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:40411
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751128AbVLOVnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 16:43:11 -0500
Date: Thu, 15 Dec 2005 13:42:16 -0800 (PST)
Message-Id: <20051215.134216.18400210.davem@davemloft.net>
To: rdreier@cisco.com
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: MSI and driver APIs
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <adaek4enjoz.fsf@cisco.com>
References: <adamzj2nk76.fsf@cisco.com>
	<1134680882.16880.37.camel@gaston>
	<adaek4enjoz.fsf@cisco.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 15 Dec 2005 13:18:04 -0800

>     Benjamin> I'm tempted to leave them enabled and only disable them
>     Benjamin> when request_irq() is done on the legacy INTx... Does
>     Benjamin> anybody see a problem with this approach ?
> 
> You might run into trouble on hardware (think tg3 or its ilk again)
> where you might have to do something beyond disabling MSI in the PCI
> header to switch the chip out of MSI mode.

I think because of kinds of cases and other issues, going with
MSI by default is a non-starter.

Perhaps a better approach is to use a flag in the pci_driver_struct or
similar that says "you can have MSI enabled by default".  And
gradually convert drivers over which we know will handle it properly.

Doing some tom foolery with request_irq() sounds like a half-baked
idea at best.  The biggest argument against that is that this is
not a PCI interface, so expecting it to have PCI side effects is
really asking for trouble.

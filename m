Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750917AbVLOVHf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbVLOVHf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 16:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbVLOVHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 16:07:35 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:23703 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1750858AbVLOVHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 16:07:34 -0500
X-IronPort-AV: i="3.99,258,1131350400"; 
   d="scan'208"; a="685094799:sNHT31642830"
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>
Subject: Re: MSI and driver APIs
X-Message-Flag: Warning: May contain useful information
References: <1134617893.16880.17.camel@gaston>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 15 Dec 2005 13:07:09 -0800
Message-ID: <adamzj2nk76.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 15 Dec 2005 21:07:09.0579 (UTC) FILETIME=[830C95B0:01C601BB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Benjamin> I've been looking at MSI/MSI-X support on POWER
    Benjamin> platforms, both under hypervisor or directly on machines
    Benjamin> like the new G5s and I found out that the current code
    Benjamin> in drivers/pci isn't nearly as generic as it claims to
    Benjamin> be and cannot really be re-used as is.

Excellent!  I've always wanted to find time to make the code generic
and add MSI support for some new platform like PPC 440SPe, but it's
never made it very far up my list.

    Benjamin> Thus I would very much like to change the semantics so
    Benjamin> that a driver can be entered with MSIs already assigned
    Benjamin> and enabled, though it has the capability to request
    Benjamin> more MSIs and/or to disable them if the chipset is
    Benjamin> buggy. That could be done either by adding a callback to
    Benjamin> check if MSIs are enabled for a given device for
    Benjamin> example...

It seems OK to me to say that a driver's probe routine could be called
with MSI enabled.  A naive driver would just use the irq number from
the PCI device struct and never care whether interrupts were INTx or
MSI.  This does fall down for hardware like tg3, where something
beyond the simple PCI header manipulation is required to turn on MSI use.

Full MSI-X would be much harder to handle transparently, since
handling multiple different interrupts typically requires a lot more
logic in the driver.

 - R.

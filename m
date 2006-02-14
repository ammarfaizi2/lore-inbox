Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422786AbWBNVUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422786AbWBNVUW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 16:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422796AbWBNVUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 16:20:22 -0500
Received: from [194.90.237.34] ([194.90.237.34]:5786 "EHLO mtlexch01.mtl.com")
	by vger.kernel.org with ESMTP id S1422786AbWBNVUV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 16:20:21 -0500
Date: Tue, 14 Feb 2006 23:21:45 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: Roland Dreier <rolandd@cisco.com>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: AMD 8131 and MSI quirk
Message-ID: <20060214212145.GC14113@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <524q799p2t.fsf@cisco.com> <20060214165222.GC12974@mellanox.co.il> <1139940226.18044.3.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1139940226.18044.3.camel@whizzy>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 14 Feb 2006 21:22:12.0265 (UTC) FILETIME=[B84A4990:01C631AC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kristen Accardi <kristen.c.accardi@intel.com>:
> > It turns out AMD 8131 quirk only affects MSI for devices behind the 8131
> > bridge.  Handle this by adding a flags field in pci_bus, inherited from
> > parent to child.
> 
> It seems like we have a way to turn of msi already (the no_msi bit in
> the pci_dev structure).  Does it make sense to just have the child bus
> pci_dev structure inherit the no_msi bit from the parent's pci_dev
> structure when doing an allocation, or does that unnecessarily remove
> the msi capability for devices that may not need it?
> 
> Kristen

This bit is already used to mean that msi is disabled for a specific device,
which appears to be a PCI Express to PCI bridge (PCI_DEVICE_ID_INTEL_PXH).  So
it seems that disabling MSI for child devices as well might break things (i.e.
disable msi unnecessarily).
Working for Intel, I guess you would know about the PCI_DEVICE_ID_INTEL_PXH
best: what do you say?

In my opinion, it is cleaner to separate the two concepts: suppress msi
for child devices versus suppress it for the specific device.

Right?

-- 
Michael S. Tsirkin
Staff Engineer, Mellanox Technologies

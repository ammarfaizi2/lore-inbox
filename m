Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129250AbRBGVem>; Wed, 7 Feb 2001 16:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129516AbRBGVeX>; Wed, 7 Feb 2001 16:34:23 -0500
Received: from palrel1.hp.com ([156.153.255.242]:14091 "HELO palrel1.hp.com")
	by vger.kernel.org with SMTP id <S129250AbRBGVeV>;
	Wed, 7 Feb 2001 16:34:21 -0500
Message-Id: <200102072136.NAA05601@milano.cup.hp.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0 pdev_enable_device() call in setup-bus.c 
In-Reply-To: Your message of "Thu, 08 Feb 2001 00:12:02 PST."
             <20010208001202.A976@jurassic.park.msu.ru> 
Date: Wed, 07 Feb 2001 13:36:46 -0800
From: Grant Grundler <grundler@cup.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Kokshaysky wrote:
> Mainly because there are driverless devices like display adapters,
> PCI bridges, or PCI devices with legacy drivers (IDE, for example).

Ok. It seems that all of those would have to interact with
the PCI code someplace. And that's were pci_enable_device()
could be called. eg. PCI Bridges could be handled in it's
"driver": pci_setup_bridge().


> OTOH, pdev_enable_device() most likely will be removed, but
> it's 2.5 material.

Agreed - standardizing the enable path would be good for above devices.

I'd like to see arch hooks added for stuff like default latency and
PCI_BRIDGE_CONTROL. My gut feeling is the "root" struct pci_bus
allocation and initialization should be done by arch specific code
*before* pci_scan_bus() is called. That would allow cfg space defaults
to be set to arch specific values on a per bus basis *before* doing
the bus walks instead of hacking this in pci_bus_fixup() later.

thanks,
grant

Grant Grundler
parisc-linux {PCI|IOMMU|SMP} hacker
+1.408.447.7253
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

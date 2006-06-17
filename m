Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751676AbWFQQPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676AbWFQQPw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 12:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751677AbWFQQPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 12:15:52 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:46249 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1751675AbWFQQPv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 12:15:51 -0400
Message-ID: <44942AA6.10205@myri.com>
Date: Sat, 17 Jun 2006 12:15:34 -0400
From: Brice Goglin <brice@myri.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
CC: linux-pci@atrey.karlin.mff.cuni.cz, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Whitelist chipsets supporting MSI and check Hyper-transport
 capabilities
References: <4493709A.7050603@myri.com> <200606171634.24270.s0348365@sms.ed.ac.uk>
In-Reply-To: <200606171634.24270.s0348365@sms.ed.ac.uk>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan wrote:
> On Saturday 17 June 2006 04:01, Brice Goglin wrote:
>   
> I tried your patch on 2.6.17-rc6 (fixed up a view rejects) in an attempt to 
> get MSI working with my forcedeth NIC, which advertises the capability. The 
> kernel now gives me the following:
>   

Well, the aim of my patch is to stop enabling MSI by default, and try to
find out when we can and when we cannot use MSI. 2.6.17 will only
disable MSI on a few chipsets. My patch will disable on all chipsets but
Intel and those having Hypertransport MSI capabilities (Serverworks
HT2000 and nVidia CK804). Thus, you cannot expect MSI to be enabled with
my patch if it was not before :/

> PCI: Found MSI HT mapping on 0000:00:0b.0
> PCI: Found MSI HT mapping on 0000:00:00.0
> PCI: MSI quirk detected. PCI_BUS_FLAGS_MSI set for 0000:00:0b.0 subordinate 
> bus.
> PCI: Found MSI HT mapping on 0000:00:0c.0
> PCI: Found MSI HT mapping on 0000:00:00.0
> PCI: MSI quirk detected. PCI_BUS_FLAGS_MSI set for 0000:00:0c.0 subordinate 
> bus.
> PCI: Found MSI HT mapping on 0000:00:0d.0
> PCI: Found MSI HT mapping on 0000:00:00.0
> PCI: MSI quirk detected. PCI_BUS_FLAGS_MSI set for 0000:00:0d.0 subordinate 
> bus.
> PCI: Found MSI HT mapping on 0000:00:0e.0
> PCI: Found MSI HT mapping on 0000:00:00.0
> PCI: MSI quirk detected. PCI_BUS_FLAGS_MSI set for 0000:00:0e.0 subordinate 
> bus.
>   

If your board is behind one of these bridges, MSI could work (looks like
you have 4 nVidia CK804 with MSI enabled in the Hypertransport mapping).


> pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
> assign_interrupt_mode Found MSI capability
> Allocate Port Service[0000:00:0b.0:pcie00]
> Allocate Port Service[0000:00:0b.0:pcie03]
>   

It might be the reason why MSI does not work. But I am not familiar with
this code, so I can't help, sorry.

Brice


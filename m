Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbTD2D1m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 23:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbTD2D1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 23:27:42 -0400
Received: from fmr06.intel.com ([134.134.136.7]:45817 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S261906AbTD2D1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 23:27:41 -0400
Message-ID: <12B638FEE763F74696D8544752E7204803254E89@bgsmsx101.iind.intel.com>
From: "Seshadri, Harinarayanan" <harinarayanan.seshadri@intel.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "Seshadri, Harinarayanan" <harinarayanan.seshadri@intel.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'mj@ucw.cz'" <mj@ucw.cz>
Subject: RE: Request for Comment on PCI Express Configuration Support desi
	gn
Date: Mon, 28 Apr 2003 20:34:38 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Please see my comments below
Regards
--hari

>>>Is this property dependant on the device or on the root bridge ? IE if I
>>>	have something like

>>>	PCIEXPRESS(root)---->PCIEXress/Cardbus bridge--->Ethernet card

>>>Can I use the mmio interface to talk to the card - I'd assume so
>>>(obviously it only has 256 bytes of data)

Yes. Its root bridge dependent. For the above example, we can still use mmio
interface to talk to the card.

--hari

-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
Sent: Tuesday, April 29, 2003 4:02 AM
To: Seshadri, Harinarayanan
Cc: 'linux-kernel@vger.kernel.org'; 'mj@ucw.cz'
Subject: Re: Request for Comment on PCI Express Configuration Support
design


On Llu, 2003-04-28 at 17:59, Seshadri, Harinarayanan wrote:
> which is essentially a Memory Mapped scheme to access this extended
> configuration region. Currently in Linux, the PCI Subsystem supports only
> type 1/ type 2 PCI configuration access, which is traditionally accessed
> through CF8/CFC mechanism. 

(and BIOS, and IBM NUMA-Q/440)

> 	To support access to the extended configuration region of the PCI
> Express devices (Although legacy CF8/CFC scheme will still work, but the
> configuration access space will be limited to 256 bytes only), we need to
> modify the PCI subsystem. At the time of PCI initialization/device
> enumeration the pci_root_ops and hence pci_dev->ops structure is set to
> pci_express_ops for PCI Express devices (identified by the existence of
the
> PCI Express capability structure). 

Is this property dependant on the device or on the root bridge ? IE if I
have something like

	PCIEXPRESS(root)---->PCIEXress/Cardbus bridge--->Ethernet card

Can I use the mmio interface to talk to the card - I'd assume so
(obviously it only has 256 bytes of data)


> 		static unsigned long __init pciexp_map_region(unsigned long
> phys)
> 		{
> 			unsigned long base, offset, mapped_area;
> 			base  = ((unsigned long)phys) & PAGE_MASK;
> 			offset = ((unsigned long) phys) - base;
> 			mapped_area = (unsigned long) ioremap(base,
> PAGE_SIZE);
> 			return ( mapped_area? (mapped_area + offset): 0UL);
> 		}

ioremap is bright enough to do unaligned maps for you

> 		This will enable any existing pci driver to access the
> complete 4k config space (which include legacy 256 byte configuration
region
> as well) using standard interface like pci_config_read/write call. 

Looks pretty sound to me. The code was intended to support multiple
config mechanisms.

Alan

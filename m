Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262978AbUCXCpx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 21:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262983AbUCXCpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 21:45:53 -0500
Received: from fmr06.intel.com ([134.134.136.7]:52626 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S262978AbUCXCpv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 21:45:51 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: PCI bug?
Date: Wed, 24 Mar 2004 10:45:47 +0800
Message-ID: <571ACEFD467F7749BC50E0A98C17CDD803300BA2@PDSMSX403.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PCI bug?
Thread-Index: AcQRShyVGf0yYHsFTlmdKvULF/JHmA==
From: "Li, Shaohua" <shaohua.li@intel.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Greg KH" <greg@kroah.com>
X-OriginalArrivalTime: 24 Mar 2004 02:45:48.0516 (UTC) FILETIME=[1D025240:01C4114A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have two questions.There are one p2p bridge and 2 card bus bridges
under the p2p bridge. Firmware assign 8 for p2p bridge's subordinate bus
number. Since the bridge has default bridge number, PCI will not assign
again. But PCI does assign bus number 3~6 and 7~10 to the cardbus
bridge. And it's oversized. I must add pci=assign-busses. I guess many
systems with cardbus bridge have the problem. My question is if
pci=assign-busses should be the default behave.

And another question. Some bridges allocate many bus numbers, but they
don't use them right
now. A case is cardbus bridge. So should pci_bus_max_busnr return max
allocated bus number?

pci_bus_max_busnr(struct pci_bus* bus)
{
	struct list_head *tmp;
	unsigned char max, n;

-	max = bus->number;
+	max = bus->subordinate;
	list_for_each(tmp, &bus->children) {
		n = pci_bus_max_busnr(pci_bus_b(tmp));
		if(n > max)
			max = n;
	}
	return max;
}

thanks,
David

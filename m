Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129535AbRCBVlG>; Fri, 2 Mar 2001 16:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129537AbRCBVk5>; Fri, 2 Mar 2001 16:40:57 -0500
Received: from palrel3.hp.com ([156.153.255.226]:54276 "HELO palrel3.hp.com")
	by vger.kernel.org with SMTP id <S129535AbRCBVkv>;
	Fri, 2 Mar 2001 16:40:51 -0500
Message-Id: <200103022143.NAA29984@milano.cup.hp.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.4.0 parisc PCI support 
In-Reply-To: Your message of "Fri, 02 Mar 2001 15:46:12 PST."
             <3AA00694.7A65A3B2@mandrakesoft.com> 
Date: Fri, 02 Mar 2001 13:43:55 -0800
From: Grant Grundler <grundler@cup.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> IIRC these "assuming transparent" lines were put in to -fix- PCI-PCI
> bridges on at least some x86 boxes...  I didn't really understand the
> bridge code well enough at the time to comment one way or the other on
> its correctness, but it definitely fixed some problems.

Jeff,
If someone could clarify, I'd be happy to rework/resubmit the patch.

My gut feeling is it was to support something other than a PCI-PCI bridge.
pci_read_bridge_bases() assumes the device is a PCI-PCI Bridge (layout
and interpretation of the window registers). Either the code needs to
be more explicit about the type of bridge being handled or the caller
(arch specific code) should.

Only x86 and parisc PCI support call this code in my 2.4.0 tree.
Maybe the right answer is the "assuming transperent" support in
pci_read_bridge_bases() move to arch/x86.

I'm pretty sure Alpha and parisc/PAT_PDC systems don't use this
code since the registers programmed in pci_setup_bridge().
This makes me think none of the other arches attempt to
support PCI-PCI bridges. Is that correct?

thanks,
grant

Grant Grundler
parisc-linux {PCI|IOMMU|SMP} hacker
+1.408.447.7253

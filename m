Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267335AbSLEP0C>; Thu, 5 Dec 2002 10:26:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267337AbSLEP0C>; Thu, 5 Dec 2002 10:26:02 -0500
Received: from host194.steeleye.com ([66.206.164.34]:8208 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S267335AbSLEP0A>; Thu, 5 Dec 2002 10:26:00 -0500
Message-Id: <200212051533.gB5FXTN02203@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: James Bottomley <James.Bottomley@SteelEye.com>, mj@ucw.cz,
       linux-kernel@vger.kernel.org, mochel@osdl.org
Subject: Re: [BKPATCH] allow pci primary peer busses to have parents 
In-Reply-To: Message from Ivan Kokshaysky <ink@jurassic.park.msu.ru> 
   of "Thu, 05 Dec 2002 16:12:05 +0300." <20021205161205.A6419@jurassic.park.msu.ru> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 05 Dec 2002 09:33:29 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2002 at 11:18:24AM -0600, James Bottomley wrote:
> Now that the generic device model allows a coherent bus tree to be built

ink@jurassic.park.msu.ru said:
> Unfortunately it doesn't.

OK, consider the phrase for architectures with subordinate PCI busses added.

ink@jurassic.park.msu.ru said:
>  Currently those legacy, PnP, EISA devices all have virtual parents,
> which has nothing to do with reality. Modern systems (including most
> PCs) hang these buses off PCI bus using PCI-to-{E}ISA bridge. Such
> systems must be able to register these buses upon discovery of the ISA
> bridges (from pci layer), and use them as a parent device for legacy/
> isa/pnp stuff. This will be absolutely required if DMA operations are
> moved from pci_dev to the generic device. 

Well, we are moving in this direction.  I've already done the conversion for 
MCA.  Marc Zyngier has done it for EISA.  I believe someone is looking at PnP 
ISA.  ISA, as a non-probe'able bus fits into the legacy bus scheme anyway.

> The `sysdata' arg already contains info about parent host-to-pci
> controller on many platforms. I don't think that we need to duplicate
> it with another one. I was thinking about something like this instead
> of `sysdata': 

That's PCI specific.  We need a coherent tree in the generic model.  To do 
this, the PCI parent information has to be available just using the struct 
device, without having to cast it to pci_dev and look at pci specific fields.

This is a simplification requirement for machines whose IOMMUs lie on other 
bus types above the PCI busses.  You have to be able to walk up the device 
tree until you find the IOMMU.  Since you're sharing the implementation with 
the non-PCI busses, you need to be able to do this in a generic manner.

James



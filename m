Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313743AbSFNTfP>; Fri, 14 Jun 2002 15:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313773AbSFNTfO>; Fri, 14 Jun 2002 15:35:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27396 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313743AbSFNTfO>;
	Fri, 14 Jun 2002 15:35:14 -0400
Message-ID: <3D0A449C.5030304@mandrakesoft.com>
Date: Fri, 14 Jun 2002 15:31:40 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/00200205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
CC: Linus Torvalds <torvalds@transmeta.com>, Vojtech Pavlik <vojtech@suse.cz>,
        Peter Osterlund <petero2@telia.com>, Patrick Mochel <mochel@osdl.org>,
        Tobias Diedrich <ranma@gmx.at>,
        Alessandro Suardi <alessandro.suardi@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.5.20 - Xircom PCI Cardbus doesn't work
In-Reply-To: <Pine.LNX.4.44.0206141308100.31514-100000@chaos.physics.uiowa.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Germaschewski wrote:
> On Fri, 14 Jun 2002, Linus Torvalds wrote:
> 
> 
>>I suspect that forcing resource assignment into "pci_enable_device()"
>>should fix that too.
>>
>>Although there should probably be some way for the driver to tell which
>>resources it cares about (some drivers care about the PCI ROM's, for
>>example, others don't. Some drivers don't care about the IO region, and
>>others don't care about the MEM region). So the _right_ answer might be to
>>pass in a bitmap to "pci_enable_device()", which tells the enable code
>>which parts the driver really cares about..
> 
> 
> That reminds me of some idea I had been thinking about for some time: 
> 
> What about adding some pci_request_irq() and pci_request_{,mem_}_region,
> which would allow for some cleanup of ever-recurring code sequences in
> drivers, and which at the same time would allow for the above?
> pci_request_mem_region() might even include the ioremap() as well ;)


We already have pci_request_regions() and currently PCI drivers should 
use that.

Auto-ioremap would be bad, though... you would wind up wasting address 
space for any case where MMIO areas are not 100% utilized (like network 
cards that require use of PIO due to hardware bugs, but still export an 
MMIO region for their NIC registers)

	Jeff




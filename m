Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313711AbSFNTk4>; Fri, 14 Jun 2002 15:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313898AbSFNTkz>; Fri, 14 Jun 2002 15:40:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34564 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313711AbSFNTkz>;
	Fri, 14 Jun 2002 15:40:55 -0400
Message-ID: <3D0A45F2.1030202@mandrakesoft.com>
Date: Fri, 14 Jun 2002 15:37:22 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/00200205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
        Vojtech Pavlik <vojtech@suse.cz>, Peter Osterlund <petero2@telia.com>,
        Patrick Mochel <mochel@osdl.org>, Tobias Diedrich <ranma@gmx.at>,
        Alessandro Suardi <alessandro.suardi@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.5.20 - Xircom PCI Cardbus doesn't work
In-Reply-To: <Pine.LNX.4.44.0206141115340.872-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Fri, 14 Jun 2002, Kai Germaschewski wrote:
> 
>>What about adding some pci_request_irq() and pci_request_{,mem_}_region,
>>which would allow for some cleanup of ever-recurring code sequences in
>>drivers, and which at the same time would allow for the above?
>>pci_request_mem_region() might even include the ioremap() as well ;)
> 
> 
> That might be the right solution - leave "pci_enable_dev()" as-is, and
> just consider that the legacy way of "enable stuff that got allocated
> automatically".
> 
> And make new drivers start using "pci_request_irq()" and friends.
> 
> (The current "pci_enable_dev()" is broken in many respects: sometimes you
> do NOT want to enable the IRQ until you have set up the device, but in
> order to set up the device you may need to know _which_ irq it will have,
> and you need to enable access to memory and IO regions and map the
> device).


Can someone clarify for me the need of pci_request_irq??

pci_enable_device() assigns the IRQ in routing, but it is not enabled 
until you call request_irq.  I don't see any simplification that can be 
done in the PCI API.

The only thing I've wanted is a cross-platform way to detect if 
pdev->irq returned by pci_enable_device is valid.

	Jeff




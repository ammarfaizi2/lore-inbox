Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313202AbSFNSMX>; Fri, 14 Jun 2002 14:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313492AbSFNSMW>; Fri, 14 Jun 2002 14:12:22 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:55237 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S313202AbSFNSMV>; Fri, 14 Jun 2002 14:12:21 -0400
Date: Fri, 14 Jun 2002 13:12:10 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Linus Torvalds <torvalds@transmeta.com>
cc: Vojtech Pavlik <vojtech@suse.cz>, Peter Osterlund <petero2@telia.com>,
        Patrick Mochel <mochel@osdl.org>, Tobias Diedrich <ranma@gmx.at>,
        Alessandro Suardi <alessandro.suardi@oracle.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.20 - Xircom PCI Cardbus doesn't work
In-Reply-To: <Pine.LNX.4.44.0206141057030.2576-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0206141308100.31514-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jun 2002, Linus Torvalds wrote:

> I suspect that forcing resource assignment into "pci_enable_device()"
> should fix that too.
> 
> Although there should probably be some way for the driver to tell which
> resources it cares about (some drivers care about the PCI ROM's, for
> example, others don't. Some drivers don't care about the IO region, and
> others don't care about the MEM region). So the _right_ answer might be to
> pass in a bitmap to "pci_enable_device()", which tells the enable code
> which parts the driver really cares about..

That reminds me of some idea I had been thinking about for some time: 

What about adding some pci_request_irq() and pci_request_{,mem_}_region,
which would allow for some cleanup of ever-recurring code sequences in
drivers, and which at the same time would allow for the above?
pci_request_mem_region() might even include the ioremap() as well ;)

And yeah, eventually, that might be better done at 'struct device' level,
but that doesn't make a difference to the conceptual idea.

--Kai


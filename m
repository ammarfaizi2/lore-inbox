Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268053AbRHFMRz>; Mon, 6 Aug 2001 08:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268094AbRHFMRp>; Mon, 6 Aug 2001 08:17:45 -0400
Received: from ns.caldera.de ([212.34.180.1]:54932 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S268053AbRHFMRe>;
	Mon, 6 Aug 2001 08:17:34 -0400
Date: Mon, 6 Aug 2001 14:13:50 +0200
Message-Id: <200108061213.f76CDoE05527@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: kai@tp1.ruhr-uni-bochum.de (Kai Germaschewski)
Cc: linux-kernel@vger.kernel.org, kaos@ocs.com.au
Subject: Re: 2.4.8-pre4, lots of compile warnings
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <Pine.LNX.4.33.0108061155480.8689-100000@chaos.tp1.ruhr-uni-bochum.de>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33.0108061155480.8689-100000@chaos.tp1.ruhr-uni-bochum.de> you wrote:
> On Mon, 6 Aug 2001, Keith Owens wrote:
>
>> Add attribute unused plus a BIG comment saying that the code should be
>> moved to the new pci infrastructure ASAP.  Add the code to the janitor
>> list.
>
> Moving to the new pci infrastructure is not an option for the
> drivers/isdn/hisax driver. For historical reasons, it doesn't use
> autoprobing, changing that now will break initializiation on probably
> every distribution out there (if it supports ISDN).

There is another way to at lest use the pci tables without going for
the full hotplug API.

Just replace code like:

	if ((dev_avm = pci_find_device(PCI_VENDOR_ID_AVM,
			PCI_DEVICE_ID_AVM_A1,  dev_avm))) {
		/* initialize card */
	}

with something like:


	pci_for_each_dev(dev_avm) {
		if (pci_match_device(avm_pci_tbl, dev_avm)) {
			/* initialize card */
		}
	}

This will need per-card instead of the current global hisax pci tables,
but I think it's a good cleanup.


> I'll break this compatibility in 2.5, though.

Nice!  Does this mean the hisax subdrivers will finally be able to be
individual modules?  Are there also other ISDN changes planned, e.g.
going from the global cli/sti to better locking schemes?

	Christoph

-- 
Whip me.  Beat me.  Make me maintain AIX.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266686AbRGFNdL>; Fri, 6 Jul 2001 09:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266688AbRGFNdC>; Fri, 6 Jul 2001 09:33:02 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:33287 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S266686AbRGFNcz>;
	Fri, 6 Jul 2001 09:32:55 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, bcrl@redhat.com (Ben LaHaise),
        hiren_mehta@agilent.com ("MEHTA,HIREN (A-SanJose,ex1)"),
        linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
Subject: Re: (reposting) how to get DMA'able memory within 4GB on 64-bit m achi ne
In-Reply-To: <15164.18270.460245.219060@pizda.ninka.net> <E15Fv14-0008TB-00@the-village.bc.nu> <15164.59159.645521.383074@pizda.ninka.net> <d3pubfw0fi.fsf@lxplus015.cern.ch> <15172.64662.696505.761486@pizda.ninka.net>
From: Jes Sorensen <jes@sunsite.dk>
Date: 06 Jul 2001 15:31:58 +0200
In-Reply-To: "David S. Miller"'s message of "Thu, 5 Jul 2001 16:47:34 -0700 (PDT)"
Message-ID: <d3d77ew5dd.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David S Miller <davem@redhat.com> writes:

David> Jes Sorensen writes:
>> The dma_mask in struct pci_dev tells you whether you are DAC
>> capable. We pass a pointer to this struct when we call the pci_*
>> functions so the required information needed to make the decision
>> whether to return a SAC or a DAC address is already available.

David> The decision is not based upon "device capable of DAC", that is
David> precisely my point.

I understand that, it's part of the equation.

David> The decision must be based upon a number of considerations.

David> 1) Can it do DAC

David> 2) Is DAC more efficient than SAC on this platform

That sounds to me like a 'static' decision at compile time or at least
something decided upon in the pci_* code as it will be the same for
all devices on the bus. If your IOMMU is very complex to program
compared to the overhead of DAC cycles you pick DAC etc.

David> 3) Does the devices _need_ DAC even if it is slower because it
David> requires referencing large portions of the DMA address space
David> simultaneously

Sure or because the IOMMU is starved. Most devices will do SAC/DAC
based on the address you throw at them, ie. it's perfectly valid to
mix and match DAC and SAC addresses handed to a device.

David> Sure, you could imply all of this complexity in the driver by
David> making them consider all of these issues when setting the mask,
David> but that isn't a nice interface at all.

David> And this still leaves the 64-bit dma_addr_t overhead issue.

The 64 bit dma_addr_t is only an issue on 32 bit architectures with
highmem enabled. I never suggested making dma_addr_t 64 bit on 32 bit
architectures as a general thing.

Jes

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131888AbQLHPDL>; Fri, 8 Dec 2000 10:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131878AbQLHPDC>; Fri, 8 Dec 2000 10:03:02 -0500
Received: from mailhost.mipsys.com ([62.161.177.33]:14887 "EHLO
	[62.161.177.33]") by vger.kernel.org with ESMTP id <S129786AbQLHPCu>;
	Fri, 8 Dec 2000 10:02:50 -0500
From: Benjamin Herrenschmidt <bh40@calva.net>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, <linux-kernel@vger.kernel.org>
Subject: Re: PCI bridge setup weirdness
Date: Fri, 8 Dec 2000 15:31:08 +0100
Message-Id: <19341102080252.6877@192.168.1.2>
In-Reply-To: <20001208155128.A2926@jurassic.park.msu.ru>
In-Reply-To: <20001208155128.A2926@jurassic.park.msu.ru>
X-Mailer: CTM PowerMail 3.0.6 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>No, pci_read_bridge_bases() is obsoleted by new pci setup code. ;-)
>You have to set up bus resources properly in pcibios_fixup_bus().
>For a single root bus configuration, you don't need to do anything
>with the root bus itself - its resources already point to ioport_resource
>and iomem_resource, which should be ok. For pci-pci bridges you have
>to add something like this:

The problem I have (and this is why I don't setup host resources
properly on multi-host PPCs yet) is that some hosts can have several
non-contiguous ranges (especially with memory, IO is usually a single
contiguous range).

There are simply not enough resource "slots" in the current structures
to handle all possibles cases.

They basically have a host bridge register in which each low bit enables
decoding of a 256Mb region in the range 0xn0000000 and each high bit
enable decoding of a 16Mb region in the range 0xFn000000

The typical setup is to have one (or more) 256Mb regions, and one 16Mb
region, but that can change from model to model.

Ben

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265577AbRGEXsI>; Thu, 5 Jul 2001 19:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265592AbRGEXr6>; Thu, 5 Jul 2001 19:47:58 -0400
Received: from pizda.ninka.net ([216.101.162.242]:8679 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265577AbRGEXrk>;
	Thu, 5 Jul 2001 19:47:40 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15172.64662.696505.761486@pizda.ninka.net>
Date: Thu, 5 Jul 2001 16:47:34 -0700 (PDT)
To: Jes Sorensen <jes@sunsite.dk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, bcrl@redhat.com (Ben LaHaise),
        hiren_mehta@agilent.com ("MEHTA,HIREN (A-SanJose,ex1)"),
        linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
Subject: Re: (reposting) how to get DMA'able memory within 4GB on 64-bit m achi ne
In-Reply-To: <d3pubfw0fi.fsf@lxplus015.cern.ch>
In-Reply-To: <15164.18270.460245.219060@pizda.ninka.net>
	<E15Fv14-0008TB-00@the-village.bc.nu>
	<15164.59159.645521.383074@pizda.ninka.net>
	<d3pubfw0fi.fsf@lxplus015.cern.ch>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jes Sorensen writes:
 > The dma_mask in struct pci_dev tells you whether you are DAC
 > capable. We pass a pointer to this struct when we call the pci_*
 > functions so the required information needed to make the decision
 > whether to return a SAC or a DAC address is already available.

The decision is not based upon "device capable of DAC", that is
precisely my point.

The decision must be based upon a number of considerations.

1) Can it do DAC

2) Is DAC more efficient than SAC on this platform

3) Does the devices _need_ DAC even if it is slower because
   it requires referencing large portions of the DMA
   address space simultaneously

Sure, you could imply all of this complexity in the driver
by making them consider all of these issues when setting the
mask, but that isn't a nice interface at all.

And this still leaves the 64-bit dma_addr_t overhead issue.

Later,
David S. Miller
davem@redhat.com

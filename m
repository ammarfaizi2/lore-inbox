Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264825AbRF1W7N>; Thu, 28 Jun 2001 18:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264827AbRF1W7D>; Thu, 28 Jun 2001 18:59:03 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:521 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S264825AbRF1W6v>;
	Thu, 28 Jun 2001 18:58:51 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: Ben LaHaise <bcrl@redhat.com>,
        "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: (reposting) how to get DMA'able memory within 4GB on 64-bit m achi ne
In-Reply-To: <15163.44990.304436.360220@pizda.ninka.net> <Pine.LNX.4.33.0106281830480.32276-100000@toomuch.toronto.redhat.com> <15163.45534.977835.569473@pizda.ninka.net>
From: Jes Sorensen <jes@sunsite.dk>
Date: 29 Jun 2001 00:55:47 +0200
In-Reply-To: "David S. Miller"'s message of "Thu, 28 Jun 2001 15:38:22 -0700 (PDT)"
Message-ID: <d3pubo9pu4.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David S Miller <davem@redhat.com> writes:

David> There are so many issues with 64-bit DAC support, that many of
David> the people whining in this thread have not even considered, and
David> these very issues will be what shapes the eventual API to use.

David> For example.  I have IOMMU's on my machine, there is no real
David> need to use 64-bit DAC in %99 of cases.  In fact, DAC transfers
David> run slower because they cannot use the DMA caching in the PCI
David> controller.

David> How do you represent this with the undocumented API ia64 has
David> decided to use?  You can't convey this information to the
David> driver, because the driver may say "I don't care if it's
David> slower, I want the large addressing because otherwise I'd
David> consume or overflow the IOMMU resources".  How do you say "SAC
David> is preferred for performance" with ia64's API?  You can't.

Thats easy, you use the IOMMU in pci_alloc_consistent() and friends
and return a 32bit address in that case. Most cards will simply issue
a SAC cycle if the upper 32 bits in the DMA address are zero, the ones
that don't are broken.

This way you automatically get support for the situation Ben mentioned
as well, when doing large allocs and the IOMMU is full you return a
full 64 bit address.

Jes

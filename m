Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264790AbRF1Wpm>; Thu, 28 Jun 2001 18:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264794AbRF1Wpd>; Thu, 28 Jun 2001 18:45:33 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:32885 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S264790AbRF1Wp0>; Thu, 28 Jun 2001 18:45:26 -0400
Date: Thu, 28 Jun 2001 18:45:22 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@toomuch.toronto.redhat.com>
To: "David S. Miller" <davem@redhat.com>
cc: Jes Sorensen <jes@sunsite.dk>,
        "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: (reposting) how to get DMA'able memory within 4GB on 64-bit m
 achi ne
In-Reply-To: <15163.45534.977835.569473@pizda.ninka.net>
Message-ID: <Pine.LNX.4.33.0106281840330.32276-100000@toomuch.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jun 2001, David S. Miller wrote:

> Shit happens Ben.  One has to draw the line somewhere.

Yup, sure does.

> Sure, once 2.5.x has the interfaces, we'll add the "dummy" ones
> to 2.4.x, but only then.  I don't even know %100 how I want the
> damn thing to look yet.

Well, better start suggesting fixes to the work that other people are
doing instead of saying "nope, ya gotta wait".

> There are so many issues with 64-bit DAC support, that many of
> the people whining in this thread have not even considered, and
> these very issues will be what shapes the eventual API to use.
>
> For example.  I have IOMMU's on my machine, there is no real need to
> use 64-bit DAC in %99 of cases.  In fact, DAC transfers run slower
> because they cannot use the DMA caching in the PCI controller.

Well, let me introduce you to some high end fibre channel devices.  These
controllers can keep hundreds of thousands of io requests active at a
given time, and those requests can be very large.  In fact, they can be so
large that the memory mappings that would need to remain active simply
cannot fit inside of a 32 bit address space.

> How do you represent this with the undocumented API ia64 has decided
> to use?  You can't convey this information to the driver, because the
> driver may say "I don't care if it's slower, I want the large
> addressing because otherwise I'd consume or overflow the IOMMU
> resources".  How do you say "SAC is preferred for performance" with
> ia64's API?  You can't.

How is SAC useful on ia64?  All the machines are going to be shipped with
more than 4GB of RAM, and they need an IOMMU.

Like it or not, 64 bit DMA is here, NOW.  Not during the 2.6, but during
2.4.  We can either start fixing the ia64 APIs and replacing them with
something that's "Right" or we can continue with ad hoc solutions.

		-ben


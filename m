Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264800AbRF1Wiv>; Thu, 28 Jun 2001 18:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264804AbRF1Wil>; Thu, 28 Jun 2001 18:38:41 -0400
Received: from pizda.ninka.net ([216.101.162.242]:10910 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264800AbRF1WiZ>;
	Thu, 28 Jun 2001 18:38:25 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15163.45534.977835.569473@pizda.ninka.net>
Date: Thu, 28 Jun 2001 15:38:22 -0700 (PDT)
To: Ben LaHaise <bcrl@redhat.com>
Cc: Jes Sorensen <jes@sunsite.dk>,
        "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: (reposting) how to get DMA'able memory within 4GB on 64-bit m
 achi ne
In-Reply-To: <Pine.LNX.4.33.0106281830480.32276-100000@toomuch.toronto.redhat.com>
In-Reply-To: <15163.44990.304436.360220@pizda.ninka.net>
	<Pine.LNX.4.33.0106281830480.32276-100000@toomuch.toronto.redhat.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ben LaHaise writes:
 > Sorry, but that's not a good enough answer if 2.5 takes the same 2 years
 > that 2.3 took.  Define the API so that people can at least write their
 > drivers to the spec, or else suffer the consequences of people doing their
 > own thing.

Shit happens Ben.  One has to draw the line somewhere.

Sure, once 2.5.x has the interfaces, we'll add the "dummy" ones
to 2.4.x, but only then.  I don't even know %100 how I want the
damn thing to look yet.

There are so many issues with 64-bit DAC support, that many of
the people whining in this thread have not even considered, and
these very issues will be what shapes the eventual API to use.

For example.  I have IOMMU's on my machine, there is no real need to
use 64-bit DAC in %99 of cases.  In fact, DAC transfers run slower
because they cannot use the DMA caching in the PCI controller.

How do you represent this with the undocumented API ia64 has decided
to use?  You can't convey this information to the driver, because the
driver may say "I don't care if it's slower, I want the large
addressing because otherwise I'd consume or overflow the IOMMU
resources".  How do you say "SAC is preferred for performance" with
ia64's API?  You can't.

This, almost with several other issues, need to be considered and
handled by whatever API you come up with.  If it does not address
all of these issues somehow, it is unacceptable.

Later,
David S. Miller
davem@redhat.com

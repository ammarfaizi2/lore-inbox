Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130039AbRBNF00>; Wed, 14 Feb 2001 00:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129681AbRBNF0R>; Wed, 14 Feb 2001 00:26:17 -0500
Received: from [204.253.167.1] ([204.253.167.1]:44804 "EHLO vaio.greennet")
	by vger.kernel.org with ESMTP id <S129108AbRBNF0D>;
	Wed, 14 Feb 2001 00:26:03 -0500
Date: Tue, 13 Feb 2001 20:20:35 -0500 (EST)
From: Donald Becker <becker@scyld.com>
To: Jes Sorensen <jes@linuxcare.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Ion Badulescu <ionut@moisil.cs.columbia.edu>,
        Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] starfire reads irq before pci_enable_device.
In-Reply-To: <d3zofrag0u.fsf@lxplus015.cern.ch>
Message-ID: <Pine.LNX.4.10.10102131627180.7141-100000@vaio.greennet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Feb 2001, Jes Sorensen wrote:

> >>>>> "Donald" == Donald Becker <becker@scyld.com> writes:
> 
> Donald> On 9 Feb 2001, Jes Sorensen wrote:
> >> The ia64 kernel has gotten mis aligned load support, but it's slow
> >> as a dog so we really want to copy the packet every time anyway
> >> when the header is not aligned. If people send out 802.3 headers or
> >> other crap on Ethernet then it's just too bad.
> 
> Donald> Note the word "required", meaning "must be done"
> Donald> vs. "recommended" meaning "should be done".
> 
> Donald> The initial issue was a comment in a starfire patch that
> Donald> claimed an IA64 bug had been fixed.  The copy breakpoint
> Donald> change might have improved performance by doing a copy-align,
> Donald> but it didn't fix a bug.
> 
> I agree it was a bug, and yes it has been fixed.

There was not a bug in the driver.  The bug was/is in the protocol handling
code.  The protocol handling code *must* be able to handle unaligned IP
headers.

> Donald> That performance tradeoff was already anticipated: the
> Donald> 'rx_copybreak' value that was changed was a module parameter,
..
> In this case it just results in a performance degradation for 99% of
> the usage. What about making the change so it is optimized away unless
> IPX is enabled?

???
  - It's not just IPX hosts that send 802.3 headers.
  - While a good initial value might depend on the architecture, the
    best setting is processor implementation and environment dependent.
    Those details are not known at compile time.
  - The code path cost of a module option is only a compare and a
    conditional branch.

Donald Becker				becker@scyld.com
Scyld Computing Corporation		http://www.scyld.com
410 Severn Ave. Suite 210		Second Generation Beowulf Clusters
Annapolis MD 21403			410-990-9993


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129666AbRBIW46>; Fri, 9 Feb 2001 17:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130624AbRBIW4s>; Fri, 9 Feb 2001 17:56:48 -0500
Received: from battlejitney.wdhq.scyld.com ([216.254.93.178]:15601 "EHLO
	vaio.greennet") by vger.kernel.org with ESMTP id <S129666AbRBIW43>;
	Fri, 9 Feb 2001 17:56:29 -0500
Date: Fri, 9 Feb 2001 17:56:06 -0500 (EST)
From: Donald Becker <becker@scyld.com>
To: Jes Sorensen <jes@linuxcare.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Ion Badulescu <ionut@moisil.cs.columbia.edu>,
        Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] starfire reads irq before pci_enable_device.
In-Reply-To: <d3d7crwn2n.fsf@lxplus015.cern.ch>
Message-ID: <Pine.LNX.4.10.10102091707310.7141-100000@vaio.greennet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 Feb 2001, Jes Sorensen wrote:

> >>>>> "Jeff" == Jeff Garzik <jgarzik@mandrakesoft.com> writes:
> Jeff> Donald Becker wrote:
> >> On Tue, 16 Jan 2001, Jeff Garzik wrote: > * IA64 support (Jes) Oh,
> >> and this is completely bogus.  This isn't a fix, it's a hack that
> >> covers up the real problem.
> >> 
> >> The align-copy should *never* be required because the alignment
> >> differs between DIX and E-II encapsulated packets.  The machine
> >> shouldn't crash because someone sends you a different encapsulation
> >> type!
> 
> The ia64 kernel has gotten mis aligned load support, but it's slow as
> a dog so we really want to copy the packet every time anyway when the
> header is not aligned. If people send out 802.3 headers or other crap
> on Ethernet then it's just too bad.

Note the word "required", meaning "must be done" vs. "recommended"
meaning "should be done".

The initial issue was a comment in a starfire patch that claimed an IA64
bug had been fixed.  The copy breakpoint change might have improved
performance by doing a copy-align, but it didn't fix a bug.

That performance tradeoff was already anticipated: the 'rx_copybreak'
value that was changed was a module parameter, not a constant.  That
allows a module-load-time tradeoff, based the specific implementation,
of copying the received packet or accepting a few unaligned loads of the
usually small IP header.  See the comments in starfire.c, as well as
several other bus-master drivers.
   

Donald Becker				becker@scyld.com
Scyld Computing Corporation		http://www.scyld.com
410 Severn Ave. Suite 210		Second Generation Beowulf Clusters
Annapolis MD 21403			410-990-9993

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262912AbREWAHv>; Tue, 22 May 2001 20:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262915AbREWAHm>; Tue, 22 May 2001 20:07:42 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:46347 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S262913AbREWAH2>;
	Tue, 22 May 2001 20:07:28 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200105230005.f4N05l7167540@saturn.cs.uml.edu>
Subject: Re: alpha iommu fixes
To: davem@redhat.com (David S. Miller)
Date: Tue, 22 May 2001 20:05:47 -0400 (EDT)
Cc: andrea@suse.de (Andrea Arcangeli), andrewm@uow.edu.au (Andrew Morton),
        ink@jurassic.park.msu.ru (Ivan Kokshaysky),
        rth@twiddle.net (Richard Henderson), linux-kernel@vger.kernel.org
In-Reply-To: <15112.47990.828744.956717@pizda.ninka.net> from "David S. Miller" at May 20, 2001 11:53:42 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller writes:

> What are these "devices", and what drivers "just program the cards to
> start the dma on those hundred mbyte of ram"?

Hmmm, I have a few cards that are used that way. They are used
for communication between nodes of a cluster.

One might put 16 cards in a system. The cards are quite happy to
do a 2 GB DMA transfer. Scatter-gather is possible, but it cuts
performance. Typically the driver would provide a huge chunk
of memory for an app to use, mapped using large pages on x86 or
using BAT registers on ppc. (reserved during boot of course)
The app would crunch numbers using the CPU (with AltiVec, VIS,
3dnow, etc.) and instruct the device to transfer data to/from
the memory region.

Remote nodes initiate DMA too, even supplying the PCI bus address
on both sides of the interconnect. :-) No IOMMU problems with
that one, eh? The other node may transfer data at will.







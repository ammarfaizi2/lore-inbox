Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261409AbSLFCQb>; Thu, 5 Dec 2002 21:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267529AbSLFCQb>; Thu, 5 Dec 2002 21:16:31 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:35486 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S261409AbSLFCQa>; Thu, 5 Dec 2002 21:16:30 -0500
To: David Gibson <david@gibson.dropbear.id.au>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] generic device DMA implementation
References: <20021205004744.GB2741@zax.zax>
	<200212050144.gB51iH105366@localhost.localdomain>
	<20021205023847.GA1500@zax.zax>
	<buohedtrw64.fsf@mcspd15.ucom.lsi.nec.co.jp>
	<20021205060606.GG1500@zax.zax>
	<buovg29klsh.fsf@mcspd15.ucom.lsi.nec.co.jp>
	<20021205234401.GO1500@zax.zax>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 06 Dec 2002 11:23:01 +0900
In-Reply-To: <20021205234401.GO1500@zax.zax>
Message-ID: <buoel8vlwca.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson <david@gibson.dropbear.id.au> writes:
> >   * pci_map_single allocates a `shadow area' of consistent memory and
> >     pci_unmap_single deallocates it
> 
> That's a little misleading: all your memory is consistent, the point
> is that it is a shadow area of PCI-mappable memory.

Well I suppose that's true if you're using the term in a cache-related
sense (which I gather is the convention).

OTOH, if you think about it from the view point of the PCI framework,
the terminology actually does make sense even in this odd case --
`consistent' memory is indeed consistent (both CPU and device see a
single image), but other memory used to communicate with the driver is
`inconsistent' (CPU and device see different things until a sync
operation is done).

> The issue is that there are other constraints for DMAable memory and
> you want drivers to be able to easily mallocate with those
> constraints.
> 
> Actually, it occurs to me that PC ISA DMA is in a similar situation -
> there is a constraint on DMAable memory (sufficiently low physical
> address) which has nothing to do with consistency.

Indeed.  What I'm doing is basically bounce-buffers.

-Miles
-- 
`The suburb is an obsolete and contradictory form of human settlement'

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129775AbRAIMWW>; Tue, 9 Jan 2001 07:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130105AbRAIMWM>; Tue, 9 Jan 2001 07:22:12 -0500
Received: from mail.zmailer.org ([194.252.70.162]:34064 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S129775AbRAIMWK>;
	Tue, 9 Jan 2001 07:22:10 -0500
Date: Tue, 9 Jan 2001 14:21:56 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Venkatesh Ramamurthy <Venkateshr@ami.com>
Cc: "'Pavel Machek'" <pavel@suse.cz>, adefacc@tin.it,
        linux-kernel@vger.kernel.org
Subject: Re: Confirmation request about new 2.4.x. kernel limits
Message-ID: <20010109142156.L25659@mea-ext.zmailer.org>
In-Reply-To: <1355693A51C0D211B55A00105ACCFE64E95137@ATL_MS1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1355693A51C0D211B55A00105ACCFE64E95137@ATL_MS1>; from Venkateshr@ami.com on Mon, Jan 08, 2001 at 11:11:05PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 11:11:05PM -0500, Venkatesh Ramamurthy wrote:
> 
> > Max. RAM size:	64 GB	(any slowness accessing RAM over 4 GB
> >				 with 32 bit machines ?)
> 	more than 4GB in RAM is bounce buffered, so there is performance
> 	penalty as the data have to be copied into the 4GB RAM area

  Actual memory limit is lower, your run-of-the-mill Pentium-PAE36 capable
  system has PCI bus(es) for IO, and address space for that/those need to
  stay in area below 4G for bootup to access any devices, thus very likely 
  your system doesn't have more than, say, 3 GB of RAM below 4G.

  Pick your processors.  You need XEONs to have L1/L2 cacheing on memory
  above the 4 GB address (PAE36 mapped physical addresses.)

  For IO on usual systems you have 32 bit address space PCI busmasters,
  so those can access only the lowest 4GB of address space, and to have
  a block of data in upper area, it needs to be "bounced", that is, CPU
  must copy it.  Linux 2.4.0 system doesn't support 64-bit PCI addresses
  at 32-bit systems (not at 64-bit Alpha either, I recall.)
  On the other hand, Alpha systems and SPARC systems have IOMMU hardware,
  and we do support that (to some extent), but 32-bit intel world doesn't
  have similar things.

  For userspace, if parts of userspace are physically mapped above 4G,
  it might not be very harmfull at all -- presuming you have XEONs which
  cache the memory accesses there also.  The libc and similar multiply
  shared objects might as well reside in high memory.   Userspace process
  doesn't see, after all, where each page resides physically.

/Matti Aarnio
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

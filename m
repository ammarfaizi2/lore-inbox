Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310645AbSCPUvv>; Sat, 16 Mar 2002 15:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310656AbSCPUvp>; Sat, 16 Mar 2002 15:51:45 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:20677 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S310645AbSCPUvg>; Sat, 16 Mar 2002 15:51:36 -0500
Date: Sat, 16 Mar 2002 13:51:32 -0700
Message-Id: <200203162051.g2GKpWX14185@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <yodaiken@fsmlabs.com>, Andi Kleen <ak@suse.de>,
        Paul Mackerras <paulus@samba.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
In-Reply-To: <Pine.LNX.4.33.0203161236160.32013-100000@penguin.transmeta.com>
In-Reply-To: <200203162036.g2GKaL513580@vindaloo.ras.ucalgary.ca>
	<Pine.LNX.4.33.0203161236160.32013-100000@penguin.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:
> 
> On Sat, 16 Mar 2002, Richard Gooch wrote:
> > 
> > These are contiguous physical pages, or just logical (virtual) pages?
> 
> Contiguous virtual pages, but discontiguous physical pages.

That's what I was hoping. Having both contiguous would be of some
benefit, but of course at the cost of having to unfragment physical
pages. Even if Andi can cleanly do that with rmap, it's still going to
cost (page copies, Dcache footprint, locking and more). I like the
"wide" TLB approach much more.

> The advantage being that you only need one set of virtual tags per
> "wide" entry, and you just fill the whole wide entry directly from
> the cacheline (ie the TLB entry is not really 32 bits any more, it's
> a full cacheline).
> 
> The _real_ advantage being that it should be totally invisible to
> software. I think Intel does something like this, but the point is,
> I don't even have to know, and it still works.

Completely behind the kernel's, back? Even so, is there some hint we
can give to the CPU to help? Or perhaps a hint an application can give
to the kernel to specify better alignment of mappings? The latter
would require a way for the kernel to find out the preferred alignment
from the CPU. Is this information available?

Anyone know if AMD does this as well?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca

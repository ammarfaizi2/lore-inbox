Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262734AbVCPSsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262734AbVCPSsr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 13:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262746AbVCPSrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 13:47:32 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:8121 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262751AbVCPSp2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 13:45:28 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [PATCH] Xen/i386 cleanups - AGP bus/phys cleanups
Date: Wed, 16 Mar 2005 10:42:02 -0800
User-Agent: KMail/1.7.2
Cc: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
       Ian.Pratt@cl.cam.ac.uk, linux-kernel@vger.kernel.org,
       Rik van Riel <riel@redhat.com>, kurt@garloff.de,
       Christian.Limpach@cl.cam.ac.uk
References: <E1DBX0o-0000sV-00@mta1.cl.cam.ac.uk> <20050316181042.GA26788@infradead.org> <521a4568db3e955cb245d10aaba2d3ce@cl.cam.ac.uk>
In-Reply-To: <521a4568db3e955cb245d10aaba2d3ce@cl.cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503161042.03886.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, March 16, 2005 10:35 am, Keir Fraser wrote:
> On 16 Mar 2005, at 18:10, Christoph Hellwig wrote:
> > On Wed, Mar 16, 2005 at 10:01:07AM -0500, Rik van Riel wrote:
> >> In the case of AGP, the AGPGART effectively _is_ the
> >> IOMMU.  Calculating the addresses right for programming
> >> the AGPGART is probably worth fixing.
> >
> > Well, it's a half-assed one.  And some systems have a real one.
> >
> > But the real problem is that virt_to_bus doesn't exist at all
> > on architectures like ppc64, and this patch touches files like
> > generic.c and backend.c that aren't PC-specific.   So you
> > effectively break agp support for them.
>
> The AGP driver is only configurable for ppc32, alpha, x86, x86_64 and
> ia64, all of which have virt_to_bus.

Yeah, but that doesn't mean it makes sense on all those platforms.  The 
biggest problem with virt_to_bus (well, depending on who you talk to) is that 
it can't handle systems where the address translation must be done 
differently depending on *which* bus we're getting a bus address for.  Not 
sure what makes sense in this case though... is the DMA mapping interface 
appropriate?

Jesse

Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317865AbSFNBYe>; Thu, 13 Jun 2002 21:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317866AbSFNBYd>; Thu, 13 Jun 2002 21:24:33 -0400
Received: from ns.suse.de ([213.95.15.193]:27151 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317865AbSFNBYd>;
	Thu, 13 Jun 2002 21:24:33 -0400
Date: Fri, 14 Jun 2002 03:24:29 +0200
From: Andi Kleen <ak@suse.de>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
        Richard Brunner <richard.brunner@amd.com>, mark.langsdorf@amd.com
Subject: Re: New version of pageattr caching conflict fix for 2.4
Message-ID: <20020614032429.A19018@wotan.suse.de>
In-Reply-To: <20020613221533.A2544@wotan.suse.de> <20020613210339.B21542@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2002 at 09:03:39PM -0400, Benjamin LaHaise wrote:
> On Thu, Jun 13, 2002 at 10:15:33PM +0200, Andi Kleen wrote:
> > Thanks to Ben LaHaise who found some problems in the original version.
> > 
> > I will probably submit this version for 2.4 unless someone finds a grave
> > problem in this version.
> 
> This version is missing a few of the fixes included in my version: 
> it doesn't properly flush global tlb entries, or update the page 

Sure it does. INVLPG (__flush_tlb_one) flushes global entries.

> tables of processes which have copied 4MB page table entries into 
> their page tables.  Also, the revert_page function must be called 

That's done in set_pmd_page.

> before the tlb flush and free the page after the tlb flush, or 
> else tlb prefetching on the P4 can cache stale pmd pointers.  I'd 

Fair point. Hmm, I had that correct, but somehow it got messed up again.

Another thing that probably needs to be added is that DRM needs 
some change_page_attr() calls too, because it does private AGP mappings.

-Andi


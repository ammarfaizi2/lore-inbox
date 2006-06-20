Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965033AbWFTIOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965033AbWFTIOH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 04:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965148AbWFTIOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 04:14:07 -0400
Received: from cantor2.suse.de ([195.135.220.15]:59008 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965033AbWFTIOF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 04:14:05 -0400
From: Andi Kleen <ak@suse.de>
To: Jes Sorensen <jes@sgi.com>
Subject: Re: [patch] do_no_pfn
Date: Tue, 20 Jun 2006 10:13:10 +0200
User-Agent: KMail/1.9.3
Cc: Robin Holt <holt@sgi.com>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, Hugh Dickins <hugh@veritas.com>,
       Carsten Otte <cotte@de.ibm.com>, bjorn_helgaas@hp.com
References: <yq0psh5zenq.fsf@jaguar.mkp.net> <20060619224952.GA17685@lnx-holt.americas.sgi.com> <4497AB46.4000402@sgi.com>
In-Reply-To: <4497AB46.4000402@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606201013.10353.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 June 2006 10:01, Jes Sorensen wrote:
> Robin Holt wrote:
> > On Mon, Jun 19, 2006 at 03:06:05PM +0200, Andi Kleen wrote:
> >> The big question is - why do you have pages without struct page? 
> >> It seems ... wrong.
> [snip]
> > Are you saying the for the mspec pages we should extend the vmem_map,
> > partially populate the regions for the mspec pages, mark those pages as
> > uncached and reserved and then turn them over to the uncached allocator?
> > Seems like we have done a lot of extra work to put a struct page behind
> > a page which requires special handling.
> 
> Note that Bjorn Helgas has a case where he needs this as well.
> 
> We could fake the pages by giving them a struct page, but it really
> makes no point as you say.

I think it would be better if you gave them struct pages instead 
of messing up core vm with such strange hooks.

Or alternatively code this in a different way. There are drivers
who map IO memory into user space without needing hacks like that.
Usually they just tweak the page tables directly on mmap.

-Andi


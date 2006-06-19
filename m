Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964963AbWFSWuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964963AbWFSWuJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 18:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964964AbWFSWuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 18:50:08 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:55703 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964963AbWFSWuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 18:50:07 -0400
Date: Mon, 19 Jun 2006 17:49:52 -0500
From: Robin Holt <holt@sgi.com>
To: Andi Kleen <ak@suse.de>
Cc: Jes Sorensen <jes@sgi.com>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, Hugh Dickins <hugh@veritas.com>,
       Carsten Otte <cotte@de.ibm.com>, bjorn_helgaas@hp.com
Subject: Re: [patch] do_no_pfn
Message-ID: <20060619224952.GA17685@lnx-holt.americas.sgi.com>
References: <yq0psh5zenq.fsf@jaguar.mkp.net> <p73r71lpa6a.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73r71lpa6a.fsf@verdi.suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 03:06:05PM +0200, Andi Kleen wrote:
> The big question is - why do you have pages without struct page? 
> It seems ... wrong.

For mspec, these are pages which come from the efi trim regions.
They are not usuable by the kernel.  Dropping in a kernel TLB entry for
them does allow speculation into PROM reserved memory which will result
in corrupting PROMs memory.  We have seen this in the past.

Additionally, Carsten Otte had been pursuing a do_no_pfn function to
allow execute in place to insert executable pages into an os instance
which are actually part of the physical machines memory map, but not part
of the virtual machines.  Several virtual machines could share the same
physical page.  I, of course, reserve the right to have gotten Carsten's
intentions completely wrong.  I don't believe I have misinterpretted
the intentions of do_no_pfn as expressed on the linux-mm mailing list.

Are you saying the for the mspec pages we should extend the vmem_map,
partially populate the regions for the mspec pages, mark those pages as
uncached and reserved and then turn them over to the uncached allocator?
Seems like we have done a lot of extra work to put a struct page behind
a page which requires special handling.

For Carsten's case, how would you propose we handle that?

Thanks,
Robin

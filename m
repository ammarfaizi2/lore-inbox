Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750856AbVKJN1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbVKJN1n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 08:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbVKJN1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 08:27:43 -0500
Received: from taurus.voltaire.com ([193.47.165.240]:54925 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP
	id S1750861AbVKJN1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 08:27:41 -0500
Date: Thu, 10 Nov 2005 15:26:58 +0200
From: Gleb Natapov <gleb@minantech.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nick's core remove PageReserved broke vmware...
Message-ID: <20051110132658.GP8942@minantech.com>
References: <20051110124949.GM8942@minantech.com> <20051110131630.GF16589@mellanox.co.il> <Pine.LNX.4.61.0511101316320.7422@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0511101316320.7422@goblin.wat.veritas.com>
X-OriginalArrivalTime: 10 Nov 2005 13:27:40.0181 (UTC) FILETIME=[85F30C50:01C5E5FA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2005 at 01:21:25PM +0000, Hugh Dickins wrote:
> On Thu, 10 Nov 2005, Michael S. Tsirkin wrote:
> > Quoting Gleb Natapov <gleb@minantech.com>:
> > > On Thu, Nov 10, 2005 at 02:48:53PM +0200, Michael S. Tsirkin wrote:
> > > > > Also perhapse we should skip VM_SHARED VMAs?
> > > > 
> > > > Why?
> > > > 
> > > They will work correctly across fork(). 
> > 
> > So why would I call madvise on such a VMA?
> 
> To avoid the overhead of forking it e.g. if it's a large nonlinear vma,
> a lot of time may be wasted on copying its ptes for fork.  That's one
> of the reasons I came to like your DONTCOPY.
> 
> So, it may not be useful for your particular RDMA issue, but I see no
> reason to exclude VM_SHARED vmas from the madvise, and good reason to
> include them.
> 
If the scope of DONTCOPY is more broad that just RDMA then I agree.

--
			Gleb.

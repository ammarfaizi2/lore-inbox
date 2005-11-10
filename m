Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750851AbVKJNWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbVKJNWk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 08:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbVKJNWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 08:22:40 -0500
Received: from gold.veritas.com ([143.127.12.110]:44450 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1750850AbVKJNWj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 08:22:39 -0500
Date: Thu, 10 Nov 2005 13:21:25 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
cc: Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nick's core remove PageReserved broke vmware...
In-Reply-To: <20051110131630.GF16589@mellanox.co.il>
Message-ID: <Pine.LNX.4.61.0511101316320.7422@goblin.wat.veritas.com>
References: <20051110124949.GM8942@minantech.com> <20051110131630.GF16589@mellanox.co.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 10 Nov 2005 13:22:39.0197 (UTC) FILETIME=[D28C88D0:01C5E5F9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Nov 2005, Michael S. Tsirkin wrote:
> Quoting Gleb Natapov <gleb@minantech.com>:
> > On Thu, Nov 10, 2005 at 02:48:53PM +0200, Michael S. Tsirkin wrote:
> > > > Also perhapse we should skip VM_SHARED VMAs?
> > > 
> > > Why?
> > > 
> > They will work correctly across fork(). 
> 
> So why would I call madvise on such a VMA?

To avoid the overhead of forking it e.g. if it's a large nonlinear vma,
a lot of time may be wasted on copying its ptes for fork.  That's one
of the reasons I came to like your DONTCOPY.

So, it may not be useful for your particular RDMA issue, but I see no
reason to exclude VM_SHARED vmas from the madvise, and good reason to
include them.

Hugh

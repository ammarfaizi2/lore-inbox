Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbTK1ThB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 14:37:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbTK1ThB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 14:37:01 -0500
Received: from tolkor.sgi.com ([198.149.18.6]:32488 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S261967AbTK1Tg4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 14:36:56 -0500
Date: Fri, 28 Nov 2003 13:35:36 -0600
From: Jack Steiner <steiner@sgi.com>
To: Jes Sorensen <jes@wildopensource.com>
Cc: Andrew Morton <akpm@osdl.org>, Jesse Barnes <jbarnes@sgi.com>,
       viro@math.psu.edu, wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: hash table sizes
Message-ID: <20031128193536.GA28519@sgi.com>
References: <16323.23221.835676.999857@gargle.gargle.HOWL> <20031125204814.GA19397@sgi.com> <20031125130741.108bf57c.akpm@osdl.org> <20031125211424.GA32636@sgi.com> <20031125132439.3c3254ff.akpm@osdl.org> <yq0d6bcmvfd.fsf@wildopensource.com> <20031128145255.GA26853@sgi.com> <yq08ym0mpig.fsf@wildopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq08ym0mpig.fsf@wildopensource.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, Nov 28, 2003 at 11:22:47AM -0500, Jes Sorensen wrote:
> >>>>> "Jack" == Jack Steiner <steiner@sgi.com> writes:
> 
> Jack> On Fri, Nov 28, 2003 at 09:15:02AM -0500, Jes Sorensen wrote:
> >>  What about something like this? I believe node_present_pages
> >> should be the same as nym_physpages on a non-NUMA machine. If not
> >> we can make it min(num_physpages,
> >> NODE_DATA(0)->node_present_pages).
> 
> Jack> The system has a large number of nodes. Physically, each node
> Jack> has the same amount of memory.  After boot, we observe that
> Jack> several nodes have substantially less memory than other
> Jack> nodes. Some of the inbalance is due to the kernel data/text
> Jack> being on node 0, but by far, the major source of in the
> Jack> inbalance is the 3 (in 2.4.x) large hash tables that are being
> Jack> allocated.
> 
> Jack> I suspect the size of the hash tables is a lot bigger than is
> Jack> needed.  That is certainly the first problem to be fixed, but
> Jack> unless the required size is a very small percentage (5-10%) of
> Jack> the amount of memory on a node (2GB to 32GB per node & 256
> Jack> nodes), we still have a problem.
> 
> Jack,
> 
> I agree with you, however as you point out, there are two problems to
> deal with, the excessive size of the hash tables on large systems and
> the imbalance that everything goes on node zero. My patch only solves
> the first problem, or rather works around it.
> 
> Solving the problem of allocating structures on multiple nodes is yet
> to be solved.

Jes 

Then I still dont understand your proposal. (I probably missed some piece
of the discussion).

You proposed above to limit the allocation to the amount of memory on a node.
I dont see that does anything on SN systems - allocation is already limited to 
that amount because memory between nodes is discontiguous. We need to limit 
the allocation to a small percentage of the memory on a node. I
dont see how we can do that without:
	
	- using vmalloc (on systems that dont have vmalloc issues)
		OR
	- changing algorithms so that a lrge hash table is not
	  needed. Either lots of smaller hash tables or ???.  I suspect
	  there are performance issues with this.
	  	OR
	- ????

I suppose I need to wait to see the proposal for allocating memory across nodes....


-- 
Thanks

Jack Steiner (steiner@sgi.com)          651-683-5302
Principal Engineer                      SGI - Silicon Graphics, Inc.



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbTK1QXc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 11:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262601AbTK1QXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 11:23:31 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:15588 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S262598AbTK1QX2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 11:23:28 -0500
To: Jack Steiner <steiner@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, Jesse Barnes <jbarnes@sgi.com>,
       viro@math.psu.edu, wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: hash table sizes
References: <16323.23221.835676.999857@gargle.gargle.HOWL>
	<20031125204814.GA19397@sgi.com>
	<20031125130741.108bf57c.akpm@osdl.org>
	<20031125211424.GA32636@sgi.com>
	<20031125132439.3c3254ff.akpm@osdl.org>
	<yq0d6bcmvfd.fsf@wildopensource.com> <20031128145255.GA26853@sgi.com>
From: Jes Sorensen <jes@wildopensource.com>
Date: 28 Nov 2003 11:22:47 -0500
In-Reply-To: <20031128145255.GA26853@sgi.com>
Message-ID: <yq08ym0mpig.fsf@wildopensource.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jack" == Jack Steiner <steiner@sgi.com> writes:

Jack> On Fri, Nov 28, 2003 at 09:15:02AM -0500, Jes Sorensen wrote:
>>  What about something like this? I believe node_present_pages
>> should be the same as nym_physpages on a non-NUMA machine. If not
>> we can make it min(num_physpages,
>> NODE_DATA(0)->node_present_pages).

Jack> The system has a large number of nodes. Physically, each node
Jack> has the same amount of memory.  After boot, we observe that
Jack> several nodes have substantially less memory than other
Jack> nodes. Some of the inbalance is due to the kernel data/text
Jack> being on node 0, but by far, the major source of in the
Jack> inbalance is the 3 (in 2.4.x) large hash tables that are being
Jack> allocated.

Jack> I suspect the size of the hash tables is a lot bigger than is
Jack> needed.  That is certainly the first problem to be fixed, but
Jack> unless the required size is a very small percentage (5-10%) of
Jack> the amount of memory on a node (2GB to 32GB per node & 256
Jack> nodes), we still have a problem.

Jack,

I agree with you, however as you point out, there are two problems to
deal with, the excessive size of the hash tables on large systems and
the imbalance that everything goes on node zero. My patch only solves
the first problem, or rather works around it.

Solving the problem of allocating structures on multiple nodes is yet
to be solved.

Cheers,
Jes

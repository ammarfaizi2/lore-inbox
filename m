Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161944AbWKJS2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161944AbWKJS2R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 13:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161941AbWKJS2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 13:28:17 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:26803 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1161944AbWKJS2Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 13:28:16 -0500
Subject: Re: [PATCH 2/3] add dev_to_node()
From: Lee Schermerhorn <Lee.Schermerhorn@hp.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Christoph Hellwig <hch@lst.de>, davem@davemloft.net,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, linux-mm@kvack.org
In-Reply-To: <Pine.LNX.4.64.0611101015060.25338@schroedinger.engr.sgi.com>
References: <20061030141501.GC7164@lst.de>
	 <20061030.143357.130208425.davem@davemloft.net>
	 <20061104225629.GA31437@lst.de>
	 <20061108114038.59831f9d.kamezawa.hiroyu@jp.fujitsu.com>
	 <Pine.LNX.4.64.0611101015060.25338@schroedinger.engr.sgi.com>
Content-Type: text/plain
Organization: HP/OSLO
Date: Fri, 10 Nov 2006 13:28:25 -0500
Message-Id: <1163183306.15159.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-10 at 10:16 -0800, Christoph Lameter wrote:
> On Wed, 8 Nov 2006, KAMEZAWA Hiroyuki wrote:
> 
> > I wonder there are no code for creating NODE_DATA() for device-only-node.
> 
> On IA64 we remap nodes with no memory / cpus to the nearest node with 
> memory. I think that is sufficient.

I don't think this happens anymore.  Back in the ~2.6.5 days, when we
would configure our numa platforms with 100% of memory interleaved [in
hardware at  cache line granularity], the cpus would move to the
interleaved "pseudo-node" and the memoryless nodes would be removed.
numactl --hardware would show something like this:

# uname -r
2.6.5-7.244-default
# numactl --hardware
available: 1 nodes (0-0)
node 0 size: 65443 MB
node 0 free: 64506 MB

I started seeing different behavior about the time SPARSEMEM went in.
Now, with a 2.6.16 base kernel [same platform, hardware interleaved
memory], I see:

# uname -r# numactl --hardware
available: 5 nodes (0-4)
node 0 size: 0 MB
node 0 free: 0 MB
node 1 size: 0 MB
node 1 free: 0 MB
node 2 size: 0 MB
node 2 free: 0 MB
node 3 size: 0 MB
node 3 free: 0 MB
node 4 size: 65439 MB
node 4 free: 64492 MB
node distances:
node   0   1   2   3   4
  0:  10  17  17  17  14
  1:  17  10  17  17  14
  2:  17  17  10  17  14
  3:  17  17  17  10  14
  4:  14  14  14  14  10
2.6.16.21-0.8-default

[Aside:  The firmware/SLIT says that the interleaved memory is closer to
all nodes that other nodes' memory.  This has interesting implications
for the "overflow" zone lists...]

Lee


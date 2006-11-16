Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424150AbWKPPVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424150AbWKPPVh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 10:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424155AbWKPPVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 10:21:37 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:51151 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S1424150AbWKPPVg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 10:21:36 -0500
Subject: Re: [patch 2/2] enables booting a NUMA system where some nodes
	have no memory
From: Lee Schermerhorn <Lee.Schermerhorn@hp.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: Martin Bligh <mbligh@mbligh.org>, Christian Krafft <krafft@de.ibm.com>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0611151440400.23201@schroedinger.engr.sgi.com>
References: <20061115193049.3457b44c@localhost>
	 <20061115193437.25cdc371@localhost>
	 <Pine.LNX.4.64.0611151323330.22074@schroedinger.engr.sgi.com>
	 <455B8F3A.6030503@mbligh.org>
	 <Pine.LNX.4.64.0611151440400.23201@schroedinger.engr.sgi.com>
Content-Type: text/plain
Organization: HP/OSLO
Date: Thu, 16 Nov 2006 10:21:49 -0500
Message-Id: <1163690509.5761.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-15 at 14:41 -0800, Christoph Lameter wrote:
> On Wed, 15 Nov 2006, Martin Bligh wrote:
> 
> > A node is an arbitrary container object containing one or more of:
> > 
> > CPUs
> > Memory
> > IO bus
> > 
> > It does not have to contain memory.
> 
> I have never seen a node on Linux without memory. I have seen nodes 
> without processors and without I/O but not without memory.This seems to be 
> something new?

I sent this out earlier in response to another message from Christoph
regarding nodes w/o memory.  Don't know if it made it...

>On Fri, 2006-11-10 at 10:16 -0800, Christoph Lameter wrote:
>> On Wed, 8 Nov 2006, KAMEZAWA Hiroyuki wrote:
>> 
>> > I wonder there are no code for creating NODE_DATA() for
device-only-node.
>> 
>> On IA64 we remap nodes with no memory / cpus to the nearest node
with 
>> memory. I think that is sufficient.

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

> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>


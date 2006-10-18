Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422990AbWJRV1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422990AbWJRV1A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 17:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422992AbWJRV07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 17:26:59 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:11448 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1422990AbWJRV06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 17:26:58 -0400
Date: Wed, 18 Oct 2006 14:26:50 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Paul Mackerras <paulus@samba.org>
cc: Will Schmidt <will_schmidt@vnet.ibm.com>, akpm@osdl.org,
       linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG in __cache_alloc_node at linux-2.6.git/mm/slab.c:3177!
In-Reply-To: <17718.39522.456361.987639@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.64.0610181421160.30438@schroedinger.engr.sgi.com>
References: <1160764895.11239.14.camel@farscape>
 <Pine.LNX.4.64.0610131158270.26311@schroedinger.engr.sgi.com>
 <1160769226.11239.22.camel@farscape> <1160773040.11239.28.camel@farscape>
 <Pine.LNX.4.64.0610131515200.28279@schroedinger.engr.sgi.com>
 <1161026409.31903.15.camel@farscape> <Pine.LNX.4.64.0610161221300.6908@schroedinger.engr.sgi.com>
 <1161031821.31903.28.camel@farscape> <Pine.LNX.4.64.0610161630430.8341@schroedinger.engr.sgi.com>
 <17717.50596.248553.816155@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.64.0610180811040.27096@schroedinger.engr.sgi.com>
 <17718.39522.456361.987639@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2006, Paul Mackerras wrote:

> > Have memory available for slab boot strap on node 0? Or modify the boot 
> > code in such a way that it runs on node 1 or any other node that has 
> > memory available.
> 
> OK, then I don't understand.  There is about 1GB of memory on node 0,
> which is about half of the partition's memory, and it is even in a
> contiguous chunk, but it doesn't start at pfn 0:

And the memory is available? In some messages it showed that all of node 0 
memory was allocated on bootup! We end up in fallback_alloc which means 
that an allocation attempt failed to obtain memory. Could you figure out 
what exactly we are trying to allocate? Add some printk's? Why do we 
fallback?

> So it's not that node 0 doesn't have any pages.  Any other clues?

We are falling back. So something is going wrong. Either we request memory 
from an overallocated node or the page allocator for some other reason is 
not giving us the requested memory. If we figure out why then the fix is 
probably very simple.

I have no way of investigating the issue except by conjecture and code 
review since I have no ppc hardware.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161163AbWJRPNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161163AbWJRPNF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 11:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161164AbWJRPNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 11:13:05 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:19892 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161163AbWJRPNC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 11:13:02 -0400
Date: Wed, 18 Oct 2006 08:12:51 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Paul Mackerras <paulus@samba.org>
cc: Will Schmidt <will_schmidt@vnet.ibm.com>, akpm@osdl.org,
       linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG in __cache_alloc_node at linux-2.6.git/mm/slab.c:3177!
In-Reply-To: <17717.50596.248553.816155@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.64.0610180811040.27096@schroedinger.engr.sgi.com>
References: <1160764895.11239.14.camel@farscape>
 <Pine.LNX.4.64.0610131158270.26311@schroedinger.engr.sgi.com>
 <1160769226.11239.22.camel@farscape> <1160773040.11239.28.camel@farscape>
 <Pine.LNX.4.64.0610131515200.28279@schroedinger.engr.sgi.com>
 <1161026409.31903.15.camel@farscape> <Pine.LNX.4.64.0610161221300.6908@schroedinger.engr.sgi.com>
 <1161031821.31903.28.camel@farscape> <Pine.LNX.4.64.0610161630430.8341@schroedinger.engr.sgi.com>
 <17717.50596.248553.816155@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2006, Paul Mackerras wrote:

> Since this is a virtualized system there is every possibility that the
> memory we get won't be divided into nodes in the nice neat manner you
> seem to be expecting.  It just depends on what memory the hypervisor
> has free, and on what nodes, when the partition is booted.

The only expectation is that memory is available on the node that you are 
bootstrapping the slab allocator from.
 
> In other words, the assumption that node pfn ranges won't overlap is
> completely untenable for us.

That does not matter for this problem.,
 
> Linus' tree is currently broken for us.  Any suggestions for how to
> fix it, since I am not very familiar with the NUMA code?

Have memory available for slab boot strap on node 0? Or modify the boot 
code in such a way that it runs on node 1 or any other node that has 
memory available.



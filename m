Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbVIWTQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbVIWTQe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 15:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbVIWTQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 15:16:34 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:50142 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751173AbVIWTQe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 15:16:34 -0400
Date: Fri, 23 Sep 2005 12:16:18 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: Ravikiran G Thirumalai <kiran@scalex86.org>, davem@davemloft.net,
       rusty@rustcorp.com.au, dipankar@in.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 0/6] mm: alloc_percpu and  bigrefs
In-Reply-To: <20050923001013.28b7f032.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0509231213040.25043@schroedinger.engr.sgi.com>
References: <20050923062529.GA4209@localhost.localdomain>
 <20050923001013.28b7f032.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Sep 2005, Andrew Morton wrote:

> big deal.  Given that alloc_percpu() is already numa-aware, is that extra
> cross-node fetch and pointer hop really worth all that new code?  The new
> version will have to do a tlb load (including a cross-node fetch)
> approximately as often as the old version will get a CPU cache miss on the
> percpu array, maybe?

The current alloc_percpu() is problematic because it has to allocate 
entries for all cpus even those who are not online yet. There is no way to 
track alloc_percpu entries and therefore no possibility of adding an entry 
for a processor if one comes online or for removing one when a processor 
goes away.

An additional complication is the allocation of per cpu entries for 
processors whose memory node are not online. The current 
implementation will fall back on a unspecific allocation but this means 
that the placement of the per cpu entries will not be on the node of the 
processor!

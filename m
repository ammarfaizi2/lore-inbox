Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261597AbULTTKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbULTTKh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 14:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbULTTKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 14:10:37 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:7053 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261597AbULTTKc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 14:10:32 -0500
Date: Tue, 21 Dec 2004 00:55:58 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Reimplementation of linux dynamic percpu memory allocator
Message-ID: <20041220192558.GA17194@in.ibm.com>
References: <41C35DD6.1050804@colorfullife.com> <20041220182057.GA16859@in.ibm.com> <41C718C7.1020908@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41C718C7.1020908@colorfullife.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2004 at 07:24:07PM +0100, Manfred Spraul wrote:
> >
> No, not fast path. But it can happen a few thousand times. The slab 
> implementation failed due to heavy internal fragmentation. If your code 
> runs fine with a few thousand users, then there shouldn't be a problem.

If there is a stress test I can use, I can try running it.

> >>>     
> >..
> For non-NUMA systems, I would use get_free_pages() to allocate a 
> multi-page area instead of map_vm_area(). Typically, get_free_pages() is 
> backed by large pte memory and map_vm_area() by normal virtual memory.

Hmm...the arithmetic becomes tricky then.  Right now I allocate
NR_CPUS * PCU_BLOCKSIZE + BLOCK_MANAGEMENT_SIZE amount of KVA for a block,
allocate pages for cpu_possible cpus and map corresponding va space
with allocated pages using map_vm_area.  We may fragment if
NR_CPUS * PCPU_BLOCKSIZE doesn't fit into a proper page order,
also we'd be wasting pages for !cpu_possible(cpus) of NR_CPUS

Thanks,
Kiran

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265746AbUFOQnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265746AbUFOQnY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 12:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265772AbUFOQnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 12:43:24 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:41126 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265746AbUFOQnX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 12:43:23 -0400
Subject: Re: [PATCH] Permit inode & dentry hash tables to be allocated >
	MAX_ORDER size
From: Dave Hansen <haveblue@us.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andi Kleen <ak@muc.de>, torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <113620000.1087052452@[10.10.2.4]>
References: <263jX-5RZ-19@gated-at.bofh.it> <262nZ-56Z-5@gated-at.bofh.it>
	 <263jX-5RZ-17@gated-at.bofh.it> <m3d645fwxj.fsf@averell.firstfloor.org>
	 <1087025760.18615.3.camel@nighthawk> <20040612131149.GA28870@colin2.muc.de>
	 <113620000.1087052452@[10.10.2.4]>
Content-Type: text/plain
Message-Id: <1087226661.18615.1752.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 15 Jun 2004 09:40:53 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-06-12 at 08:00, Martin J. Bligh wrote:
> >> Since vmalloc() maps the pages with small pagetable entries (unlike most
> >> of the rest of the kernel address space), do you think the interleaving
> >> will outweigh any negative TLB effects?  
> > 
> > I think so, yes (assuming you run the benchmark on all CPUs)
> 
> On the other hand, there's no reason we can't hack up a version of vmalloc
> to use large pages, and interleave only based on that. 

Think about ppc64 where the large page size is 16MB.  That might hurt
interleaving a bit if the structure is only 32MB.  It's better than
*everything* on node 0, but not by much.  

-- Dave


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264665AbUFLHhH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264665AbUFLHhH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 03:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264668AbUFLHhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 03:37:07 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:49892 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264665AbUFLHhF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 03:37:05 -0400
Subject: Re: [PATCH] Permit inode & dentry hash tables to be allocated >
	MAX_ORDER size
From: Dave Hansen <haveblue@us.ibm.com>
To: Andi Kleen <ak@muc.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <m3d645fwxj.fsf@averell.firstfloor.org>
References: <263jX-5RZ-19@gated-at.bofh.it> <262nZ-56Z-5@gated-at.bofh.it>
	 <263jX-5RZ-17@gated-at.bofh.it>  <m3d645fwxj.fsf@averell.firstfloor.org>
Content-Type: text/plain
Message-Id: <1087025760.18615.3.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 12 Jun 2004 00:36:01 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-06-11 at 17:21, Andi Kleen wrote:
> "Martin J. Bligh" <mbligh@aracnet.com> writes:
> >
> > Allocating the big-assed hashes out of bootmem seems much cleaner to me,
> > at least ...
> 
> Machines big enough that such big hashes make sense are probably NUMA.
> And on NUMA systems you imho should rather use node interleaving vmalloc(),
> not a bit physical allocation on a specific node for these hashes. 
> This will avoid memory controller hot spots and avoid the problem completely.
> Likely it will perform better too.

Since vmalloc() maps the pages with small pagetable entries (unlike most
of the rest of the kernel address space), do you think the interleaving
will outweigh any negative TLB effects?  

-- Dave


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbVGEPou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbVGEPou (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 11:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbVGEPot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 11:44:49 -0400
Received: from dvhart.com ([64.146.134.43]:41652 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261890AbVGEPbp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 11:31:45 -0400
Date: Tue, 05 Jul 2005 08:31:40 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Sonny Rao <sonny@burdell.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Christoph Lameter'" <christoph@lameter.com>,
       "'Badari Pulavarty'" <pbadari@us.ibm.com>,
       "'Nick Piggin'" <nickpiggin@yahoo.com.au>, Lincoln Dale <ltd@cisco.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [rfc] lockless pagecache
Message-ID: <54750000.1120577500@[10.10.2.4]>
In-Reply-To: <20050705151119.GA12279@kevlar.burdell.org>
References: <Pine.LNX.4.62.0506271221540.21616@graphe.net> <200506271942.j5RJgig23410@unix-os.sc.intel.com> <20050705151119.GA12279@kevlar.burdell.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > On Mon, 27 Jun 2005, Chen, Kenneth W wrote:
>> > > I don't recall seeing tree_lock to be a problem for DSS workload either.
>> > 
>> > I have seen the tree_lock being a problem a number of times with large 
>> > scale NUMA type workloads.
>> 
>> I totally agree!  My earlier posts are strictly referring to industry
>> standard db workloads (OLTP, DSS).  I'm not saying it's not a problem
>> for everyone :-)  Obviously you just outlined a few ....
> 
> I'm a bit late to the party here (was gone on vacation), but I do have
> profiles from DSS workloads using page-cache rather than O_DIRECT and
> I do see spin_lock_irq() in the profiles which I'm pretty certain are
> locks spinning for access to the radix_tree.  I'll talk about it a bit
> more up in Ottawa but here's the top 5 on my profile (sorry don't have
> the number of ticks at the momement):
> 
> 1. dedicated_idle (waiting for I/O)
> 2. __copy_tofrom_user
> 3. radix_tree_delete
> 4. _spin_lock_irq
> 5. __find_get_block
> 
> So, yes, if the page-cache is used in a DSS workload then one will see
> the tree-lock.  BTW, this was on a PPC64 machine w/ a fairly small
> NUMA factor.

The easiest way to confirm the spin-lock thing is to recompile with 
CONFIG_SPINLINE, and take a new profile, then diff the two ...

M.


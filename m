Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262986AbVDBDdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262986AbVDBDdV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 22:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262984AbVDBDcC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 22:32:02 -0500
Received: from fmr23.intel.com ([143.183.121.15]:58260 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S262983AbVDBDba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 22:31:30 -0500
Date: Fri, 1 Apr 2005 19:31:21 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, mingo@elte.hu,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch] sched: remove unnecessary sched domains
Message-ID: <20050401193121.B5598@unix-os.sc.intel.com>
References: <20050401162039.A4320@unix-os.sc.intel.com> <424DFE5F.2040804@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <424DFE5F.2040804@yahoo.com.au>; from nickpiggin@yahoo.com.au on Sat, Apr 02, 2005 at 12:07:27PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 02, 2005 at 12:07:27PM +1000, Nick Piggin wrote:
> Siddha, Suresh B wrote:
> > Appended patch removes the unnecessary scheduler domains(containing
> > only one sched group) setup during the sched-domain init.
> > 
> > For example on x86_64, we always have NUMA configured in. On Intel EM64T
> > systems, top most sched domain will be of NUMA and with only one sched_group in
> > it. 
> > 
> > With fork/exec balances(recent Nick's fixes in -mm tree), we always endup 
> > taking wrong decisions because of this topmost domain (as it contains only 
> > one group and find_idlest_group always returns NULL). We will endup loading 
> > HT package completely first, letting active load balance kickin and correct it.
> > 
> > In general, this patch also makes sense with out recent Nick's fixes
> > in -mm.
> > 
> 
> Yeah, this makes sense. We may want to add some other criteria on the
> removal of a domain as well (because some of the domain flags do things
> that don't use groups).
> 
> I don't like so much that we'd rely on it to fix the above problem.
> There are a general class of problems with the fork/exec balancing in
> that it only works on the top most domain, so it may not spread load over
> lower domains very well.
> 
> I was thinking we could fix that by running balance on fork/exec multiple
> times from top to bottom level domains. I'll have to measure the cost of
> doing that, because it may be worthwhile.

Agreed.

BTW, why are we setting SD_BALANCE_FORK flag for NUMA domain on i386, ia64.
This should be set only on x86_64 and that too not for Intel systems.

thanks,
suresh

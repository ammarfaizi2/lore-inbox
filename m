Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266386AbUJIBIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266386AbUJIBIW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 21:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266236AbUJIBIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 21:08:17 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:20962 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266386AbUJIBHi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 21:07:38 -0400
Subject: Re: [Lse-tech] [RFC PATCH] scheduler: Dynamic sched_domains
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Erich Focht <efocht@hpce.nec.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       LSE Tech <lse-tech@lists.sourceforge.net>, Paul Jackson <pj@sgi.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       ckrm-tech@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>,
       simon.derr@bull.net, frankeh@watson.ibm.com
In-Reply-To: <200410090051.18693.efocht@hpce.nec.com>
References: <1097110266.4907.187.camel@arrakis>
	 <200410081214.20907.efocht@hpce.nec.com> <41666E90.2000208@yahoo.com.au>
	 <200410090051.18693.efocht@hpce.nec.com>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1097283956.6470.152.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 08 Oct 2004 18:05:56 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-08 at 15:51, Erich Focht wrote:
> Hmmm, this is unusable as long as you don't tell me how to create new
> levels and link them together. Adding CPUs is the simplest
> part. I'm with Matt here, the filesystem approach is the most
> elegant. On the other hand something simple for the start wouldn't be
> bad. It would show immediately whether Matt's or your way of dealing
> with domains is better suited for relinking and reorganising the
> domains structure dynamically. Functionality could be something like:
> - list domains
> - create domain
> - add child domains
> - link in parent domain
> We're building this from bottom (cpus) up and need to take care of the
> unlinking of the global domain when inserting something. But otherwise
> this could be sufficient.
> 
> Regards,
> Erich

I personally like to think of it from the top down.  The internal API I
came up with looks like:

create_domain(parent_domain, type);
destroy_domain(domain);
add_cpu_to_domain(cpu, domain);

So you basically build your domain from the top down, from your 1 or
more top-level domains, down to your lowest level domains.  You then add
cpus (1 or more per domain) to the leaf domains in the tree you built. 
Those cpus cascade up the tree, and the whole tree knows exactly which
cpus are contained in each domain in it.

I think these are the three main functions you need to construct pretty
much any conceivable, useful sched_domains hierarchy.

-Matt


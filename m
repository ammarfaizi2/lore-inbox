Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268280AbUJJMsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268280AbUJJMsN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 08:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268295AbUJJMsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 08:48:13 -0400
Received: from mail01.hpce.nec.com ([193.141.139.228]:46780 "EHLO
	mail01.hpce.nec.com") by vger.kernel.org with ESMTP id S268280AbUJJMsK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 08:48:10 -0400
From: Erich Focht <efocht@hpce.nec.com>
To: colpatch@us.ibm.com
Subject: Re: [Lse-tech] [RFC PATCH] scheduler: Dynamic sched_domains
Date: Sun, 10 Oct 2004 14:45:58 +0200
User-Agent: KMail/1.6.2
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       LSE Tech <lse-tech@lists.sourceforge.net>, Paul Jackson <pj@sgi.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       ckrm-tech@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>,
       simon.derr@bull.net, frankeh@watson.ibm.com
References: <1097110266.4907.187.camel@arrakis> <200410090051.18693.efocht@hpce.nec.com> <1097283956.6470.152.camel@arrakis>
In-Reply-To: <1097283956.6470.152.camel@arrakis>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410101445.58897.efocht@hpce.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 09 October 2004 03:05, Matthew Dobson wrote:
> On Fri, 2004-10-08 at 15:51, Erich Focht wrote:
> > We're building this from bottom (cpus) up and need to take care of the
> > unlinking of the global domain when inserting something. But otherwise
> > this could be sufficient.
> 
> I personally like to think of it from the top down.  The internal API I
> came up with looks like:
> 
> create_domain(parent_domain, type);
> destroy_domain(domain);
> add_cpu_to_domain(cpu, domain);
> 
> So you basically build your domain from the top down, from your 1 or
> more top-level domains, down to your lowest level domains.  You then add
> cpus (1 or more per domain) to the leaf domains in the tree you built. 
> Those cpus cascade up the tree, and the whole tree knows exactly which
> cpus are contained in each domain in it.
> 
> I think these are the three main functions you need to construct pretty
> much any conceivable, useful sched_domains hierarchy.

I'd suggest adding:
reparent_domain(domain, new_parent_domain);

When I said that the domains tree is standing on its leaves I meant
that the core components are the CPUs. Or the Nodes, if you already
have them. Or some supernodes, if you already have them. In a "normal"
filesystem you have the root directory, create subdirectories and
create files in them. Here you already have the files but not the
structure (or the simplest possible structure).

Anyhow, the 4 command API can well be the guts of the directory
operations API which I proposed.

Regards,
Erich


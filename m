Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262279AbULOHrB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbULOHrB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 02:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262300AbULOHrB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 02:47:01 -0500
Received: from news.suse.de ([195.135.220.2]:54400 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262279AbULOHqh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 02:46:37 -0500
Date: Wed, 15 Dec 2004 08:46:36 +0100
From: Andi Kleen <ak@suse.de>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Andi Kleen <ak@suse.de>, Brent Casavant <bcasavan@sgi.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, linux-ia64@vger.kernel.org
Subject: Re: [PATCH 0/3] NUMA boot hash allocation interleaving
Message-ID: <20041215074636.GR27225@wotan.suse.de>
References: <Pine.SGI.4.61.0412141140030.22462@kzerza.americas.sgi.com> <9250000.1103050790@flay> <20041214191348.GA27225@wotan.suse.de> <19030000.1103054924@flay> <Pine.SGI.4.61.0412141720420.22462@kzerza.americas.sgi.com> <20041215040854.GC27225@wotan.suse.de> <41BFEAA5.1090109@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41BFEAA5.1090109@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2004 at 08:41:25AM +0100, Eric Dumazet wrote:
> 
> My questions are :
> 
> 1) Are the route cache and tcp hashes use big pages (2MB) on 2.6.5/2.6.9 
> x86_64 kernels.

Yes.

On i386 kernels you can use mem=nopentium to force 4K pages for
the direct mapping, but that was dropped on x86-64. 

> 2) What are the exact number of data TLB entries (for small pages and 
> huge ones) for opterons ?

check the data sheets, but iirc 64 large DTLBs and 1024+ 4K DTLBS.
That is the L2 TLB, there is also a L1 but it is likely inclusive (?)

> 3) All networks interrupts are handled by CPU0. Should we really use 
> NUMA interleaved memory for hashes in this case ?

First it depends on if you run irqbalanced or not and how many
interrupt sources you have.

Even when they are only handled on irq0 it can be still a good idea
to interleave to use the bandwidth of all memory controllers
in the system evenly.

-Andi

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265807AbUFIPsC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265807AbUFIPsC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 11:48:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265808AbUFIPsC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 11:48:02 -0400
Received: from ozlabs.org ([203.10.76.45]:27872 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265807AbUFIPr4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 11:47:56 -0400
Date: Thu, 10 Jun 2004 01:44:29 +1000
From: Anton Blanchard <anton@samba.org>
To: Andi Kleen <ak@suse.de>
Cc: manfred@colorfullife.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use numa policy API for boot time policy
Message-ID: <20040609154429.GA6152@krispykreme>
References: <20040605034356.1037d299.ak@suse.de> <40C12865.9050803@colorfullife.com> <20040605041813.75e2d22d.ak@suse.de> <20040605023211.GA16084@krispykreme> <20040605122239.4a73f5e8.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040605122239.4a73f5e8.ak@suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> It would be a one liner change to allow process policy interleaving 
> for orders > 0 in mempolicy. But I'm not sure how useful it is, since
> the granuality would be really bad.

OK. Id like to take a quick look at order > 0 allocations during boot
to see if its worth it. The ppc64 page size is small and we might be
doing a significant number of order 1 allocations.

> Have you ever tried to switch to implement a vmalloc_interleave() for these
> tables instead? My bet is that it will perform better.

Im warming to this idea. We would need a per arch override, since there
is a trade off here between interleaving and TLB usage.

We also have a problem in 2.6 on our bigger machines where our dcache
hash and inode hash cache are limited to MAX_ORDER (16MB on ppc64). By
using vmalloc would allow us to interleave the memory and allocate more
than 16MB for those hashes.

Anton

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264586AbUFEKYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264586AbUFEKYz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 06:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264398AbUFEKYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 06:24:55 -0400
Received: from cantor.suse.de ([195.135.220.2]:65504 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266069AbUFEKWl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 06:22:41 -0400
Date: Sat, 5 Jun 2004 12:22:39 +0200
From: Andi Kleen <ak@suse.de>
To: Anton Blanchard <anton@samba.org>
Cc: manfred@colorfullife.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use numa policy API for boot time policy
Message-Id: <20040605122239.4a73f5e8.ak@suse.de>
In-Reply-To: <20040605023211.GA16084@krispykreme>
References: <20040605034356.1037d299.ak@suse.de>
	<40C12865.9050803@colorfullife.com>
	<20040605041813.75e2d22d.ak@suse.de>
	<20040605023211.GA16084@krispykreme>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Jun 2004 12:32:12 +1000
Anton Blanchard <anton@samba.org> wrote:

>  
> Hi,
> 
> > That's correct. It will only work for order 0 allocations.
> > 
> > But it sounds quite bogus anyways to move the complete hash tables
> > to another node anyways. It would probably be better to use vmalloc() 
> > and a interleaving mapping for it. Then you would get the NUMA bandwidth 
> > benefit even for accessing single tables.
> 
> I posted some before and after numbers when we merged Manfreds patch,
> it would be interesting to see the same thing with your patch applied.
> 
> Im not only worried about NUMA bandwidth but keeping the amount of
> memory left in all the nodes reasonably even. Allocating all the big
> hashes on node 0 will decrease that balance.

It would be a one liner change to allow process policy interleaving 
for orders > 0 in mempolicy. But I'm not sure how useful it is, since
the granuality would be really bad.

Have you ever tried to switch to implement a vmalloc_interleave() for these
tables instead? My bet is that it will perform better.

-Andi

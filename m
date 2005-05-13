Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262105AbVEMLeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbVEMLeP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 07:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262252AbVEMLeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 07:34:15 -0400
Received: from fire.osdl.org ([65.172.181.4]:53387 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262105AbVEMLd4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 07:33:56 -0400
Date: Fri, 13 May 2005 04:33:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, shai@scalex86.org,
       steiner@sgi.com
Subject: Re: NUMA aware slab allocator V2
Message-Id: <20050513043311.7961e694.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505130411300.4500@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0505110816020.22655@schroedinger.engr.sgi.com>
	<20050512000444.641f44a9.akpm@osdl.org>
	<Pine.LNX.4.58.0505121252390.32276@schroedinger.engr.sgi.com>
	<20050513000648.7d341710.akpm@osdl.org>
	<Pine.LNX.4.58.0505130411300.4500@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@engr.sgi.com> wrote:
>
> On Fri, 13 May 2005, Andrew Morton wrote:
> 
> > It didn't produce anything interesting.  For some reason the console output
> > stops when start_kernel() runs console_init() (I guess it all comes out
> > later) so the machine is running blind when we run kmem_cache_init().
> > Irritating.  I just moved the console_init() call to happen later on.
> >
> > It's going BUG() in kmem_cache_init()->set_up_list3s->is_node_online
> > because for some reason the !CONFIG_NUMA ppc build has MAX_NUMNODES=16,
> > even though there's only one node.
> 
> Yuck.
> 
> The definition for the number of NUMA nodes is dependent on
> CONFIG_FLATMEM instead of CONFIG_NUMA in mm.
> CONFIG_FLATMEM is not set on ppc64 because CONFIG_DISCONTIG is set! And
> consequently nodes exist in a non NUMA config.

I was testing 2.6.12-rc4 base.



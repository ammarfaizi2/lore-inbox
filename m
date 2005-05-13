Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261357AbVEMLVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbVEMLVg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 07:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbVEMLVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 07:21:36 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:4296 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261357AbVEMLVe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 07:21:34 -0400
Date: Fri, 13 May 2005 04:21:23 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, shai@scalex86.org,
       steiner@sgi.com
Subject: Re: NUMA aware slab allocator V2
In-Reply-To: <20050513000648.7d341710.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0505130411300.4500@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0505110816020.22655@schroedinger.engr.sgi.com>
 <20050512000444.641f44a9.akpm@osdl.org> <Pine.LNX.4.58.0505121252390.32276@schroedinger.engr.sgi.com>
 <20050513000648.7d341710.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 May 2005, Andrew Morton wrote:

> It didn't produce anything interesting.  For some reason the console output
> stops when start_kernel() runs console_init() (I guess it all comes out
> later) so the machine is running blind when we run kmem_cache_init().
> Irritating.  I just moved the console_init() call to happen later on.
>
> It's going BUG() in kmem_cache_init()->set_up_list3s->is_node_online
> because for some reason the !CONFIG_NUMA ppc build has MAX_NUMNODES=16,
> even though there's only one node.

Yuck.

The definition for the number of NUMA nodes is dependent on
CONFIG_FLATMEM instead of CONFIG_NUMA in mm.
CONFIG_FLATMEM is not set on ppc64 because CONFIG_DISCONTIG is set! And
consequently nodes exist in a non NUMA config.

s/CONFIG_NUMA/CONFIG_FLATMEM/ ??


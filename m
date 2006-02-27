Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbWB0VxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWB0VxX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 16:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbWB0VxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 16:53:23 -0500
Received: from ns2.suse.de ([195.135.220.15]:51840 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750716AbWB0VxW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 16:53:22 -0500
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: [PATCH 01/02] cpuset memory spread slab cache filesys
Date: Mon, 27 Feb 2006 22:02:33 +0100
User-Agent: KMail/1.9.1
Cc: Paul Jackson <pj@sgi.com>, dgc@sgi.com, steiner@sgi.com,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, clameter@sgi.com
References: <20060227070209.1994.26823.sendpatchset@jackhammer.engr.sgi.com> <200602272149.51257.ak@suse.de> <Pine.LNX.4.64.0602271253030.8274@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0602271253030.8274@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602272202.34346.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 February 2006 21:56, Christoph Lameter wrote:

> 
> We could make the memory policy only apply if the SLAB_MEM_SPREAD option 
> is set:

Which memory policy? The one of the process?

> Index: linux-2.6.16-rc4-mm2/mm/slab.c
> ===================================================================
> --- linux-2.6.16-rc4-mm2.orig/mm/slab.c	2006-02-24 10:33:54.000000000 -0800
> +++ linux-2.6.16-rc4-mm2/mm/slab.c	2006-02-27 12:54:52.000000000 -0800
> @@ -2871,7 +2871,9 @@ static void *alternate_node_alloc(struct
>  	if (in_interrupt())
>  		return NULL;
>  	nid_alloc = nid_here = numa_node_id();
> -	if (cpuset_do_slab_mem_spread() && (cachep->flags & SLAB_MEM_SPREAD))
> +	if (!cachep->flags & SLAB_MEM_SPREAD)

brackets missing I guess.

> +		return NULL;
> +	if (cpuset_do_slab_mem_spread())
>  		nid_alloc = cpuset_mem_spread_node();
>  	else if (current->mempolicy)
>  		nid_alloc = slab_node(current->mempolicy);
> 

-Andi

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932623AbWFVTek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932623AbWFVTek (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 15:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932630AbWFVTek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 15:34:40 -0400
Received: from sbz-30.cs.helsinki.fi ([128.214.9.98]:32433 "EHLO
	sbz-30.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S932623AbWFVTej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 15:34:39 -0400
Date: Thu, 22 Jun 2006 22:34:38 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Christoph Lameter <clameter@sgi.com>
cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@kvack.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Theodore Tso <tytso@mit.edu>,
       Dave Chinner <dgc@sgi.com>, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 4/4] Slab Reclaim logic
In-Reply-To: <20060619184712.23130.65271.sendpatchset@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0606222231390.5385@sbz-30.cs.Helsinki.FI>
References: <20060619184651.23130.62875.sendpatchset@schroedinger.engr.sgi.com>
 <20060619184712.23130.65271.sendpatchset@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2006, Christoph Lameter wrote:
> @@ -221,8 +221,9 @@ struct slab {
>  	unsigned long colouroff;
>  	void *s_mem;		/* including colour offset */
>  	unsigned int inuse;	/* num of objs active in slab */
> -	kmem_bufctl_t free;
>  	unsigned short nodeid;
> +	unsigned short marker;
> +	kmem_bufctl_t free;

[snip]

> @@ -298,6 +299,7 @@ struct kmem_list3 {
>  	struct array_cache **alien;	/* on other nodes */
>  	unsigned long next_reap;	/* updated without locking */
>  	int free_touched;		/* updated without locking */
> +	atomic_t reclaim;			/* Reclaim in progress */
>  };

Hmm, we don't need 'marker' and 'reclaim' if SLAB_RECLAIM is not set, 
right?  I don't think we want to bloat struct slab and struct kmem_list3 
for everyone.  What's marker used for?  Why can't we just take the list 
lock instead of 'reclaim'?

				Pekka

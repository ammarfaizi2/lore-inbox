Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbVJaIPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbVJaIPe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 03:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbVJaIPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 03:15:34 -0500
Received: from smtp.osdl.org ([65.172.181.4]:59864 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750735AbVJaIPe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 03:15:34 -0500
Date: Mon, 31 Oct 2005 01:15:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm: rename kmem_cache_s to kmem_cache
Message-Id: <20051031011501.3caeba18.akpm@osdl.org>
In-Reply-To: <ip33z2.vtcnft.4nw33ugftrecz8r4nb1via846.beaver@cs.helsinki.fi>
References: <ip33z2.vtcnft.4nw33ugftrecz8r4nb1via846.beaver@cs.helsinki.fi>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg <penberg@cs.helsinki.fi> wrote:
>
> This patch renames struct kmem_cache_s to kmem_cache so we can start using it
>  instead of kmem_cache_t typedef.

Well I stared at these diffs for a long time.  They don't really add a lot
of value to the kernel and they do risk breaking other people's patches. 
Generally they have a high hassle/value ratio.

I could merge them up and see how it goes, but given that there are many
more kmem_cache_t->struct kmem_cache conversions to go, and that I hit
seven rejects in mm/slab.c, I think I'll duck the patches, sorry.


> -void filp_ctor(void * objp, struct kmem_cache_s *cachep, unsigned long cflags)
> +void filp_ctor(void * objp, struct kmem_cache *cachep, unsigned long cflags)

See the inconsistent coding style there?  This would have been a zero-cost
opportunity to fix that up.  (Nuke the space after the asterisk).

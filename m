Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271118AbTHOVa3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 17:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271123AbTHOVa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 17:30:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:62951 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271118AbTHOVa1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 17:30:27 -0400
Date: Fri, 15 Aug 2003 14:16:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] slab debug vs. L1 alignement
Message-Id: <20030815141614.29fc6768.akpm@osdl.org>
In-Reply-To: <1060956004.581.13.camel@gaston>
References: <1060956004.581.13.camel@gaston>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> Currently, when enabling slab debugging, we lose the property of
> having the objects aligned on a cache line size.
> 
> This is, imho, an error, especially if GFP_DMA is passed. Such an
> object _must_ be cache alined (and it's size rounded to a multiple
> of the cache line size).

Well the theory is that SLAB_HWCACHE_ALIGN is advisory and
SLAB_MUST_HWCACHE_ALIGN is compulsory.

You're looking for compulsory alignment on the generic kmalloc() slab
pools, so we're a bit screwed.

I guess the redzoning would need to be taught to always pad by a full
cacheline.


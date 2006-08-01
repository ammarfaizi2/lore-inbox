Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932655AbWHALKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932655AbWHALKl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 07:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932660AbWHALJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 07:09:55 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:14865 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S932655AbWHALHB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 07:07:01 -0400
Date: Tue, 1 Aug 2006 21:06:58 +1000
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [BLOCK] bh: Ensure bh fits within a page
Message-ID: <20060801110658.GA5388@gondor.apana.org.au>
References: <20060801030443.GA2221@gondor.apana.org.au> <20060731210418.084f9f5d.akpm@osdl.org> <20060801050259.GA3126@gondor.apana.org.au> <20060731225454.19981a5f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060731225454.19981a5f.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2006 at 10:54:54PM -0700, Andrew Morton wrote:
> 
> Crap, that's hard to fix.   Am I allowed to blame submit_bh()? ;)

Sure you're allowed to do anything :)

> uhm, we don't want to lose kmalloc redzoning, so I guess we need to create
> on-demand ext3-private slab caches for 1024, 2048, and 4096 bytes.  With
> the appropriate slab flags to defeat the redzoning.

Either that or we should fix redzoning so that it actually preserves
alignment, rather than turning off debugging whenever we want alignment.
Basically it means that we need to use twice the amount of memory for
each object (so 2K for each 1K object).  Is this acceptable for debugging?

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

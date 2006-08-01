Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161010AbWHAOqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161010AbWHAOqH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 10:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161024AbWHAOqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 10:46:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64216 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161010AbWHAOqE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 10:46:04 -0400
Date: Tue, 1 Aug 2006 07:45:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [BLOCK] bh: Ensure bh fits within a page
Message-Id: <20060801074556.b9e772bc.akpm@osdl.org>
In-Reply-To: <20060801110658.GA5388@gondor.apana.org.au>
References: <20060801030443.GA2221@gondor.apana.org.au>
	<20060731210418.084f9f5d.akpm@osdl.org>
	<20060801050259.GA3126@gondor.apana.org.au>
	<20060731225454.19981a5f.akpm@osdl.org>
	<20060801110658.GA5388@gondor.apana.org.au>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Aug 2006 21:06:58 +1000
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> On Mon, Jul 31, 2006 at 10:54:54PM -0700, Andrew Morton wrote:
> > 
> > Crap, that's hard to fix.   Am I allowed to blame submit_bh()? ;)
> 
> Sure you're allowed to do anything :)
> 
> > uhm, we don't want to lose kmalloc redzoning, so I guess we need to create
> > on-demand ext3-private slab caches for 1024, 2048, and 4096 bytes.  With
> > the appropriate slab flags to defeat the redzoning.
> 
> Either that or we should fix redzoning so that it actually preserves
> alignment, rather than turning off debugging whenever we want alignment.
> Basically it means that we need to use twice the amount of memory for
> each object (so 2K for each 1K object).  Is this acceptable for debugging?

It doesn't sound like a good idea.  At present CONFIG_DEBUG_SLAB is
acceptable for production use (although it makes kernel profiles look
pretty sad).  Doubling the size of the slabs would rather alter that.

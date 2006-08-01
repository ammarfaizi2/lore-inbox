Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751291AbWHAFzB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbWHAFzB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 01:55:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751574AbWHAFzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 01:55:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8598 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751291AbWHAFzA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 01:55:00 -0400
Date: Mon, 31 Jul 2006 22:54:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [BLOCK] bh: Ensure bh fits within a page
Message-Id: <20060731225454.19981a5f.akpm@osdl.org>
In-Reply-To: <20060801050259.GA3126@gondor.apana.org.au>
References: <20060801030443.GA2221@gondor.apana.org.au>
	<20060731210418.084f9f5d.akpm@osdl.org>
	<20060801050259.GA3126@gondor.apana.org.au>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Aug 2006 15:02:59 +1000
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> On Mon, Jul 31, 2006 at 09:04:18PM -0700, Andrew Morton wrote:
> > 
> > Could we have a more detailed description?
> 
> Sure, this particular instance is in journal_write_metadata_buffer
> where the bh may be constructed from kmalloc memory (search for the
> call to jbd_rep_kmalloc).  Because the memory returned by kmalloc
> may straddle a page (when slab debugging is enabled that is), this
> causes a broken bh to be injected into submit_bh.
> 

Crap, that's hard to fix.   Am I allowed to blame submit_bh()? ;)

uhm, we don't want to lose kmalloc redzoning, so I guess we need to create
on-demand ext3-private slab caches for 1024, 2048, and 4096 bytes.  With
the appropriate slab flags to defeat the redzoning.

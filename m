Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161021AbWHAFDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161021AbWHAFDE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 01:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161026AbWHAFDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 01:03:03 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:49163 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1161021AbWHAFDC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 01:03:02 -0400
Date: Tue, 1 Aug 2006 15:02:59 +1000
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BLOCK] bh: Ensure bh fits within a page
Message-ID: <20060801050259.GA3126@gondor.apana.org.au>
References: <20060801030443.GA2221@gondor.apana.org.au> <20060731210418.084f9f5d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060731210418.084f9f5d.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2006 at 09:04:18PM -0700, Andrew Morton wrote:
> 
> Could we have a more detailed description?

Sure, this particular instance is in journal_write_metadata_buffer
where the bh may be constructed from kmalloc memory (search for the
call to jbd_rep_kmalloc).  Because the memory returned by kmalloc
may straddle a page (when slab debugging is enabled that is), this
causes a broken bh to be injected into submit_bh.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030452AbWHXSyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030452AbWHXSyM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 14:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030457AbWHXSyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 14:54:12 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:47315 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030452AbWHXSyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 14:54:11 -0400
Date: Thu, 24 Aug 2006 19:53:42 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, akpm@osdl.org,
       lkml <linux-kernel@vger.kernel.org>,
       ext2-devel <Ext2-devel@lists.sourceforge.net>
Subject: Re: [RFC][PATCH] Manage jbd allocations from its own slabs
Message-ID: <20060824185342.GA20935@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Badari Pulavarty <pbadari@us.ibm.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, akpm@osdl.org,
	lkml <linux-kernel@vger.kernel.org>,
	ext2-devel <Ext2-devel@lists.sourceforge.net>
References: <1156374495.30517.5.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156374495.30517.5.camel@dyn9047017100.beaverton.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2006 at 04:08:15PM -0700, Badari Pulavarty wrote:
> Hi,
> 
> Here is the fix to "bh: Ensure bh fits within a page" problem
> caused by JBD.
> 
> BTW, I realized that this problem can happen only with 1k, 2k
> filesystems - as 4k, 8k allocations disable slab debug 
> automatically. But for completeness, I created slabs for those
> also.
> 
> What do you think ? I ran basic tests and things are fine.

Why can't you just use alloc_page?  I bet the whole slab overhead
eats more memory than what's wasted when using alloc_pages.  Especially
as the typical usecase is a 4k blocks filesystem with 4k pagesize
where the overhead of alloc_page is non-existant.

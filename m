Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422630AbWHYCYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422630AbWHYCYH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 22:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751630AbWHYCYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 22:24:07 -0400
Received: from thunk.org ([69.25.196.29]:53645 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751394AbWHYCYE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 22:24:04 -0400
Date: Thu, 24 Aug 2006 22:24:05 -0400
From: Theodore Tso <tytso@mit.edu>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, akpm@osdl.org,
       lkml <linux-kernel@vger.kernel.org>,
       ext2-devel <Ext2-devel@lists.sourceforge.net>
Subject: Re: [Ext2-devel] [RFC][PATCH] Manage jbd allocations from its own slabs
Message-ID: <20060825022405.GA3692@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Badari Pulavarty <pbadari@us.ibm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Herbert Xu <herbert@gondor.apana.org.au>, akpm@osdl.org,
	lkml <linux-kernel@vger.kernel.org>,
	ext2-devel <Ext2-devel@lists.sourceforge.net>
References: <1156374495.30517.5.camel@dyn9047017100.beaverton.ibm.com> <20060824185342.GA20935@infradead.org> <44EDF9DD.3040904@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44EDF9DD.3040904@us.ibm.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 12:11:25PM -0700, Badari Pulavarty wrote:
> > Why can't you just use alloc_page?  I bet the whole slab overhead
> > eats more memory than what's wasted when using alloc_pages.  Especially
> > as the typical usecase is a 4k blocks filesystem with 4k pagesize
> > where the overhead of alloc_page is non-existant.
> 
> Yes. That was what proposed earlier. But for 1k, 2k allocations we
> end up wasting whole page.  Isn't it ? Thats why I created right
> sized slabs and disable slab-debug.  I guess, I can do this only for
> 1k, 2k filesystems and directly use alloc_page() for 4k and 8k - but
> that would make code ugly and also it doesn't handle cases for
> bigger base pagesize systems (64k power).

Is there some way we can cleanly have a shortcut case where we use
alloc_page() if fs_blocksize == PAGE_SIZE?  The efficiency gains for
what will be the common case on many architectures will probably make
this worthwhile....

						- Ted

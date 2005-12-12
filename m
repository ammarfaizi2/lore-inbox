Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbVLLR0B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbVLLR0B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 12:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbVLLR0B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 12:26:01 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:37513 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932074AbVLLR0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 12:26:00 -0500
Date: Mon, 12 Dec 2005 17:25:52 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, fujita.tomonori@lab.ntt.co.jp,
       michaelc@cs.wisc.edu, linux-fsdevel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, open-iscsi@googlegroups.com,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: allowed pages in the block later, was Re: [Ext2-devel] [PATCH] ext3: avoid sending down non-refcounted pages
Message-ID: <20051212172552.GA28652@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, fujita.tomonori@lab.ntt.co.jp,
	michaelc@cs.wisc.edu, linux-fsdevel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net, open-iscsi@googlegroups.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20051208180900T.fujita.tomonori@lab.ntt.co.jp> <20051208101833.GM14509@schatzie.adilger.int> <20051208134239.GA13376@infradead.org> <20051210164736.6e4eaa3f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051210164736.6e4eaa3f.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 10, 2005 at 04:47:36PM -0800, Andrew Morton wrote:
> Christoph Hellwig <hch@infradead.org> wrote:
> >
> > The problem we're trying to solve here is how do implement network block
> >  devices (nbd, iscsi) efficiently.  The zero copy codepath in the networking
> >  layer does need to grab additional references to pages.  So to use sendpage
> >  we need a refcountable page.  pages used by the slab allocator are not
> >  normally refcounted so try to do get_page/pub_page on them will break.
> 
> I don't get it.  Doing get_page/put_page on a slab-allocated page should do
> the right thing?

As Arjan mentioned, what would be the right thing?  Delaying returning the
page to the page pool and disallow reuse until page count reaches zero?
All this seems highly impractical.

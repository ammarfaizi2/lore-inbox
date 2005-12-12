Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbVLLR1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbVLLR1N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 12:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbVLLR1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 12:27:13 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41865 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932076AbVLLR1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 12:27:12 -0500
Date: Mon, 12 Dec 2005 17:27:02 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Christoph Hellwig <hch@infradead.org>,
       FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, michaelc@cs.wisc.edu,
       linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       open-iscsi@googlegroups.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: allowed pages in the block later, was Re: [Ext2-devel] [PATCH] ext3: avoid sending down non-refcounted pages
Message-ID: <20051212172702.GB28652@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pekka Enberg <penberg@cs.helsinki.fi>,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	michaelc@cs.wisc.edu, linux-fsdevel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net, open-iscsi@googlegroups.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20051208180900T.fujita.tomonori@lab.ntt.co.jp> <20051208101833.GM14509@schatzie.adilger.int> <20051208134239.GA13376@infradead.org> <84144f020512080558tb9bb6bbjf91e72ad3d9ccaa6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84144f020512080558tb9bb6bbjf91e72ad3d9ccaa6@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2005 at 03:58:46PM +0200, Pekka Enberg wrote:
> Hi Christoph,
> 
> On 12/8/05, Christoph Hellwig <hch@infradead.org> wrote:
> > One way to work around that would be to detect kmalloced pages and use
> > a slowpath for that.  The major issues with that is that we don't have a
> > reliable way to detect if a given struct page comes from the slab allocator
> > or not.
> 
> Why doesn't PageSlab work for you?

When I looked last time it was a noop without slab debugging enabled,
but that's not the case in current mainline anymore.
If the VM people agree with that usage we could at least use it to fall
back to slow-path.  Even better would be to require normal pages, though.

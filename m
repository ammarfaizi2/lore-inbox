Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261305AbSIZOgo>; Thu, 26 Sep 2002 10:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261306AbSIZOgo>; Thu, 26 Sep 2002 10:36:44 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:29457 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261305AbSIZOgn>; Thu, 26 Sep 2002 10:36:43 -0400
Date: Thu, 26 Sep 2002 15:41:59 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Theodore Ts'o" <tytso@mit.edu>, Jakob Oestergaard <jakob@unthought.net>,
       "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: jbd bug(s) (?)
Message-ID: <20020926154158.A19151@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Jakob Oestergaard <jakob@unthought.net>,
	"Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@zip.com.au>
References: <20020924072117.GD2442@unthought.net> <20020925173605.A12911@redhat.com> <20020926122124.GS2442@unthought.net> <20020926132723.D2721@redhat.com> <20020926125647.GT2442@unthought.net> <20020926134435.GA9400@think.thunk.org> <20020926150557.A18323@infradead.org> <20020926142504.GC9400@think.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020926142504.GC9400@think.thunk.org>; from tytso@mit.edu on Thu, Sep 26, 2002 at 10:25:04AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2002 at 10:25:04AM -0400, Theodore Ts'o wrote:
> My mistake.  At one point I was talking to Mark Lord and I had gotten

					     ^^^ Stephen Lord

> the impression they had some Irix-VM-to-Linux-VM mapping layer which
> would make blocksize > PAGE_SIZE possible.

The pagebuf layer presents and inferface similar enough to the IRIX
buffercache to XFS and is layered ontop of the Linux pagecache.  Today
it's only used for metadata and allows mapping of > PAGE_CACHE_SIZE
objects there (see the vmap/vunmap code I added to vmalloc.c in 2.5
for that).  But it's not used for data I/O at all anymore and it would
also have problems for blocksize > PAGE_CACHE_SIZE.


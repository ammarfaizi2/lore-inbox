Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbTIKRkv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 13:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbTIKRkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 13:40:47 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:62218
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S261514AbTIKRjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 13:39:35 -0400
Date: Thu, 11 Sep 2003 10:39:33 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Amir Hermelin <amir@montilio.com>
Cc: linux-kernel@vger.kernel.org, Rik van Riel <riel@conectiva.com.br>,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: page cache and buffer cache in 2.4.18 and up
Message-ID: <20030911173933.GD18399@matchmail.com>
Mail-Followup-To: Amir Hermelin <amir@montilio.com>,
	linux-kernel@vger.kernel.org, Rik van Riel <riel@conectiva.com.br>,
	Andrea Arcangeli <andrea@suse.de>
References: <003301c37879$938fda00$0601a8c0@CARTMAN>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003301c37879$938fda00$0601a8c0@CARTMAN>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 05:30:05PM +0200, Amir Hermelin wrote:
> Hi,
> Since the change in kernel 2.4, read and writes go both through the page and
> buffer cache.

That change was in 2.4.10 with the andrea VM merge.  Though, I wouldn't use
it until about 2.4.14/16+ (don't use 2.4.15)

> Is the cached data held twice (i.e. uses twice the memory)? I
> noticed that the struct page holds a pointer to a buffer-head list; does
> that list contain actual data, or just pointers into the cached page data?

Others have asked before about this.

But let me inject some hearsay: 
With the buffer & pagecache merge patch, there is much less duplication of
data, but still some.  Also, pagecache doesn't reference into buffer cache
and the same data can be read twice (ie, if you're reading directly from
/dev/hda, and a filesytem on /dev/hdaX at the same time).

There is less duplication in 2.6, but I believe pagecache still doesn't
reference to buffer cache in there too.

Can someone say in more detail?

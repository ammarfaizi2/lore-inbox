Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbTFBTW6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 15:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbTFBTW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 15:22:57 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:18049 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id S261874AbTFBTW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 15:22:56 -0400
Subject: Re: [PATCH RFC] 1/2 central workspace for zlib
From: David Woodhouse <dwmw2@infradead.org>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-mtd@lists.infradead.org, matsunaga <matsunaga_kazuhisa@yahoo.co.jp>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030602163704.GC679@wohnheim.fh-wedel.de>
References: <20030530144959.GA4736@wohnheim.fh-wedel.de>
	 <002901c32919$ddc37000$570486da@w0a3t0>
	 <20030602153656.GA679@wohnheim.fh-wedel.de>
	 <1054568407.20369.382.camel@passion.cambridge.redhat.com>
	 <20030602155353.GB679@wohnheim.fh-wedel.de>
	 <1054569564.20369.385.camel@passion.cambridge.redhat.com>
	 <20030602163704.GC679@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=ISO-8859-15
Organization: 
Message-Id: <1054582573.22361.6.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5.dwmw2) 
Date: Mon, 02 Jun 2003 20:36:13 +0100
Content-Transfer-Encoding: 8bit
X-SA-Exim-Rcpt-To: joern@wohnheim.fh-wedel.de, linux-mtd@lists.infradead.org, matsunaga_kazuhisa@yahoo.co.jp, linux-kernel@vger.kernel.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-02 at 17:37, Jörn Engel wrote:
> On Mon, 2 June 2003 16:59:25 +0100, David Woodhouse wrote:
> > On Mon, 2003-06-02 at 16:53, Jörn Engel wrote:
> > > Maybe lazy allocation.  vmalloc() it with the first write(), which
> > > should be never in production use.  So the extra overhead doesn't
> > > really matter.
> > 
> > Seems reasonable.
> 
> Patch is in CVS.
> 
> Not 100% sure about the correct return code, if the lazy allocation
> fails.  Can you check that?

Thanks. The return code doesn't matter. If you look at the caller you
see it's only used as uptodate = !!ret anyway. It can't go any further.

I was concerned briefly that the allocation could happen when we're
trying to evict a page on memory pressure -- but in fact that's
virtually impossible since you'd have to mount the file system and mmap
your file without actually writing anything to the block device.

And anyway, refer to earlier comments about anyone using the naïve
read/erase/modify/writeback mtdblock translation layer for writing in
production wanting to be shot for it :)

-- 
dwmw2



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263411AbUDGBeM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 21:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263415AbUDGBeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 21:34:12 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:62285 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263411AbUDGBeJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 21:34:09 -0400
Date: Wed, 7 Apr 2004 11:33:07 +1000
From: Nathan Scott <nathans@sgi.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       hugh@veritas.com, vrajesh@umich.edu, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity fix
Message-ID: <20040407113307.C3391@wobbly.melbourne.sgi.com>
References: <20040402203514.GR21341@dualathlon.random> <20040403094058.A13091@infradead.org> <20040403152026.GE2307@dualathlon.random> <20040403155958.GF2307@dualathlon.random> <20040403170258.GH2307@dualathlon.random> <20040405105912.A3896@infradead.org> <20040405131113.A5094@infradead.org> <20040406042222.GP2234@dualathlon.random> <20040406061646.B14800@infradead.org> <20040406160141.GX2234@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040406160141.GX2234@dualathlon.random>; from andrea@suse.de on Tue, Apr 06, 2004 at 06:01:41PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 06:01:41PM +0200, Andrea Arcangeli wrote:
> On Tue, Apr 06, 2004 at 06:16:46AM +0100, Christoph Hellwig wrote:
> > Can you try the patch below (testing it now, but I'm pretty sure it'll fix it)
> > instead of all the kmalloc changes?:
> 
> I'm having some email dealy so I don't know if you sent me more recent
> emails, did it work fine as expected or should I keep my kmalloc change?
> 

Christophs away for a few days, so I'll jump in.  The patch was not
quite right - the first part should be dropped, the second section
is right.  In the first hunk (i.e. the pagebuf_lookup_pages changes)
we are always working with page cache pages there, so the change was
unnecessary (it also tested a flag which only gets set several lines
down in that call, so wasn't quite right anyway).  The second part of
the patch is the critical piece, as it avoids updating the page->private
field in the IO completion handler for non-pagecache pages.  I've been
testing with just that piece, and it looks good.

I'll be putting this into our local XFS trees shortly, and will send
it on to Linus and Andrew soon.

thanks Andrea.

-- 
Nathan

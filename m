Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263093AbUEWPpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263093AbUEWPpw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 11:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbUEWPpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 11:45:51 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:31122 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263093AbUEWPpe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 11:45:34 -0400
Date: Sun, 23 May 2004 17:45:24 +0200
From: Jens Axboe <axboe@suse.de>
To: Lorenzo Allegrucci <l_allegrucci@despammed.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm5 oops mounting ext3 or reiserfs with -o barrier
Message-ID: <20040523154524.GR1952@suse.de>
References: <200405222107.55505.l_allegrucci@despammed.com> <20040523091137.GB5415@suse.de> <20040523100348.GJ1952@suse.de> <200405231732.15600.l_allegrucci@despammed.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405231732.15600.l_allegrucci@despammed.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 23 2004, Lorenzo Allegrucci wrote:
> On Sunday 23 May 2004 12:03, Jens Axboe wrote:
> 
> > Here's a rolled up updated version that tries to get async notification
> > of missing barrier support working as well. reiser currently doesn't
> > cope with that correctly (fails mount), ext3 seems to but gets stuck.
> > Andrew has that fixed already, I think :-)
> >
> > Lorenzo, can you test this on top of 2.6.6-mm5?
> 
> Problem fixed, but there is some performance regression
> 
> ext3 (default)
> untar		read		copy		remove
> 0m53.861s	0m24.942s	1m30.164s	0m20.664s
> 0m7.132s	0m1.191s	0m0.766s	0m0.076s
> 0m5.807s	0m3.345s	0m9.996s	0m1.719s
> 
> ext3 (-o barrier=1)
> untar		read		copy		remove
> 0m52.117s	0m28.502s	1m51.153s	0m25.561s
> 0m7.231s	0m1.209s	0m0.738s	0m0.071s
> 0m6.117s	0m3.191s	0m9.347s	0m1.635s

Not sure what you mean here, but yes of course -o barrier=1 is going to
be slower than default + write back caching. What you should compare is
without barrier support and hdparm -W0 /dev/hdX, if -o barrier=1 with
caching on is slower then that's a regression :-)

-- 
Jens Axboe


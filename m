Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269360AbUIYQhy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269360AbUIYQhy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 12:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269361AbUIYQhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 12:37:54 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:59527 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S269360AbUIYQhw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 12:37:52 -0400
Date: Sat, 25 Sep 2004 18:37:27 +0200
From: Jens Axboe <axboe@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm3
Message-ID: <20040925163724.GB11525@suse.de>
References: <20040924014643.484470b1.akpm@osdl.org> <20040925124334.GL9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040925124334.GL9106@holomorphy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25 2004, William Lee Irwin III wrote:
> On Fri, Sep 24, 2004 at 01:46:43AM -0700, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc2/2.6.9-rc2-mm3/
> > - This is a quick not-very-well-tested release - it can't be worse than
> >   2.6.9-rc2-mm2, which had a few networking problems.
> > - Added Dmitry Torokhov's input system tree to the -mm bk tree lineup.
> 
> I hope this isn't terribly redundant, but I've tripped over a bogon in
> 2.6.9-rc2-mm3 similar to the one I reported for 2.6.9-rc2-mm1. The box
> was actually idle at the time.

Same bug, not fixed yet. I'll see if I can get it fixed on monday, I've
seen it here a few times as well. Seems not to be easily reproducable
and no real pattern to when it does. In the mean time, you can replace
the BUG_ON() with a

	if (cfqq->allocated[crq->is_write] == 0) {
		WARN_ON(1);
		cfqq->allocated[crq->is_write] = 1;
	}

and the system should work fine.

-- 
Jens Axboe


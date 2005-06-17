Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262041AbVFQSP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbVFQSP2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 14:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbVFQSP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 14:15:28 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:45771 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262041AbVFQSPW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 14:15:22 -0400
Date: Fri, 17 Jun 2005 20:16:36 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: spaminos-ker@yahoo.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: cfq misbehaving on 2.6.11-1.14_FC3
Message-ID: <20050617181635.GU6957@suse.de>
References: <20050614000352.7289d8f1.akpm@osdl.org> <20050614232154.17077.qmail@web30701.mail.mud.yahoo.com> <20050617141039.GL6957@suse.de> <20050617155108.GX9664@g5.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050617155108.GX9664@g5.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17 2005, Andrea Arcangeli wrote:
> On Fri, Jun 17, 2005 at 04:10:40PM +0200, Jens Axboe wrote:
> > Perhaps rmap could be used to lookup who has a specific page mapped...
> 
> I doubt, the computing and locking cost for every single page write
> would be probably too high. Doing it during swapping isn't a big deal
> since cpu is mostly idle during swapouts, but doing it all the time
> sounds a bit overkill.

We could cut the lookup down to per-request, it's not very likely that
seperate threads would be competing for the exact same disk location.
But it's still not too nice...

> A mechanism to pass down a pid would be much better. However I'm unsure
> where you could put the info while dirtying the page. If it was an uid
> it might be reasonable to have it in the address_space, but if you want
> a pid as index, then it'd need to go in the page_t, which would waste
> tons of space. Having a pid in the address space, may not work well with
> a database or some other app with multiple processes.

The previous patch just added a pid_t to struct page, but I knew all
along that this was just for testing, I never intended to merge that
part.

-- 
Jens Axboe


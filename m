Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262126AbUKQAzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbUKQAzG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 19:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262134AbUKQAzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 19:55:06 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:45792 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262126AbUKQAy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 19:54:59 -0500
Date: Tue, 16 Nov 2004 18:54:00 -0600
From: Robin Holt <holt@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Robin Holt <holt@sgi.com>, linux-kernel@vger.kernel.org, dev@sw.ru,
       wli@holomorphy.com, steiner@sgi.com, sandeen@sgi.com
Subject: Re: 21 million inodes is causing severe pauses.
Message-ID: <20041117005400.GA11322@lnx-holt.americas.sgi.com>
References: <20041115195551.GA15380@lnx-holt.americas.sgi.com> <20041115145714.3f757012.akpm@osdl.org> <20041116162859.GA5594@lnx-holt.americas.sgi.com> <20041116111321.36a6cd06.akpm@osdl.org> <20041116194858.GA2549@lnx-holt.americas.sgi.com> <20041116163310.34580297.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041116163310.34580297.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2004 at 04:33:10PM -0800, Andrew Morton wrote:
> > I have moved lock_kernel() as above in addition to the two patches you pointed
> > to earlier.  This has left me with a system which has 21M inodes and undetectable
> > delays during heavy mount/umount activity.  I am starting one last test which
> > attempts a umount of a filesystem which has many inodes associated with it.
> 
> That sounds good.  We need to work out where that null-pointer deref is
> coming from.
> 

I had originally used a patch that was in one of our developers trees
which was different from the one in your most recent -mm tree.  The patch
I was using had a missing list_del(... i_list); or something like that.
I could dig out the exact line if you want to sanity check me, but I
don't have it handy right now.  With the patch in your tree, I have not
seen any NULL pointer dereferences.

> > At this point, I have checked the entire code path and see no reason the
> > BKL is held for the first call to invalidate_inodes.
> 
> No, the above change looks fine.  And I have no problem merging up
> invalidate_inodes-speedup.patch, really - it's been in -mm for over a year.
> I've just been waiting for a decent reason to merge it.

I would strongly encourage merging the three patches we have talked about
here.  I understand you would typically keep my BKL patch in your tree for
awhile and think that would be just fine.  The changes only affect systems
that have filesystems being unmounted with a large number of inodes.

With the two patches already in your tree, the pauses are greatly reduced
for the autofs case that originally got me looking.

Thanks,
Robin Holt

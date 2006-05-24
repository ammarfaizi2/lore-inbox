Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932636AbWEXHKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932636AbWEXHKX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 03:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932633AbWEXHKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 03:10:22 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:8140 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932627AbWEXHKV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 03:10:21 -0400
Date: Wed, 24 May 2006 12:36:06 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: David Chinner <dgc@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Per-superblock unused dentry LRU lists.
Message-ID: <20060524070605.GA7743@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <20060524012412.GB7412499@melbourne.sgi.com> <20060524050214.GB9639@in.ibm.com> <20060524061933.GG7418631@melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060524061933.GG7418631@melbourne.sgi.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> per-sb, you mean? ;)

Yes.

> 
> > You can use trylock. Please see the patches in -mm to fix the umount
> > race.
> 
> I'm not sure what unmount race you are talking about.
> 
> AFAICT, there is no race here - we've got a reference on the superblock so  it
> can't go away and the lru list is protected by the dcache_lock, so there's
> nothing else we can race with. However, we can deadlock by taking the
> s_umount lock here. So why even bother to try to take the lock when we don't
> actually need it?

Please read the thread at http://lkml.org/lkml/2006/4/2/101.

> 
> > > +		if (__put_super_and_need_restart(sb) && count)
> > > +			goto restart;
> > 
> > Comment please.
> 
> I'm not sure what a comment needs to explain that the code doesn't.
> Which bit do you think needs commenting?

I was referring to the __put_super_and_need_restart() part.

> > This should not be required with per super-block dentries. The only
> > reason, I think we moved dentries to the tail is to club all entries
> > from the sb together (to free them all at once).
> 
> I think we still need to do that. We get called in contexts that aren't
> related to unmounting, so we want these dentries to be the first
> to be reclaimed from that superblock when we next call prune_dcache().

Is it? I quickly checked the callers of shrink_dcache_sb() and all of
them seem to be mount related. shrink_dcache_parent() is another story.
Am I missing something? Code reference will be particularly useful.

> 
> No. Right now I just want to fix the problem that has been reported with
> shrink_dcache_sb().

Sure.

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs

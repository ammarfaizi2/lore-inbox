Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964846AbVIFMrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbVIFMrb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 08:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964844AbVIFMrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 08:47:31 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:43732 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S964835AbVIFMra
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 08:47:30 -0400
Date: Tue, 6 Sep 2005 18:25:18 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: linux clustering <linux-cluster@redhat.com>, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: GFS, what's remaining
Message-ID: <20050906125517.GA7531@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20050901104620.GA22482@redhat.com> <20050901035939.435768f3.akpm@osdl.org> <1125586158.15768.42.camel@localhost.localdomain> <20050901132104.2d643ccd.akpm@osdl.org> <p73fysnqiej.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73fysnqiej.fsf@verdi.suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2005 at 11:17:08PM +0200, Andi Kleen wrote:
> Andrew Morton <akpm@osdl.org> writes:
> 
> > 
> > > > - Why GFS is better than OCFS2, or has functionality which OCFS2 cannot
> > > >   possibly gain (or vice versa)
> > > > 
> > > > - Relative merits of the two offerings
> > > 
> > > You missed the important one - people actively use it and have been for
> > > some years. Same reason with have NTFS, HPFS, and all the others. On
> > > that alone it makes sense to include.
> >  
> > Again, that's not a technical reason.  It's _a_ reason, sure.  But what are
> > the technical reasons for merging gfs[2], ocfs2, both or neither?
> 
> There seems to be clearly a need for a shared-storage fs of some sort
> for HA clusters and virtualized usage (multiple guests sharing a
> partition).  Shared storage can be more efficient than network file
> systems like NFS because the storage access is often more efficient
> than network access  and it is more reliable because it doesn't have a
> single point of failure in form of the NFS server.
> 
> It's also a logical extension of the "failover on failure" clusters
> many people run now - instead of only failing over the shared fs at
> failure and keeping one machine idle the load can be balanced between
> multiple machines at any time.
> 
> One argument to merge both might be that nobody really knows yet which
> shared-storage file system (GFS or OCFS2) is better. The only way to
> find out would be to let the user base try out both, and that's most
> practical when they're merged.
> 
> Personally I think ocfs2 has nicer&cleaner code than GFS.
> It seems to be more or less a 64bit ext3 with cluster support, while

The "more or less" is what bothers me here - the first time I heard this,
it sounded a little misleading, as I expected to find some kind of a
patch to ext3 to make it 64 bit with extents and cluster support.
Now I understand it a little better (thanks to Joel and Mark)

And herein lies the issue where I tend to agree with Andrew on
-- its really nice to have multiple filesystems innovating freely in
their niches and eventually proving themselves in practice, without
being bogged down by legacy etc. But at the same time, is there enough
thought and discussion about where the fragmentation/diversification is really
warranted, vs improving what is already there, or say incorporating
the best of one into another, maybe over a period of time ?

The number of filesystems seems to just keep growing, and supporting
all of them isn't easy -- for users it isn't really easy to switch from
one to another, and the justifications for choosing between them is
sometimes confusing and burdensome from an administrator standpoint
- one filesystem is good in certain conditions, another in others,
stability levels may vary etc, and its not always possible to predict
which aspect to prioritize.

Now, with filesystems that have been around in production for a long
time, the on-disk format becomes a major constraining factor, and the
reason for having various legacy support around. Likewise, for some
special purpose filesystems there really is a niche usage. But for new
and sufficiently general purpose filesystems, with new on-disk structure,
isn't it worth thinking this through and trying to get it right ? 

Yeah, it is a lot of work upfront ... but with double the people working
on something, it just might get much better than what they individually
can. Sometimes.

BTW, I don't know if it is worth it in this particular case, but just
something that worries me in general.

> GFS seems to reinvent a lot more things and has somewhat uglier code.
> On the other hand GFS' cluster support seems to be more aimed
> at being a universal cluster service open for other usages too,
> which might be a good thing. OCFS2s cluster seems to be more 
> aimed at only serving the file system.
> 
> But which one works better in practice is really an open question.

True, but what usually ends up happening is that this question can
never quite be answered in black and white. So both just continue
to exist and apps need to support both ... convergence becomes impossible
and long term duplication inevitable.

So at least having a clear demarcation/guideline of what situations
each is suitable for upfront would be a good thing. That might also
get some cross ocfs-gfs and ocfs-ext3 reviews in the process :)

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India


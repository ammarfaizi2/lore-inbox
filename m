Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316083AbSETPij>; Mon, 20 May 2002 11:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316089AbSETPii>; Mon, 20 May 2002 11:38:38 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:35595 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S316083AbSETPih>; Mon, 20 May 2002 11:38:37 -0400
Date: Mon, 20 May 2002 17:38:39 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@infradead.org>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org,
        Nathan Scott <nathans@wobbly.melbourne.sgi.com>
Subject: Re: Quota patches
Message-ID: <20020520153839.GT9209@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020520135530.GB9209@atrey.karlin.mff.cuni.cz> <20020520150757.A16965@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, May 20, 2002 at 03:55:31PM +0200, Jan Kara wrote:
> > quota-2.5.15-3-register - this patch implements registering/unregistering of quota
> >   formats
> 
> Please don't use the big kernel lock for a newly added list.
  We should get rid of big kernel lock in whole quota subsystem (which I want to do
as soon as Linus accepts the patches). So I agree with you I wanted to do some
extra lock it later.

> Also using <linux/lists.h> would clean up the list handling.
  I intentionally didn't use <linux/lists.h> as the use of the list
is so trivial and structure so small that it's IMHO overkill.

> > quota-2.5.15-4-getstats - this patch removes Q_GETSTATS call and creates /proc/fs/quota
> >   entry instead
> 
> Yuck, even more /proc abuse.  Please convert it to the seq_file interface
> at least. Using individual sysctls per value would be much better.
  I'll have a look at it...

> > quota-2.5.15-7-quotactl - implementation of generic quotactl interface (probably the
> >   biggest patch). Interface is moved from dquot.c to quota.c file. Pointers
> >   to quota operations in superblock are now not filled on quota_on() but
> >   on mount so filesystem can override them (for example ext3 would like to
> >   check on quota_on() that quotafile lies on proper device and turn on
> >   data-journaling on it - at least when we'll have journaled quota :)).
> 
> The vfs_get*/vfs_set* names sound too generic, could you please rename them
> to vfs_get_quota*/vfs_set_quota*?
  Good point... I'll change it.

> Also I think any quota supporting filesystem should set the quota operations
> explicitly to make the intention clearer.
  Hmm.. I don't know if it's cleaner but I start to like idea that this way quota_on()
and other operations will fail on filesystem not supporting quotas (currently everything
is silent, just quota is not counted...).

> > quota-2.5.15-12-compat - implements backward compatible quotactl() interface. It's
> >   configurable whether it should be used at all and whether is should behave
> >   as interface in Linus's (the oldest interface) or Alan's (old interface for
> >   new quota format) kernel.
> 
> I don't think we want to keep old userspace interface in 2.5, it just
> bloats the kernel and requiring quota tools for a development kernel that
> are already required by all vendor kernels sounds sane to me.
  Actually I included the patch mainly because I have it created for 2.4 where it's
reasonable to have it (I also have a backport for 2.4 because it will
take a lot of time before 2.6 will exist and be stable enough) and so I wanted to have
the patch also tested in 2.5... But I agree that it's bloating the kernel and
so if it won't be included I won't mind too much.

> Else your patches look very good to me, I look forward to finally see
> properly working quota support in a mainline kernel.

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

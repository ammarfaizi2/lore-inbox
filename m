Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316033AbSETOJC>; Mon, 20 May 2002 10:09:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316035AbSETOJB>; Mon, 20 May 2002 10:09:01 -0400
Received: from imladris.infradead.org ([194.205.184.45]:14607 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S316033AbSETOI7>; Mon, 20 May 2002 10:08:59 -0400
Date: Mon, 20 May 2002 15:07:57 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        Nathan Scott <nathans@wobbly.melbourne.sgi.com>
Subject: Re: Quota patches
Message-ID: <20020520150757.A16965@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jan Kara <jack@suse.cz>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org,
	Nathan Scott <nathans@wobbly.melbourne.sgi.com>
In-Reply-To: <20020520135530.GB9209@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2002 at 03:55:31PM +0200, Jan Kara wrote:
> quota-2.5.15-3-register - this patch implements registering/unregistering of quota
>   formats

Please don't use the big kernel lock for a newly added list.
Also using <linux/lists.h> would clean up the list handling.

> quota-2.5.15-4-getstats - this patch removes Q_GETSTATS call and creates /proc/fs/quota
>   entry instead

Yuck, even more /proc abuse.  Please convert it to the seq_file interface
at least. Using individual sysctls per value would be much better.

> quota-2.5.15-7-quotactl - implementation of generic quotactl interface (probably the
>   biggest patch). Interface is moved from dquot.c to quota.c file. Pointers
>   to quota operations in superblock are now not filled on quota_on() but
>   on mount so filesystem can override them (for example ext3 would like to
>   check on quota_on() that quotafile lies on proper device and turn on
>   data-journaling on it - at least when we'll have journaled quota :)).

The vfs_get*/vfs_set* names sound too generic, could you please rename them
to vfs_get_quota*/vfs_set_quota*?

Also I think any quota supporting filesystem should set the quota operations
explicitly to make the intention clearer.

> quota-2.5.15-12-compat - implements backward compatible quotactl() interface. It's
>   configurable whether it should be used at all and whether is should behave
>   as interface in Linus's (the oldest interface) or Alan's (old interface for
>   new quota format) kernel.

I don't think we want to keep old userspace interface in 2.5, it just
bloats the kernel and requiring quota tools for a development kernel that
are already required by all vendor kernels sounds sane to me.

Else your patches look very good to me, I look forward to finally see
properly working quota support in a mainline kernel.

	Christoph


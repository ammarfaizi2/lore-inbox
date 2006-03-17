Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030217AbWCQRWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030217AbWCQRWN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 12:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030220AbWCQRWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 12:22:13 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:776 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030218AbWCQRWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 12:22:11 -0500
Date: Fri, 17 Mar 2006 18:22:10 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Nathan Scott <nathans@sgi.com>
Cc: Christoph Hellwig <hch@infradead.org>, Suzuki <suzuki@in.ibm.com>,
       linux-fsdevel@vger.kernel.org,
       "linux-aio kvack.org" <linux-aio@kvack.org>,
       lkml <linux-kernel@vger.kernel.org>, suparna <suparna@in.ibm.com>,
       akpm@osdl.org, linux-xfs@oss.sgi.com
Subject: Re: [RFC] Badness in __mutex_unlock_slowpath with XFS stress tests
Message-ID: <20060317172210.GP3914@stusta.de>
References: <440FDF3E.8060400@in.ibm.com> <20060309120306.GA26682@infradead.org> <20060309223042.GC1135@frodo> <20060309224219.GA6709@infradead.org> <20060309231422.GD1135@frodo> <20060310005020.GF1135@frodo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060310005020.GF1135@frodo>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2006 at 11:50:20AM +1100, Nathan Scott wrote:
> On Fri, Mar 10, 2006 at 10:14:22AM +1100, Nathan Scott wrote:
> > On Thu, Mar 09, 2006 at 10:42:19PM +0000, Christoph Hellwig wrote:
> > > On Fri, Mar 10, 2006 at 09:30:42AM +1100, Nathan Scott wrote:
> > > > Not for reads AFAICT - __generic_file_aio_read + own-locking
> > > > should always have released i_mutex at the end of the direct
> > > > read - are you thinking of writes or have I missed something?
> > > 
> > > if an error occurs before a_ops->direct_IO is called __generic_file_aio_read
> > > will return with i_mutex still locked.  Note that checking for negative
> > > return values is not enough as __blockdev_direct_IO can return errors
> > > aswell.
> > 
> > *groan* - right you are.  Another option may be to have the
> > generic dio+own-locking case reacquire i_mutex if it drops
> > it, before returning... thoughts?  Seems alot less invasive
> > than the filemap.c code dup'ing thing.
> 
> Something like this (works OK for me)...

Is this 2.6.16 material?

> cheers.
> Nathan
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


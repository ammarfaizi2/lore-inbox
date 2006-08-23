Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965097AbWHWSJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965097AbWHWSJQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 14:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965098AbWHWSJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 14:09:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:50345 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965099AbWHWSJP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 14:09:15 -0400
Date: Wed, 23 Aug 2006 13:51:57 -0400 (EDT)
From: Jason Baron <jbaron@redhat.com>
X-X-Sender: jbaron@dhcp83-20.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: neilb@suse.de, arjan@infradead.org, mingo@redhat.com, axboe@suse.de,
       a.p.zijlstra@chello.nl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block_dev.c mutex_lock_nested() fix
In-Reply-To: <20060823110213.90172799.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0608231349530.5899@dhcp83-20.boston.redhat.com>
References: <Pine.LNX.4.64.0608231104220.5899@dhcp83-20.boston.redhat.com>
 <20060823110213.90172799.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 23 Aug 2006, Andrew Morton wrote:

> On Wed, 23 Aug 2006 11:09:35 -0400 (EDT)
> Jason Baron <jbaron@redhat.com> wrote:
> 
> > 
> > Hi,
> > 
> > In the case below we are locking the whole disk not a partition. This 
> > change simply brings the code in line with the piece above where when we 
> > are the 'first' opener, and we are a partition.
> > 
> > thanks,
> > 
> > -Jason
> > 
> > Signed-off-by: Jason Baron <jbaron@redhat.com>
> > 
> > --- linux-2.6/fs/block_dev.c.bak
> > +++ linux-2.6/fs/block_dev.c
> > @@ -966,7 +966,7 @@ do_open(struct block_device *bdev, struc
> >  				rescan_partitions(bdev->bd_disk, bdev);
> >  		} else {
> >  			mutex_lock_nested(&bdev->bd_contains->bd_mutex,
> > -					  BD_MUTEX_PARTITION);
> > +					  BD_MUTEX_WHOLE);
> >  			bdev->bd_contains->bd_part_count++;
> >  			mutex_unlock(&bdev->bd_contains->bd_mutex);
> >  		}
> 
> This was allegedly (re-re-re-re-)fixed in 2.6.18-rc4-mm2. 
> lockdep-fix-blkdev_open-warning.patch and
> lockdep-fix-blkdev_open-warning-fix.patch.
> 
> Is this patch needed in that kernel?
> 

yes. Those patches address a similar type of issue, but not this specific 
one. 



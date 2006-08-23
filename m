Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965042AbWHWSC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965042AbWHWSC5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 14:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWHWSC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 14:02:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42717 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932448AbWHWSC4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 14:02:56 -0400
Date: Wed, 23 Aug 2006 11:02:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jason Baron <jbaron@redhat.com>
Cc: neilb@suse.de, arjan@infradead.org, mingo@redhat.com, axboe@suse.de,
       a.p.zijlstra@chello.nl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block_dev.c mutex_lock_nested() fix
Message-Id: <20060823110213.90172799.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0608231104220.5899@dhcp83-20.boston.redhat.com>
References: <Pine.LNX.4.64.0608231104220.5899@dhcp83-20.boston.redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Aug 2006 11:09:35 -0400 (EDT)
Jason Baron <jbaron@redhat.com> wrote:

> 
> Hi,
> 
> In the case below we are locking the whole disk not a partition. This 
> change simply brings the code in line with the piece above where when we 
> are the 'first' opener, and we are a partition.
> 
> thanks,
> 
> -Jason
> 
> Signed-off-by: Jason Baron <jbaron@redhat.com>
> 
> --- linux-2.6/fs/block_dev.c.bak
> +++ linux-2.6/fs/block_dev.c
> @@ -966,7 +966,7 @@ do_open(struct block_device *bdev, struc
>  				rescan_partitions(bdev->bd_disk, bdev);
>  		} else {
>  			mutex_lock_nested(&bdev->bd_contains->bd_mutex,
> -					  BD_MUTEX_PARTITION);
> +					  BD_MUTEX_WHOLE);
>  			bdev->bd_contains->bd_part_count++;
>  			mutex_unlock(&bdev->bd_contains->bd_mutex);
>  		}

This was allegedly (re-re-re-re-)fixed in 2.6.18-rc4-mm2. 
lockdep-fix-blkdev_open-warning.patch and
lockdep-fix-blkdev_open-warning-fix.patch.

Is this patch needed in that kernel?


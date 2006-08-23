Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965060AbWHWQxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965060AbWHWQxE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 12:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965039AbWHWQxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 12:53:04 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:22557 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S965060AbWHWQxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 12:53:02 -0400
Subject: Re: [PATCH] block_dev.c mutex_lock_nested() fix
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Jason Baron <jbaron@redhat.com>
Cc: neilb@suse.de, akpm@osdl.org, arjan@infradead.org, mingo@redhat.com,
       axboe@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0608231104220.5899@dhcp83-20.boston.redhat.com>
References: <Pine.LNX.4.64.0608231104220.5899@dhcp83-20.boston.redhat.com>
Content-Type: text/plain
Date: Wed, 23 Aug 2006 18:48:57 +0200
Message-Id: <1156351737.3382.40.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-23 at 11:09 -0400, Jason Baron wrote:
> Hi,
> 
> In the case below we are locking the whole disk not a partition. This 
> change simply brings the code in line with the piece above where when we 
> are the 'first' opener, and we are a partition.

Makes sense in that only whole devices have a partition count.

> Signed-off-by: Jason Baron <jbaron@redhat.com>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

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


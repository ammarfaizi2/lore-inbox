Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263499AbTDMNCM (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 09:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263505AbTDMNCK (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 09:02:10 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:11732 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263499AbTDMNAz (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Apr 2003 09:00:55 -0400
Date: Sun, 13 Apr 2003 15:12:22 +0200
From: Jens Axboe <axboe@suse.de>
To: Nirmala S <nmala@mail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Clustering of Request in block layer
Message-ID: <20030413131222.GL9776@suse.de>
References: <20030413125438.71422.qmail@mail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030413125438.71422.qmail@mail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 13 2003, Nirmala S wrote:
> Hi,
> 
> As per my understanding the block layer clusters requests for all
> block drivers.
> Clustering -
> Creating a linked list of buffer_heads using b_reqnext.
> 
> But, when I run my block driver and try to view the number of
> clustered requests in my Request function, I do not find any
> clustering done.
> 
> void own_request(request_queue_t *q)
> {
>     struct buffer_head *tmp;
>     int count;
>     while(1) {
>         INIT_REQUEST;
>         printk("<1>request %p: cmd %i sec %li (nr. %li)\n", CURRENT,
>                CURRENT->cmd,
>                CURRENT->sector,
>                CURRENT->current_nr_sectors);
>        count=0;
>        for (tmp=bh; tmp; tmp=tmp->b_reqnext)
>             count ++;
>        printk("Count = %d\n", count);
>         end_request(1); /* success */
>     }
> }
> 
> The above always shows 'Count = 1'. dd if=/dev/mydevice of=/dev/null.
> Does this mean that no clustering is done ??

try to add a bs=256k or something like that.

> Just read a document a
> "http://www.usenix.org/publications/library/proceedings/usenix2000/freenix/full_papers/gopinath/gopinath_html/node14.html"
> which says "This clustering is performed only for the drivers compiled
> in the kernel and not for loadable modules."

2.2 and newer clusters for all drivers.

-- 
Jens Axboe


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272305AbTHIJ3x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 05:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272308AbTHIJ3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 05:29:53 -0400
Received: from dyn-ctb-203-221-72-224.webone.com.au ([203.221.72.224]:25103
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S272305AbTHIJ3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 05:29:51 -0400
Message-ID: <3F34BEC4.8090701@cyberone.com.au>
Date: Sat, 09 Aug 2003 19:28:36 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: Vinay K Nallamothu <vinay-rc@naturesoft.net>
CC: trivial@rustcorp.com.au, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.0-test3] compile fix for driver/block/paride/pd.c
References: <1060421994.1276.6.camel@lima.royalchallenge.com>
In-Reply-To: <1060421994.1276.6.camel@lima.royalchallenge.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

blk_init_queue now returns a request queue, so this
patch will not work properly. See the changes in
test2 -> test3 for how to do it correctly.

Vinay K Nallamothu wrote:

>This patch removes the extra argument to blk_init_queue which prevents
>the module from compiling.
>
>
>--- linux-2.6.0-test3/drivers/block/paride/pd.c	2003-07-28 10:43:52.000000000 +0530
>+++ linux-2.6.0-test3-nvk/drivers/block/paride/pd.c	2003-08-09 15:02:19.000000000 +0530
>@@ -893,7 +893,7 @@
> 	if (register_blkdev(major, name))
> 		return -1;
> 
>-	blk_init_queue(&pd_queue, do_pd_request, &pd_lock);
>+	blk_init_queue(do_pd_request, &pd_lock);
> 	blk_queue_max_sectors(&pd_queue, cluster);
> 
> 	printk("%s: %s version %s, major %d, cluster %d, nice %d\n",
>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>


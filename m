Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262746AbTHUPTW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 11:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbTHUPTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 11:19:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17356 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262746AbTHUPTU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 11:19:20 -0400
Message-ID: <3F44E2EB.6020508@pobox.com>
Date: Thu, 21 Aug 2003 11:19:07 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Matthew Wilcox <willy@debian.org>
CC: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] bio.c: reduce verbosity at boot
References: <20030821150211.GU19630@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20030821150211.GU19630@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> Linux is really far too verbose at boot time.  I don't think these messages
> add anything to either the end user experience or debug ability.
> 
> Index: fs/bio.c
> ===================================================================
> RCS file: /var/cvs/linux-2.6/fs/bio.c,v
> retrieving revision 1.2
> diff -u -p -r1.2 bio.c
> --- fs/bio.c	29 Jul 2003 17:25:49 -0000	1.2
> +++ fs/bio.c	21 Aug 2003 14:58:40 -0000
> @@ -793,10 +793,6 @@ static void __init biovec_init_pools(voi
>  					mempool_free_slab, bp->slab);
>  		if (!bp->pool)
>  			panic("biovec: can't init mempool\n");
> -
> -		printk("biovec pool[%d]: %3d bvecs: %3d entries (%d bytes)\n",
> -						i, bp->nr_vecs, pool_entries,
> -						size);


Although I agree with your "too verbose" sentiment above, I think the 
removing the messages outright might not serve the best interests the 
developer.  Since even KERN_DEBUG still spams dmesg, in these situations 
I usually change these type of messages to be conditionally printed iff 
a debug macro is enabled.

As a tangent, the huge x86 IO-APIC verbosity really bugs me, too, and 
often is the direct cause of useful early printk messages being lost 
before boot is even complete.

	Jeff




Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267632AbTASVSd>; Sun, 19 Jan 2003 16:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267648AbTASVSd>; Sun, 19 Jan 2003 16:18:33 -0500
Received: from impact.colo.mv.net ([199.125.75.20]:55476 "EHLO
	impact.colo.mv.net") by vger.kernel.org with ESMTP
	id <S267632AbTASVSc>; Sun, 19 Jan 2003 16:18:32 -0500
Message-ID: <3E2B1833.5060203@bogonomicon.net>
Date: Sun, 19 Jan 2003 15:27:15 -0600
From: Bryan Andersen <bryan@bogonomicon.net>
Organization: Bogonomicon
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.21-pre3-ac oops
References: <Pine.LNX.4.44.0301191347310.2280-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0301191347310.2280-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch looks like it solved the problem.  6 kernel compiles
and 6 mke2fs with bad block scans and the system is still
up.

The only thing I'm still seeing that is unusual is this kernel
message:

   ide: no cache flush required.

which only shows up in the file:

   ./drivers/ide/ide-disk.c:

Nothing seams to come of them, but in the average boot I see
25 or so of them.  They did not show up under linux-2.4.21-pre3.
As near as I can tell they are generated when an ide device is
closed.

- Bryan

Hugh Dickins wrote:
> If you got 2.4.21-pre3-ac __free_pages_ok oops, please try this patch.
> 
> Hugh
> 
> --- 2.4.21-pre3-ac4/kernel/fork.c	Mon Jan 13 18:56:12 2003
> +++ linux/kernel/fork.c	Sun Jan 19 13:39:37 2003
> @@ -688,6 +688,8 @@
>  	p->lock_depth = -1;		/* -1 = no lock */
>  	p->start_time = jiffies;
>  
> +	INIT_LIST_HEAD(&p->local_pages);
> +
>  	retval = -ENOMEM;
>  	/* copy all the process information */
>  	if (copy_files(clone_flags, p))
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


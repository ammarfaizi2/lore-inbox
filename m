Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932657AbVKYPVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932657AbVKYPVk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 10:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932693AbVKYPVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 10:21:40 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:61659 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S932657AbVKYPVj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 10:21:39 -0500
Message-ID: <43872BF2.3030407@cosmosbay.com>
Date: Fri, 25 Nov 2005 16:21:22 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 10/19] readahead: state based method
References: <20051125151210.993109000@localhost.localdomain> <20051125151550.440541000@localhost.localdomain>
In-Reply-To: <20051125151550.440541000@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Fri, 25 Nov 2005 16:21:21 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Fengguang a écrit :

>  include/linux/fs.h |    8 +
> 
> --- linux-2.6.15-rc2-mm1.orig/include/linux/fs.h
> +++ linux-2.6.15-rc2-mm1/include/linux/fs.h
> @@ -604,13 +604,19 @@ struct file_ra_state {
>  	unsigned long start;		/* Current window */
>  	unsigned long size;
>  	unsigned long flags;		/* ra flags RA_FLAG_xxx*/
> -	unsigned long cache_hit;	/* cache hit count*/
> +	uint64_t      cache_hit;	/* cache hit count*/
>  	unsigned long prev_page;	/* Cache last read() position */
>  	unsigned long ahead_start;	/* Ahead window */
>  	unsigned long ahead_size;
>  	unsigned long ra_pages;		/* Maximum readahead window */
>  	unsigned long mmap_hit;		/* Cache hit stat for mmap accesses */
>  	unsigned long mmap_miss;	/* Cache miss stat for mmap accesses */
> +
> +	unsigned long age;
> +	pgoff_t la_index;
> +	pgoff_t ra_index;
> +	pgoff_t lookahead_index;
> +	pgoff_t readahead_index;
>  };

Hum... This sizeof(struct file) increase seems quite large...

Have you ever considered to change struct file so that file_ra_state is not 
embedded, but dynamically allocated (or other strategy) for regular files ?

I mean, sockets, pipes cannot readahead... And some machines use far more 
sockets than regular files.

I wrote such a patch in the past I could resend...

Eric

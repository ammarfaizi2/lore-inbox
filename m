Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316800AbSE1BvF>; Mon, 27 May 2002 21:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316801AbSE1BvE>; Mon, 27 May 2002 21:51:04 -0400
Received: from beth.pinerecords.com ([212.71.161.243]:7186 "EHLO
	beth.pinerecords.com") by vger.kernel.org with ESMTP
	id <S316800AbSE1BvD>; Mon, 27 May 2002 21:51:03 -0400
Date: Mon, 27 May 2002 23:30:16 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Colin Gibbs <colin@gibbs.dhs.org>
Cc: linux-kernel@vger.kernel.org, tcallawa@redhat.com,
        sparclinux@vger.kernel.org, aurora-sparc-devel@linuxpower.org
Subject: Re: 2.4 SRMMU bug revisited
Message-ID: <20020527213016.GB7155@beth.pinerecords.com>
In-Reply-To: <20020527092408.GD345@louise.pinerecords.com> <1022525198.19147.29.camel@monolith>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
X-OS: GNU/Linux 2.4.19-pre8-ac5 
X-Architecture: i586
X-Uptime: 11:03
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- 2.4.19-pre4/kernel/fork.c	Thu Mar 28 19:49:36 2002
> +++ tortoise-19-pre4/kernel/fork.c	Sun Apr 21 22:01:18 2002
> @@ -336,6 +336,9 @@
>  	if (!mm_init(mm))
>  		goto fail_nomem;
>  
> +	if (init_new_context(tsk,mm))
> +		goto free_pt;
> +
>  	down_write(&oldmm->mmap_sem);
>  	retval = dup_mmap(mm);
>  	up_write(&oldmm->mmap_sem);
> @@ -347,9 +350,6 @@
>  	 * child gets a private LDT (if there was an LDT in the parent)
>  	 */
>  	copy_segments(tsk, mm);
> -
> -	if (init_new_context(tsk,mm))
> -		goto free_pt;
>  
>  good_mm:
>  	tsk->mm = mm;


Hmmm, upon closer inspection I found out this patch had *not* been in
what I extracted from the linux-2.4 bitkeeper tree, so my report was
probably not of much value. I'll retest tomorrow with the above applied.
Sorry for the confusion <-- I still can't see the patch in the listings
at http://linux.bkbits.net:8080/linux-2.4/

The patch I used is
http://www.dragon.cz/~kala/patch-2.4.19-pre8-sparcfixes-upto020523-1.gz
(I assembled it by hand using the bk web interface, looking up all sparc
related changes since -pre8.)

T.

Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315546AbSE2Vmm>; Wed, 29 May 2002 17:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315539AbSE2Vmi>; Wed, 29 May 2002 17:42:38 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:42500 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S315536AbSE2Vmh>; Wed, 29 May 2002 17:42:37 -0400
Date: Wed, 29 May 2002 23:42:12 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Colin Gibbs <colin@gibbs.dhs.org>
Cc: linux-kernel@vger.kernel.org, tcallawa@redhat.com,
        sparclinux@vger.kernel.org, aurora-sparc-devel@linuxpower.org,
        davem@redhat.com
Subject: Re: 2.4 SRMMU bug revisited
Message-ID: <20020529214212.GE1397@louise.pinerecords.com>
In-Reply-To: <20020527092408.GD345@louise.pinerecords.com> <1022525198.19147.29.camel@monolith>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
X-OS: GNU/Linux 2.4.19-pre9 SMP
X-Architecture: sparc
X-Uptime: 49 min
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


A big, big thankyou to Colin.

This patch indeed makes difference. I stressed -pre9 as much as I could
(simultaneous reading from raid devices - ext3/reiserfs/ext2, NFS traffic,
sendmail+apache fork storms... you name it, I ran it, all at the same time)
and the kernel lives. Processes still get killed by VM much earlier than
they should (100+ MB RAM free), but that's not critical.

A nice conclusion to this thread, isn't it? :)

T.

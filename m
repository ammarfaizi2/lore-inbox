Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311147AbSCSMrb>; Tue, 19 Mar 2002 07:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311148AbSCSMrW>; Tue, 19 Mar 2002 07:47:22 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:51470 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S311147AbSCSMrB>; Tue, 19 Mar 2002 07:47:01 -0500
Date: Tue, 19 Mar 2002 08:41:15 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Paul Larson <plars@austin.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: shmdt fix
In-Reply-To: <1016227905.28607.36.camel@plars.austin.ibm.com>
Message-ID: <Pine.LNX.4.21.0203190840270.7629-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Paul,  

This patch is already included in my latest tree.

Thanks!

On 15 Mar 2002, Paul Larson wrote:

> 
> Marcelo, in 2.4.19-pre1 the changelog said that the shmdt fix was
> included, but it is still failing the LTP testcase that found this
> problem.  There is a small, but important set of {}'s that got missed,
> so it is still always returning 0 even if there is nothing to detach. 
> The attached diff will clean this up on 2.4.19-pre3.
> 
> Thanks,
> Paul Larson
> 
> 
> diff -Naur linux/ipc/shm.c linux-shmdt/ipc/shm.c
> --- linux/ipc/shm.c	Fri Mar 15 15:13:07 2002
> +++ linux-shmdt/ipc/shm.c	Fri Mar 15 15:16:21 2002
> @@ -678,9 +678,10 @@
>  	for (shmd = mm->mmap; shmd; shmd = shmdnext) {
>  		shmdnext = shmd->vm_next;
>  		if (shmd->vm_ops == &shm_vm_ops
> -		    && shmd->vm_start - (shmd->vm_pgoff << PAGE_SHIFT) == (ulong) shmaddr)
> +		    && shmd->vm_start - (shmd->vm_pgoff << PAGE_SHIFT) == (ulong) shmaddr) {
>  			do_munmap(mm, shmd->vm_start, shmd->vm_end - shmd->vm_start);
>  			retval = 0;
> +		}
>  	}
>  	up_write(&mm->mmap_sem);
>  	return retval;
> 


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317751AbSGPEF7>; Tue, 16 Jul 2002 00:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317752AbSGPEF6>; Tue, 16 Jul 2002 00:05:58 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:54733 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S317751AbSGPEF5>;
	Tue, 16 Jul 2002 00:05:57 -0400
Date: Tue, 16 Jul 2002 13:54:19 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alexander Viro <viro@math.psu.edu>
Cc: torvalds@transmeta.com, pmenage@ensim.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Rearranging struct dentry for cache affinity
Message-Id: <20020716135419.3a301947.rusty@rustcorp.com.au>
In-Reply-To: <Pine.GSO.4.21.0207130455530.13648-100000@weyl.math.psu.edu>
References: <E17T7BT-0006zT-00@pmenage-dt.ensim.com>
	<Pine.GSO.4.21.0207130455530.13648-100000@weyl.math.psu.edu>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Jul 2002 05:11:46 -0400 (EDT)
Alexander Viro <viro@math.psu.edu> wrote:

> futex.c is seriously b0rken.

Really?  Other than changing over to get_sb_psuedo(), what does your patch
fix?  As the filesystem should never be unmounted, what am I missing?

Thanks!
Rusty.

> @@ -272,7 +272,8 @@
>  		return -ENFILE;
>  	}
>  	filp->f_op = &futex_fops;
> -	filp->f_dentry = dget(futex_dentry);
> +	filp->f_vfsmnt = mntget(futex_mnt);
> +	filp->f_dentry = dget(futex_mnt->mnt_root);
>  
>  	if (signal) {
>  		filp->f_owner.pid = current->pid;
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy

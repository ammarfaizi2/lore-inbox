Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318848AbSIIUgZ>; Mon, 9 Sep 2002 16:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318844AbSIIUgY>; Mon, 9 Sep 2002 16:36:24 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:5127 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318890AbSIIUfv>; Mon, 9 Sep 2002 16:35:51 -0400
Date: Mon, 9 Sep 2002 13:43:52 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Skip Ford <skip.ford@verizon.net>, Alexander Viro <viro@math.psu.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.34 ufs/super.c
In-Reply-To: <200209092047.g89KldtA000217@pool-141-150-242-242.delv.east.verizon.net>
Message-ID: <Pine.LNX.4.33.0209091341550.1747-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch is definitely correct, but on the other hand I really think
that the calling convention of sb_set_blocksize() is wrong, and instead of
returning "size for success or zero for failure ", it should return "error
code for failure or zero for success".

There's just no point to returning the same size we just passed in.

And making that calling convention the new one would make the current UFS
code be the _right_ one.

Al, comments? Why the strange calling convention?

		Linus

----
On Mon, 9 Sep 2002, Skip Ford wrote:
>
> I've needed this patch since 2.5.32 to successfully mount a UFS
> partition.
> 
> --- linux/fs/ufs/super.c~	Mon Sep  9 16:39:52 2002
> +++ linux/fs/ufs/super.c	Mon Sep  9 16:39:57 2002
> @@ -605,7 +605,7 @@
>  	}
>  	
>  again:	
> -	if (sb_set_blocksize(sb, block_size)) {
> +	if (!sb_set_blocksize(sb, block_size)) {
>  		printk(KERN_ERR "UFS: failed to set blocksize\n");
>  		goto failed;
>  	}
> 
> 


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283707AbRK3RCI>; Fri, 30 Nov 2001 12:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283702AbRK3RB7>; Fri, 30 Nov 2001 12:01:59 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:44559 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S283678AbRK3RBs>; Fri, 30 Nov 2001 12:01:48 -0500
Date: Fri, 30 Nov 2001 13:44:42 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] smarter atime updates
In-Reply-To: <3C072279.D346CD09@zip.com.au>
Message-ID: <Pine.LNX.4.21.0111301344330.17515-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Now are you sure this can't break anything ? 

On Thu, 29 Nov 2001, Andrew Morton wrote:

> mark_inode_dirty() is quite expensive for journalling filesystems,
> and we're calling it a lot more than we need to.
> 
> --- linux-2.4.17-pre1/fs/inode.c	Mon Nov 26 11:52:07 2001
> +++ linux-akpm/fs/inode.c	Thu Nov 29 21:53:02 2001
> @@ -1187,6 +1187,8 @@ void __init inode_init(unsigned long mem
>   
>  void update_atime (struct inode *inode)
>  {
> +	if (inode->i_atime == CURRENT_TIME)
> +		return;
>  	if ( IS_NOATIME (inode) ) return;
>  	if ( IS_NODIRATIME (inode) && S_ISDIR (inode->i_mode) ) return;
>  	if ( IS_RDONLY (inode) ) return;
> 
> 
> with this patch, the time to read a 10 meg file with 10 million
> read()s falls from 38 seconds (ext3), 39 seconds (reiserfs) and
> 11.6 seconds (ext2) down to 10.5 seconds.
> 
> -
> 


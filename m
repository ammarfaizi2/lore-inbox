Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277053AbRJQSmx>; Wed, 17 Oct 2001 14:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277064AbRJQSmh>; Wed, 17 Oct 2001 14:42:37 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:53082 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S277053AbRJQSln>; Wed, 17 Oct 2001 14:41:43 -0400
Date: Wed, 17 Oct 2001 20:42:04 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Chip Salzenberg <chip@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Maneesh Soni <maneesh@in.ibm.com>
Subject: Re: [PATCH] 2.4.13pre3aa1: expand_fdset() may use invalid pointer
Message-ID: <20011017204204.C2380@athlon.random>
In-Reply-To: <20011017113245.A3849@perlsupport.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011017113245.A3849@perlsupport.com>; from chip@pobox.com on Wed, Oct 17, 2001 at 11:32:45AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2001 at 11:32:45AM -0700, Chip Salzenberg wrote:
> In 2.4.13pre3aa1, expand_fdset() in fs/file.c has a couple of
> execution paths that call kfree() on a pointer that hasn't yet been
> initialized.  A minimal patch is attached.

Good spotting! Thanks for the fix!! applied.

CC'ed Maneesh since he's maintaining the rcu_fdset patch AFIK.

> -- 
> Chip Salzenberg               - a.k.a. -              <chip@pobox.com>
>  "We have no fuel on board, plus or minus 8 kilograms."  -- NEAR tech

> 
> Index: linux/fs/file.c
> --- linux/fs/file.c.old	Tue Oct 16 23:28:16 2001
> +++ linux/fs/file.c	Wed Oct 17 00:29:43 2001
> @@ -203,5 +203,5 @@
>  	fd_set *new_openset = 0, *new_execset = 0;
>  	int error, nfds = 0;
> -	struct rcu_fd_set *arg;
> +	struct rcu_fd_set *arg = NULL;
>  
>  	error = -EMFILE;



Andrea

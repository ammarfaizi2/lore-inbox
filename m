Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316098AbSEJUA7>; Fri, 10 May 2002 16:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316101AbSEJUA6>; Fri, 10 May 2002 16:00:58 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:13000 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S316098AbSEJUA5>;
	Fri, 10 May 2002 16:00:57 -0400
Date: Fri, 10 May 2002 16:00:54 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Jan Harkes <jaharkes@cs.cmu.edu>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        trond.myklebust@fys.uio.no, reiserfs-dev@namesys.com
Subject: Re: [PATCH] iget_locked [3/6]
In-Reply-To: <20020510160741.GD18065@ravel.coda.cs.cmu.edu>
Message-ID: <Pine.GSO.4.21.0205101557380.19226-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 10 May 2002, Jan Harkes wrote:

> @@ -156,11 +165,12 @@
>  {
>  	int error = -ENOMEM;
>  
> -	*inode = iget(sb, CTL_INO);
> -	if ( *inode ) {
> +	*inode = iget_locked(sb, CTL_INO);
> +	if ( *inode && ((*inode)->i_state & I_NEW) ) {
>  		(*inode)->i_op = &coda_ioctl_inode_operations;
>  		(*inode)->i_fop = &coda_ioctl_operations;
>  		(*inode)->i_mode = 0444;
> +		unlock_new_inode(*inode);
>  		error = 0;

Ehhh....  Do we need this guy hashed, in the first place?

>    destroy_inode: reiserfs_destroy_inode,
>    read_inode: reiserfs_read_inode,
> -  read_inode2: reiserfs_read_inode2,

Why do we keep ->read_inode() here?


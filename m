Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316068AbSEJTx0>; Fri, 10 May 2002 15:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316093AbSEJTxZ>; Fri, 10 May 2002 15:53:25 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:33464 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S316068AbSEJTxY>;
	Fri, 10 May 2002 15:53:24 -0400
Date: Fri, 10 May 2002 15:53:17 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Jan Harkes <jaharkes@cs.cmu.edu>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        trond.myklebust@fys.uio.no, reiserfs-dev@namesys.com
Subject: Re: [PATCH] iget_locked [1/6]
In-Reply-To: <20020510160719.GB18065@ravel.coda.cs.cmu.edu>
Message-ID: <Pine.GSO.4.21.0205101550290.19226-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 10 May 2002, Jan Harkes wrote:

> Hi Linus,
> 
> Here is a series of 6 patches that started off as fixing a race in
> iget4, but ended up as a merge of the XFS icreate functionality, removal
> of the 'reiserfs specific hack' and reduces the VFS dependency on i_ino.
> 
> It has seen some discussion on linux-fsdevel.

I'm pretty much OK with that, but there are some comments on the patches

> +			if (set)
> +				err = set(inode, data);
> +			if (!err) {
> +				inodes_stat.nr_inodes++;
> +				list_add(&inode->i_list, &inode_in_use);
> +				list_add(&inode->i_hash, head);
> +				inode->i_state = I_LOCK;
> +			}
>  			spin_unlock(&inode_lock);
>  
> +			if (err) {
> +				destroy_inode(inode);
> +				return NULL;
> +			}

Please, take that code out of the path - will be cleaner that way.


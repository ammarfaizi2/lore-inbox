Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316111AbSEJUNw>; Fri, 10 May 2002 16:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316112AbSEJUNv>; Fri, 10 May 2002 16:13:51 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:5090 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S316111AbSEJUNu>;
	Fri, 10 May 2002 16:13:50 -0400
Date: Fri, 10 May 2002 16:13:47 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Jan Harkes <jaharkes@cs.cmu.edu>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        trond.myklebust@fys.uio.no, reiserfs-dev@namesys.com
Subject: Re: [PATCH] iget_locked [6/6]
In-Reply-To: <20020510160833.GG18065@ravel.coda.cs.cmu.edu>
Message-ID: <Pine.GSO.4.21.0205101610440.19226-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 10 May 2002, Jan Harkes wrote:

> 
> As of the previous patch the inode_hashtable doesn't really need to be
> indexed by i_ino anymore, the only reason we still have to keep the
> hashvalue and i_ino identical is because of insert_inode_hash.
> 
> Here we simply add an argument to insert_inode_hash. If at some point a
> FS specific getattr method is implemented it will be possible to
> completely remove all uses of i_ino in the VFS.

How about

static inline void insert_inode_hash(struct inode *inode)
{
	__insert_inode_hash(inode, inode->i_hash);
}

in fs.h and switching those who want something different to direct use
of __insert_inode_hash()?

It's going to remain a very common case and IMO it makes a lot of sense
to keep a simple helper for it.  That has a nice property of getting
patch way smaller ;-)


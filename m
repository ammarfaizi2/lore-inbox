Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261339AbSI3SrP>; Mon, 30 Sep 2002 14:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261336AbSI3SrP>; Mon, 30 Sep 2002 14:47:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24585 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261339AbSI3SrM>;
	Mon, 30 Sep 2002 14:47:12 -0400
Date: Mon, 30 Sep 2002 19:52:35 +0100
From: Matthew Wilcox <willy@debian.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, Chuck Lever <cel@netapp.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: Re: [PATCH] 2.4.20 Direct IO patch for NFS. (Note: a trivial API change...)
Message-ID: <20020930195235.P18377@parcelfarce.linux.theplanet.co.uk>
References: <15768.39196.468797.249573@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15768.39196.468797.249573@charged.uio.no>; from trond.myklebust@fys.uio.no on Mon, Sep 30, 2002 at 08:34:04PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2002 at 08:34:04PM +0200, Trond Myklebust wrote:
> diff -u --recursive --new-file linux-2.4.20-pre8/fs/block_dev.c linux-2.4.20-directio/fs/block_dev.c
> --- linux-2.4.20-pre8/fs/block_dev.c	Sun May 12 02:26:03 2002
> +++ linux-2.4.20-directio/fs/block_dev.c	Mon Sep 30 18:24:45 2002
> @@ -131,8 +131,9 @@
>  	return 0;
>  }
>  
> -static int blkdev_direct_IO(int rw, struct inode * inode, struct kiobuf * iobuf, unsigned long blocknr, int blocksize)
> +static int blkdev_direct_IO(int rw, struct file * filp, struct kiobuf * iobuf, unsigned long blocknr, int blocksize)
>  {
> +	struct inode * inode = filp->f_dentry->d_inode->i_mapping->host;
>  	return generic_direct_IO(rw, inode, iobuf, blocknr, blocksize, blkdev_get_block);
>  }
>  

isn't that two dereferences more than necessary for a local filesystem?

-- 
Revolutions do not require corporate support.

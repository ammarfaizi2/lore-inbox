Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261340AbSI3Swr>; Mon, 30 Sep 2002 14:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261331AbSI3Swr>; Mon, 30 Sep 2002 14:52:47 -0400
Received: from mons.uio.no ([129.240.130.14]:53129 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S261165AbSI3Swp>;
	Mon, 30 Sep 2002 14:52:45 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15768.40630.512787.879557@charged.uio.no>
Date: Mon, 30 Sep 2002 20:57:58 +0200
To: Matthew Wilcox <willy@debian.org>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Chuck Lever <cel@netapp.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: Re: [PATCH] 2.4.20 Direct IO patch for NFS. (Note: a trivial API change...)
In-Reply-To: <20020930195235.P18377@parcelfarce.linux.theplanet.co.uk>
References: <15768.39196.468797.249573@charged.uio.no>
	<20020930195235.P18377@parcelfarce.linux.theplanet.co.uk>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Matthew Wilcox <willy@debian.org> writes:

    >> -static int blkdev_direct_IO(int rw, struct inode * inode,
    >> struct kiobuf * iobuf, unsigned long blocknr, int blocksize)
    >> +static int blkdev_direct_IO(int rw, struct file * filp, struct
    >> kiobuf * iobuf, unsigned long blocknr, int blocksize) {
    >> + struct inode * inode =
    >>  	filp->f_dentry->d_inode->i_mapping->host;
    >> return generic_direct_IO(rw, inode, iobuf, blocknr, blocksize,
    >> blkdev_get_block); }
    >>

     > isn't that two dereferences more than necessary for a local
     > filesystem?

IIRC this is an issue with block filesystems: the i_mapping->host may
differ from d_inode.

It is in any case just the exact same dereference that is being made
in the current version of generic_file_direct_IO(). The API change
simply moves this dereference down into the filesystem code.

Cheers,
  Trond

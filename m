Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261779AbSJDWcd>; Fri, 4 Oct 2002 18:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261811AbSJDWcd>; Fri, 4 Oct 2002 18:32:33 -0400
Received: from packet.digeo.com ([12.110.80.53]:43492 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261779AbSJDWcc>;
	Fri, 4 Oct 2002 18:32:32 -0400
Message-ID: <3D9E1847.F6DDA3AE@digeo.com>
Date: Fri, 04 Oct 2002 15:37:59 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Chuck Lever <cel@citi.umich.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux NFS List <nfs@lists.sourceforge.net>
Subject: Re: [PATCH] direct-IO API change
References: <Pine.LNX.4.44.0210041807340.8094-100000@dexter.citi.umich.edu> <Pine.LNX.4.31.0210041525010.59482-100000@torvalds-p95.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Oct 2002 22:37:59.0804 (UTC) FILETIME=[B126EBC0:01C26BF6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Fri, 4 Oct 2002, Chuck Lever wrote:
> >
> > this patch adds a "struct file *" argument to direct I/O.  this is needed
> > by NFS direct I/O to make the file's credentials available to direct I/O
> > subroutines.  we can't remove "struct inode *" yet because the raw driver
> > still needs it.
> 
> Why isn't the raw driver changed to just use file->f_dentry->d_inode
> instead?
> 

Because the file handle which we have is for /dev/raw/raw0,
not for /dev/hda1.

The raw driver binds to major/minor, not a file*.  I considered
changing that (change userspace to pass the open fd).  But didn't.

An alternative would be to rewrite i_mapping for /dev/raw/raw0
to be bdev->bd_inode->i_mapping.  I guess we should look at doing
that.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261674AbSJNODu>; Mon, 14 Oct 2002 10:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261631AbSJNODu>; Mon, 14 Oct 2002 10:03:50 -0400
Received: from rj.sgi.com ([192.82.208.96]:39852 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S261626AbSJNODs>;
	Mon, 14 Oct 2002 10:03:48 -0400
Subject: Re: [patch] remove BKL from inode_setattr
From: Steve Lord <lord@sgi.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Hugh Dickins <hugh@veritas.com>, lkml <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <3DAA6587.2A4C24B0@digeo.com>
References: <3DAA4FD6.A18DAFE6@digeo.com>
	<Pine.LNX.4.44.0210140657240.9845-100000@localhost.localdomain> 
	<3DAA6587.2A4C24B0@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 14 Oct 2002 09:07:19 -0500
Message-Id: <1034604439.25231.9.camel@jen.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-14 at 01:34, Andrew Morton wrote:

> 
> The number of filsystems which do not take the bkl in truncate/setattr
> is in fact quite small.  Here's the patch which removes all doubt:
> 
> 
> 
> 
>  fs/affs/file.c          |   13 ++++++++-----
>  fs/attr.c               |    2 --
>  fs/cifs/inode.c         |    7 ++++++-
>  fs/jfs/file.c           |    3 +++
>  fs/reiserfs/file.c      |    2 ++
>  fs/smbfs/proc.c         |   18 +++++++++++++++---
>  fs/sysv/itree.c         |    6 +++++-
>  fs/xfs/linux/xfs_iops.c |   11 +++++++++--
>  8 files changed, 48 insertions(+), 14 deletions(-)

XFS deliberately does not take the BKL - anywhere. Our setattr
code is doing its own locking. You just added the BKL to a 
bunch of xfs operations which do not need it. Now, vmtruncate
may need it, itself, but if vmtruncate does not, then the xfs
callout from vmtruncate certainly does not.

Steve

-- 

Steve Lord                                      voice: +1-651-683-3511
Principal Engineer, Filesystem Software         email: lord@sgi.com

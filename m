Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261955AbSJNQfo>; Mon, 14 Oct 2002 12:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262003AbSJNQfo>; Mon, 14 Oct 2002 12:35:44 -0400
Received: from packet.digeo.com ([12.110.80.53]:35511 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261955AbSJNQfk>;
	Mon, 14 Oct 2002 12:35:40 -0400
Message-ID: <3DAAF3B2.24158D49@digeo.com>
Date: Mon, 14 Oct 2002 09:41:22 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steve Lord <lord@sgi.com>
CC: Hugh Dickins <hugh@veritas.com>, lkml <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [patch] remove BKL from inode_setattr
References: <3DAA6587.2A4C24B0@digeo.com> <1034604439.25231.9.camel@jen.americas.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Oct 2002 16:41:26.0807 (UTC) FILETIME=[8A102270:01C273A0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Lord wrote:
> 
> On Mon, 2002-10-14 at 01:34, Andrew Morton wrote:
> 
> >
> > The number of filsystems which do not take the bkl in truncate/setattr
> > is in fact quite small.  Here's the patch which removes all doubt:
> >
> >
> >
> >
> >  fs/affs/file.c          |   13 ++++++++-----
> >  fs/attr.c               |    2 --
> >  fs/cifs/inode.c         |    7 ++++++-
> >  fs/jfs/file.c           |    3 +++
> >  fs/reiserfs/file.c      |    2 ++
> >  fs/smbfs/proc.c         |   18 +++++++++++++++---
> >  fs/sysv/itree.c         |    6 +++++-
> >  fs/xfs/linux/xfs_iops.c |   11 +++++++++--
> >  8 files changed, 48 insertions(+), 14 deletions(-)
> 
> XFS deliberately does not take the BKL - anywhere. Our setattr
> code is doing its own locking. You just added the BKL to a
> bunch of xfs operations which do not need it. Now, vmtruncate
> may need it, itself, but if vmtruncate does not, then the xfs
> callout from vmtruncate certainly does not.
> 

Sorry, but that is standard "bkl migration" methodology.  You had it
before, so you get it after.  It is not my role to change XFS locking.

Anyway, I don't think these patches are going anywhere.

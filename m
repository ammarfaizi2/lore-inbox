Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315870AbSHaOwK>; Sat, 31 Aug 2002 10:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316544AbSHaOwK>; Sat, 31 Aug 2002 10:52:10 -0400
Received: from dsl-213-023-039-014.arcor-ip.net ([213.23.39.14]:8679 "EHLO
	starship") by vger.kernel.org with ESMTP id <S315870AbSHaOwJ>;
	Sat, 31 Aug 2002 10:52:09 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Keith Owens <kaos@ocs.com.au>, neilb@cse.unsw.edu.au
Subject: Re: [patch] 2.4.19 Generate better code for nfs_sillyrename
Date: Sat, 31 Aug 2002 16:58:20 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <5810.1030518440@kao2.melbourne.sgi.com>
In-Reply-To: <5810.1030518440@kao2.melbourne.sgi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17l9hd-0004Ow-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 August 2002 09:07, Keith Owens wrote:
> Using strlen() generates an unnecessary inline function expansion plus
> dynamic stack adjustment.  For constant strings, strlen() == sizeof()-1
> and the object code is better.  Patch against 2.4.19.

But now the source code is worse.  Macro?

> diff -urp 2.4.x-xfs-linux/fs/nfs/dir.c 2.4.x-xfs-linux-kdb/fs/nfs/dir.c
> --- 2.4.x-xfs-linux/fs/nfs/dir.c	Fri Aug  9 16:03:57 2002
> +++ 2.4.x-xfs-linux-kdb/fs/nfs/dir.c	Wed Aug 28 16:54:44 2002
> @@ -741,7 +741,7 @@ static int nfs_sillyrename(struct inode 
>  	static unsigned int sillycounter;
>  	const int      i_inosize  = sizeof(dir->i_ino)*2;
>  	const int      countersize = sizeof(sillycounter)*2;
> -	const int      slen       = strlen(".nfs") + i_inosize + countersize;
> +	const int      slen       = sizeof(".nfs")-1 + i_inosize + countersize;
>  	char           silly[slen+1];
>  	struct qstr    qsilly;
>  	struct dentry *sdentry;

-- 
Daniel

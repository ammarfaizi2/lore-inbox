Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262175AbUKWEqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbUKWEqI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 23:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262185AbUKVQd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 11:33:58 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:50649 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262161AbUKVQAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 11:00:03 -0500
Message-ID: <41A20CFA.3050101@namesys.com>
Date: Mon, 22 Nov 2004 07:59:54 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <juhl-lkml@dif.dk>
CC: lkml <linux-kernel@vger.kernel.org>, vs <vs@thebsh.namesys.com>
Subject: Re: [patch] silence sparse warning in fs/reiserfs/namei.c about using
 plain integer as NULL pointer
References: <Pine.LNX.4.61.0411212304180.3423@dragon.hygekrogen.localhost>
In-Reply-To: <Pine.LNX.4.61.0411212304180.3423@dragon.hygekrogen.localhost>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:

>Hi,
>
>sparse complains about passing 0 to functions execting a pointer argument:
>
>  CHECK   fs/reiserfs/namei.c
>fs/reiserfs/namei.c:617:50: warning: Using plain integer as NULL pointer
>
>Trivial patch to change it to pass NULL instead below.
>
>Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
>
>diff -up linux-2.6.10-rc2-bk6-orig/fs/reiserfs/namei.c linux-2.6.10-rc2-bk6/fs/reiserfs/namei.c
>--- linux-2.6.10-rc2-bk6-orig/fs/reiserfs/namei.c	2004-11-17 01:20:16.000000000 +0100
>+++ linux-2.6.10-rc2-bk6/fs/reiserfs/namei.c	2004-11-21 22:52:41.000000000 +0100
>@@ -614,7 +614,7 @@ static int reiserfs_create (struct inode
>         goto out_failed;
>     }
> 
>-    retval = reiserfs_new_inode (&th, dir, mode, 0, 0/*i_size*/, dentry, inode);
>+    retval = reiserfs_new_inode (&th, dir, mode, NULL, 0/*i_size*/, dentry, inode);
>     if (retval)
>         goto out_failed;
> 	
>
>
>
>
>  
>
thanks, vs. will look into it and get back to you.

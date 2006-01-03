Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932465AbWACTjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbWACTjb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 14:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932501AbWACTjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 14:39:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17292 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932465AbWACTja (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 14:39:30 -0500
Message-ID: <43BAD2EC.2030807@redhat.com>
Date: Tue, 03 Jan 2006 14:39:24 -0500
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.4.1 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ASANO Masahiro <masano@tnes.nec.co.jp>
CC: trond.myklebust@fys.uio.no, matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fix posix lock on NFS
References: <20051222.132454.1025208517.masano@tnes.nec.co.jp>
In-Reply-To: <20051222.132454.1025208517.masano@tnes.nec.co.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ASANO Masahiro wrote:

>---
>
>--- linux-2.6.15-rc6/fs/nfs/file.c.orig	2005-12-21 21:30:14.000000000 +0900
>+++ linux-2.6.15-rc6/fs/nfs/file.c	2005-12-21 21:42:16.000000000 +0900
>@@ -524,7 +524,8 @@ static int nfs_lock(struct file *filp, i
> 		return -EINVAL;
> 
> 	/* No mandatory locks over NFS */
>-	if ((inode->i_mode & (S_ISGID | S_IXGRP)) == S_ISGID)
>+	if ((inode->i_mode & (S_ISGID | S_IXGRP)) == S_ISGID &&
>+	    fl->fl_type != F_UNLCK)
> 		return -ENOLCK;
> 
> 	if (IS_GETLK(cmd))
>

Just out of curiosity, what is this if() statement intended to protect?
For locking purposes, why would the client care if the file has the
mandatory lock bits set?

    Thanx...

       ps

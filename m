Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933597AbWKWLJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933597AbWKWLJL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 06:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933600AbWKWLJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 06:09:10 -0500
Received: from mail.parknet.jp ([210.171.160.80]:17672 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S933597AbWKWLJJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 06:09:09 -0500
X-AuthUser: hirofumi@parknet.jp
To: junjiec@gmail.com
Cc: smartart@tiscali.it, linux-kernel@vger.kernel.org
Subject: Re: bug? VFAT copy problem
References: <877ixqhvlw.fsf@duaron.myhome.or.jp>
	<20061120184912.5e1b1cac@localhost>
	<87mz6kajks.fsf@duaron.myhome.or.jp>
	<45651ad4.562a64ed.0e8d.ffffd499@mx.google.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 23 Nov 2006 20:08:59 +0900
In-Reply-To: <45651ad4.562a64ed.0e8d.ffffd499@mx.google.com> (junjiec@gmail.com's message of "Thu\, 23 Nov 2006 12\:50\:47 +0900 \(JST\)")
Message-ID: <87vel61ktw.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

junjiec@gmail.com writes:

> We encountered this problem before,it did being caused by dcache.
> When creating files, VFS would check the dcache first and pass the dentry
> it found there to vfat_create(). Instead of dentry , using the path info
> passed by user solved the problem.
>
> --- namei.c	2006-11-18 18:41:58.000000000 +0900
> +++ namei.c.new	2006-11-23 12:45:34.000000000 +0900
> @@ -742,7 +742,7 @@
>  	lock_kernel();
>  
>  	ts = CURRENT_TIME_SEC;
> -	err = vfat_add_entry(dir, &dentry->d_name, 0, 0, &ts, &sinfo);
> +	err = vfat_add_entry(dir, &nd->last, 0, 0, &ts, &sinfo);
>  	if (err)
>  		goto out;
>  	dir->i_version++;
>

Interesting hack. However, mkdir() and rename() have same problem.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

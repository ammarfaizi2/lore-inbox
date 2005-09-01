Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbVIAIku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbVIAIku (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 04:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbVIAIku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 04:40:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21476 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751089AbVIAIkt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 04:40:49 -0400
Date: Thu, 1 Sep 2005 01:38:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kirill Korotaev <dev@sw.ru>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] replace hack with dget/mntget usage in fs/dcookies.c
Message-Id: <20050901013836.731e63e1.akpm@osdl.org>
In-Reply-To: <4316B61B.9070305@sw.ru>
References: <4316B61B.9070305@sw.ru>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> wrote:
>
> This patch replaces manual incrementing of refcounters on dentry/mnt in 
>  fs/dcookie.c with calls to dget()/mntget().
>
> ...
>
>  --- linux-2.6.8.1-t032/fs/dcookies.c.dget	2004-08-14 14:54:46.000000000 +0400
>  +++ linux-2.6.8.1-t032/fs/dcookies.c	2005-08-23 14:09:00.000000000 +0400

Whoa.  Medieval kernel.

>  @@ -93,12 +93,10 @@ static struct dcookie_struct * alloc_dco
>   	if (!dcs)
>   		return NULL;
>   
>  -	atomic_inc(&dentry->d_count);
>  -	atomic_inc(&vfsmnt->mnt_count);
>   	dentry->d_cookie = dcs;
>   
>  -	dcs->dentry = dentry;
>  -	dcs->vfsmnt = vfsmnt;
>  +	dcs->dentry = dget(dentry);
>  +	dcs->vfsmnt = mntget(vfsmnt);
>   	hash_dcookie(dcs);
>   
>   	return dcs;

That's already there.

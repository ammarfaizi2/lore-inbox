Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262074AbVFQTuR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbVFQTuR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 15:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbVFQTuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 15:50:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14526 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262074AbVFQTuA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 15:50:00 -0400
Date: Fri, 17 Jun 2005 15:49:52 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Gerald Schaefer <geraldsc@de.ibm.com>
cc: akpm@osdl.org, <linux-kernel@vger.kernel.org>, <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 0/1] VFS: memory leak in do_kern_mount()
In-Reply-To: <1119023242.7006.70.camel@thinkpad>
Message-ID: <Xine.LNX.4.44.0506171549300.3910-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jun 2005, Gerald Schaefer wrote:

> Sorry, there was a whitespace accident and the above patch would not apply.
> Here is the fixed version:
> 
> diff -pruN linux-2.6-git/fs/super.c linux-2.6-git_xxx/fs/super.c
> --- linux-2.6-git/fs/super.c	2005-06-16 20:00:26.000000000 +0200
> +++ linux-2.6-git_xxx/fs/super.c	2005-06-17 14:18:06.000000000 +0200
> @@ -835,6 +835,7 @@ do_kern_mount(const char *fstype, int fl
>  	mnt->mnt_parent = mnt;
>  	mnt->mnt_namespace = current->namespace;
>  	up_write(&sb->s_umount);
> +	free_secdata(secdata);
>  	put_filesystem(type);
>  	return mnt;
>  out_sb:

Acked-by: James Morris <jmorris@redhat.com>



- James
-- 
James Morris
<jmorris@redhat.com>



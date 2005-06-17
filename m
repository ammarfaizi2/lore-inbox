Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262002AbVFQPr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262002AbVFQPr2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 11:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbVFQPr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 11:47:28 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:17328 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S262002AbVFQPrZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 11:47:25 -0400
Subject: Re: [PATCH 0/1] VFS: memory leak in do_kern_mount()
From: Gerald Schaefer <geraldsc@de.ibm.com>
Reply-To: geraldsc@de.ibm.com
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
In-Reply-To: <1119014276.7006.57.camel@thinkpad>
References: <1119014276.7006.57.camel@thinkpad>
Content-Type: text/plain
Date: Fri, 17 Jun 2005 17:47:22 +0200
Message-Id: <1119023242.7006.70.camel@thinkpad>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-06-17 at 15:17 +0200, Gerald Schaefer wrote:
> [PATCH 0/1] VFS: memory leak in do_kern_mount()
> There is a memory leak during mount when CONFIG_SECURITY is enabled and mount
> options are specified.
> 
> Signed-off-by: Gerald Schaefer <geraldsc@de.ibm.com>
> ---
> 
> diff -pruN linux-2.6-git/fs/super.c linux-2.6-git_xxx/fs/super.c
> --- linux-2.6-git/fs/super.c    2005-06-16 20:00:26.000000000 +0200
> +++ linux-2.6-git_xxx/fs/super.c        2005-06-17 14:18:06.000000000 +0200
> @@ -835,6 +835,7 @@ do_kern_mount(const char *fstype, int fl
>         mnt->mnt_parent = mnt;
>         mnt->mnt_namespace = current->namespace;
>         up_write(&sb->s_umount);
> +       free_secdata(secdata);
>         put_filesystem(type);
>         return mnt;
>  out_sb:

Sorry, there was a whitespace accident and the above patch would not apply.
Here is the fixed version:

diff -pruN linux-2.6-git/fs/super.c linux-2.6-git_xxx/fs/super.c
--- linux-2.6-git/fs/super.c	2005-06-16 20:00:26.000000000 +0200
+++ linux-2.6-git_xxx/fs/super.c	2005-06-17 14:18:06.000000000 +0200
@@ -835,6 +835,7 @@ do_kern_mount(const char *fstype, int fl
 	mnt->mnt_parent = mnt;
 	mnt->mnt_namespace = current->namespace;
 	up_write(&sb->s_umount);
+	free_secdata(secdata);
 	put_filesystem(type);
 	return mnt;
 out_sb:



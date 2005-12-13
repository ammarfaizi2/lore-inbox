Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030302AbVLMWhA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030302AbVLMWhA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 17:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030306AbVLMWg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 17:36:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:35766 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030333AbVLMWg7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 17:36:59 -0500
Date: Tue, 13 Dec 2005 14:36:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] per-mount noatime and nodiratime
Message-Id: <20051213143638.120ee601.akpm@osdl.org>
In-Reply-To: <20051213175659.GF17130@lst.de>
References: <20051213175659.GF17130@lst.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:
>
> Turn noatime and nodiratime into per-mount instead of per-sb flags.
> 
> After all the preparations this is a rather trivial patch, touch_atime
> and nfs need to be changed to check the new location (and I've killed
> the IS_NOATIME/IS_NODIRATIME macros that were only used by touch_atime
> while we were at it), and the mount/remount code needed small changes
> to treat it correctly.
> 

Where'd this hunk come from?

> Index: linux-2.6.15-rc5/fs/super.c
> ===================================================================
> --- linux-2.6.15-rc5.orig/fs/super.c	2005-12-13 11:27:14.000000000 +0100
> +++ linux-2.6.15-rc5/fs/super.c	2005-12-13 12:06:00.000000000 +0100
> @@ -830,9 +830,9 @@
>  	mnt->mnt_parent = mnt;
>  
>  	if (type->fs_flags & FS_NOATIME)
> -		sb->s_flags |= MS_NOATIME;
> +		mnt->mnt_flags |= MNT_NOATIME;
>  	if (type->fs_flags & FS_NODIRATIME)
> -		sb->s_flags |= MS_NODIRATIME;
> +		mnt->mnt_flags |= MNT_NODIRATIME;
>  
>  	up_write(&sb->s_umount);
>  	free_secdata(secdata);

I just dropped it, but it's a worry...

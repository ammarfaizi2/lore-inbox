Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262292AbUKVRz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262292AbUKVRz0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 12:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262266AbUKVRyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 12:54:03 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:52986 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262233AbUKVRxG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 12:53:06 -0500
Date: Mon, 22 Nov 2004 09:19:19 -0800
From: Greg KH <greg@kroah.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/13] Filesystem in Userspace
Message-ID: <20041122171919.GA4957@kroah.com>
References: <E1CVeLj-0007Oe-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CVeLj-0007Oe-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 21, 2004 at 12:08:59AM +0100, Miklos Szeredi wrote:
> This patch adds an empty /sys/fs, which filesystems can use.
> 
> Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
> diff -ru linux-2.6.10-rc2.orig/fs/filesystems.c linux-2.6.10-rc2/fs/filesystems.c
> --- linux-2.6.10-rc2.orig/fs/filesystems.c	2004-11-17 17:33:26.000000000 +0100
> +++ linux-2.6.10-rc2/fs/filesystems.c	2004-11-18 14:34:07.000000000 +0100
> @@ -29,6 +29,7 @@
>  
>  static struct file_system_type *file_systems;
>  static rwlock_t file_systems_lock = RW_LOCK_UNLOCKED;
> +static decl_subsys(fs, NULL, NULL);

Just make this global and export it.  That way you can then get rid of
this code:

> +int fs_subsys_register(struct subsystem *sub)
> +{
> +	kset_set_kset_s(sub, fs_subsys);
> +	return subsystem_register(sub);
> +}
> +
> +EXPORT_SYMBOL(fs_subsys_register);

thanks,

greg k-h

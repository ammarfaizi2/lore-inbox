Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262423AbULOSBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbULOSBR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 13:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbULOSBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 13:01:17 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:44431 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262423AbULOR7b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 12:59:31 -0500
Date: Wed, 15 Dec 2004 18:59:30 +0100
From: Andi Kleen <ak@suse.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andi Kleen <ak@suse.de>, "Michael S. Tsirkin" <mst@mellanox.co.il>,
       linux-kernel@vger.kernel.org, pavel@suse.cz, discuss@x86-64.org,
       gordon.jin@intel.com
Subject: Re: unregister_ioctl32_conversion and modules. ioctl32 revisited.
Message-ID: <20041215175930.GG26772@wotan.suse.de>
References: <20041215065650.GM27225@wotan.suse.de> <200412151745.32053.arnd@arndb.de> <20041215165703.GC26772@wotan.suse.de> <200412151847.09598.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412151847.09598.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmm. I just had another idea. Maybe it's easier to return -ENOIOCTLCMD
> from ->ioctl_compat() in order to get back to the hash lookup. How
> about the change below?

Looks good too to me.

-Andi

> 
>       Arnd <><
> 
> --- mst/fs/compat.c
> +++ arnd/fs/compat.c
> @@ somewhere in compat_sys_ioctl() @@
>         else if (filp->f_op && filp->f_op->ioctl_compat) {
>                 error = filp->f_op->ioctl_compat(filp->f_dentry->d_inode,
>                                                  filp, cmd, arg);
> -               goto out;
> +               if (error != -ENOIOCTLCMD)
> +                        goto out;
>         }
>  
> 
> 



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264835AbTFQO5y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 10:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264841AbTFQO5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 10:57:53 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:63666 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S264835AbTFQO5k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 10:57:40 -0400
Date: Tue, 17 Jun 2003 17:11:14 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: 2.4.21 Floppy Fallback with NFS root ...
Message-ID: <20030617151114.GA910@elf.ucw.cz>
References: <20030616141832.GG23590@www.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030616141832.GG23590@www.13thfloor.at>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'm curious, is it intentional that, if you select
> NFS support and NFS Root support, that the fact, that
> no nfs is available, or selected via boot options,
> automatically leads to a floppy boot?
> 
> I would suggest the following trivial patch, to give
> the kernel compiler a chance to disable this 'feature'.
> 
> please correct me if I'm talking nonsense ...

This might be okay for 2.5.X, but its definitely bad idea for
2.4.X. (User visible change without good reason).

> diff -NurbP --minimal linux-2.4.21/fs/Config.in linux-2.4.21-ffb/fs/Config.in
> --- linux-2.4.21/fs/Config.in   Tue Dec 10 03:25:19 2002
> +++ linux-2.4.21-ffb/fs/Config.in       Mon Jun 16 15:05:09 2003
> @@ -103,6 +103,7 @@
>     dep_tristate 'NFS file system support' CONFIG_NFS_FS $CONFIG_INET
>     dep_mbool '  Provide NFSv3 client support' CONFIG_NFS_V3 $CONFIG_NFS_FS
>     dep_bool '  Root file system on NFS' CONFIG_ROOT_NFS $CONFIG_NFS_FS $CONFIG_IP_PNP
> +   dep_bool '    Floppy Fallback' CONFIG_FLOPPY_FALLBACK $CONFIG_ROOT_NFS
>  
>     dep_tristate 'NFS server support' CONFIG_NFSD $CONFIG_INET
>     dep_mbool '  Provide NFSv3 server support' CONFIG_NFSD_V3 $CONFIG_NFSD
> diff -NurbP --minimal linux-2.4.21/init/do_mounts.c linux-2.4.21-ffb/init/do_mounts.c
> --- linux-2.4.21/init/do_mounts.c       Fri Jun 13 17:49:28 2003
> +++ linux-2.4.21-ffb/init/do_mounts.c   Mon Jun 16 15:00:23 2003
> @@ -754,8 +754,10 @@
>                         printk("VFS: Mounted root (nfs filesystem).\n");
>                         return;
>                 }
> +# ifdef CONFIG_FLOPPY_FALLBACK         
>                 printk(KERN_ERR "VFS: Unable to mount root fs via NFS, trying floppy.\n");
>                 ROOT_DEV = MKDEV(FLOPPY_MAJOR, 0);
> +# endif
>         }
>  #endif
>         devfs_make_root(root_device_name);
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]

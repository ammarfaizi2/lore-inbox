Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262437AbULOSX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262437AbULOSX0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 13:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262436AbULOSXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 13:23:25 -0500
Received: from mail.mellanox.co.il ([194.90.237.34]:53093 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S262432AbULOSVH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 13:21:07 -0500
Date: Wed, 15 Dec 2004 20:21:09 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, pavel@suse.cz,
       discuss@x86-64.org, gordon.jin@intel.com
Subject: Re: unregister_ioctl32_conversion and modules. ioctl32 revisited.
Message-ID: <20041215182109.GA13539@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <200412151847.09598.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412151847.09598.arnd@arndb.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
Quoting r. Arnd Bergmann (arnd@arndb.de) "Re: unregister_ioctl32_conversion and modules. ioctl32 revisited.":
> On Middeweken 15 Dezember 2004 17:57, Andi Kleen wrote:
> > > Do you mean it should call back
> > > from its private ioctl_compat() function to the global
> ioctl32_hash_table[]
> > > lookup?
> > 
> > Yes.
> > 
> > Some ioctl paths already work this way, e.g. in the block layer.
> 
> Hmm. I just had another idea. Maybe it's easier to return -ENOIOCTLCMD
> from ->ioctl_compat() in order to get back to the hash lookup. How
> about the change below?
> 
>       Arnd <><
> 
> --- mst/fs/compat.c
> +++ arnd/fs/compat.c
> @@ somewhere in compat_sys_ioctl() @@
>         else if (filp->f_op && filp->f_op->ioctl_compat) {
>                 error =
> filp->f_op->ioctl_compat(filp->f_dentry->d_inode,
>                                                  filp, cmd, arg);
> -               goto out;
> +               if (error != -ENOIOCTLCMD)
> +                        goto out;
>         }
>  

But what if you really wanted to return -ENOIOCTLCMD?
And, the idea was to get rid of the hash eventually?

MST

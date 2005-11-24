Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161010AbVKXFyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161010AbVKXFyS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 00:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161012AbVKXFyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 00:54:18 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:18645
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1161010AbVKXFyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 00:54:17 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Neil Brown <neilb@suse.de>
Subject: Re: [PATCH] pivot_root broken in 2.6.15-rc1-mm2
Date: Wed, 23 Nov 2005 23:54:00 -0600
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, Al Viro <viro@ftp.linux.org.uk>
References: <17283.52960.913712.454816@cse.unsw.edu.au> <200511230543.24353.rob@landley.net> <17285.19207.788744.48747@cse.unsw.edu.au>
In-Reply-To: <17285.19207.788744.48747@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511232354.00843.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 November 2005 23:09, Neil Brown wrote:
> On Wednesday November 23, rob@landley.net wrote:
> > On Tuesday 22 November 2005 20:07, Neil Brown wrote:
> > > Pivot_root seems to be broken in 2.6.15-rc1-mm2.
> > >
> > > I havea initramfs filesystem, mount a ext3 filesystem (which has /mnt)
> > > at '/root' and
> > >
> > >   cd /root
> > >   pivot . mnt
> > >
> > > and it says -EINVAL.
> >
> > You can't pivot_root initramfs because initramfs is rootfs.
> >
> > I wrote Documentation/filesystems/ramfs-rootfs-initramfs.txt just for
> > this occasion. :)
>
> Unfortunately, 'man pivot_root' nor 'use the source, Luke' contain
> pointers to this particular useful document.  They both list assorted
> restrictions on pivot_root, but not this one.
>
> How about the following?
>
> Thanks,
> NeilBrown
>
> Signed-off-by: Neil Brown <neilb@suse.de>
Signed-off-by: Rob Landley <rob@landley.net>

> ### Diffstat output
>  ./fs/namespace.c |    4 ++++
>  1 file changed, 4 insertions(+)
>
> diff ./fs/namespace.c~current~ ./fs/namespace.c
> --- ./fs/namespace.c~current~ 2005-11-23 14:24:59.000000000 +1100
> +++ ./fs/namespace.c 2005-11-24 16:07:01.000000000 +1100
> @@ -1526,6 +1526,10 @@ static void chroot_fs_refs(struct nameid
>   * pointed to by put_old must yield the same directory as new_root. No
> other * file system may be mounted on put_old. After all, new_root is a
> mountpoint. *
> + * Also, the current root cannot be on the 'rootfs' (initial ramfs)
> filesystem. + * See Documentation/filesystems/ramfs-rootfs-initramfs.txt
> for alternatives + * in this situation.
> + *
>   * Notes:
>   *  - we don't move root/cwd if they are not at the root (reason: if
> something *    cared enough to change them, it's probably wrong to force
> them elsewhere)

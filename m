Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030599AbVKXFJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030599AbVKXFJs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 00:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030600AbVKXFJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 00:09:48 -0500
Received: from cantor2.suse.de ([195.135.220.15]:8904 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030599AbVKXFJp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 00:09:45 -0500
From: Neil Brown <neilb@suse.de>
To: Rob Landley <rob@landley.net>
Date: Thu, 24 Nov 2005 16:09:27 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17285.19207.788744.48747@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, Al Viro <viro@ftp.linux.org.uk>
Subject: Re: pivot_root broken in 2.6.15-rc1-mm2
In-Reply-To: message from Rob Landley on Wednesday November 23
References: <17283.52960.913712.454816@cse.unsw.edu.au>
	<200511230543.24353.rob@landley.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday November 23, rob@landley.net wrote:
> On Tuesday 22 November 2005 20:07, Neil Brown wrote:
> > Pivot_root seems to be broken in 2.6.15-rc1-mm2.
> >
> > I havea initramfs filesystem, mount a ext3 filesystem (which has /mnt)
> > at '/root' and
> >
> >   cd /root
> >   pivot . mnt
> >
> > and it says -EINVAL.
> 
> You can't pivot_root initramfs because initramfs is rootfs.
> 
> I wrote Documentation/filesystems/ramfs-rootfs-initramfs.txt just for this 
> occasion. :)

Unfortunately, 'man pivot_root' nor 'use the source, Luke' contain
pointers to this particular useful document.  They both list assorted
restrictions on pivot_root, but not this one.

How about the following?

Thanks,
NeilBrown

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/namespace.c |    4 ++++
 1 file changed, 4 insertions(+)

diff ./fs/namespace.c~current~ ./fs/namespace.c
--- ./fs/namespace.c~current~	2005-11-23 14:24:59.000000000 +1100
+++ ./fs/namespace.c	2005-11-24 16:07:01.000000000 +1100
@@ -1526,6 +1526,10 @@ static void chroot_fs_refs(struct nameid
  * pointed to by put_old must yield the same directory as new_root. No other
  * file system may be mounted on put_old. After all, new_root is a mountpoint.
  *
+ * Also, the current root cannot be on the 'rootfs' (initial ramfs) filesystem.
+ * See Documentation/filesystems/ramfs-rootfs-initramfs.txt for alternatives
+ * in this situation.
+ *
  * Notes:
  *  - we don't move root/cwd if they are not at the root (reason: if something
  *    cared enough to change them, it's probably wrong to force them elsewhere)



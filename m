Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262384AbREUELJ>; Mon, 21 May 2001 00:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262385AbREUEK7>; Mon, 21 May 2001 00:10:59 -0400
Received: from lssf069.lss.emc.com ([168.159.63.69]:3076 "EHLO
	mobilix.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S262384AbREUEKv>; Mon, 21 May 2001 00:10:51 -0400
Date: Sun, 20 May 2001 15:36:11 -0400
Message-Id: <200105201936.f4KJaBG15983@mobilix.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: "Ph. Marek" <marek@mail.bmlv.gv.at>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3.0.6.32.20010327090010.009163c0@pop3.bmlv.gv.at>
In-Reply-To: <3.0.6.32.20010327090010.009163c0@pop3.bmlv.gv.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ph. Marek writes:
> in fs/devfs/util.c is
> 	void __init devfs_make_root (const char *name)
> which is wrong as pivot_root allows changing the root-device in the runtime.
> 
> I think it should be 
> 	void __init devfs_make_root (const char *name)
> and get called by
> fs/super.c:
> 	asmlinkage long sys_pivot_root(const char *new_root, const char *put_old)
> after
> 	chroot_fs_refs(root,root_mnt,new_nd.dentry,new_nd.mnt);
> 	error = 0;
> 
> Is that correct?

No, because devfs_mk_root() only ever needs to called from
mount_root(). If you're doing pivot_root() then you've got initrd, in
which case you can create compatibility symlinks from user-space.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272143AbTHDSyl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 14:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272140AbTHDSx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 14:53:29 -0400
Received: from zok.sgi.com ([204.94.215.101]:13544 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S272135AbTHDSwd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 14:52:33 -0400
Date: Mon, 4 Aug 2003 11:52:31 -0700
To: "H. J. Lu" <hjl@lucon.org>
Cc: davidm@hpl.hp.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: milstone reached: ia64 linux builds out of Linus' tree
Message-ID: <20030804185231.GA532@sgi.com>
Mail-Followup-To: "H. J. Lu" <hjl@lucon.org>, davidm@hpl.hp.com,
	linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
References: <200308041737.h74HbdCf015443@napali.hpl.hp.com> <20030804175308.GB16804@lucon.org> <20030804180015.GA543@sgi.com> <20030804181033.GA17265@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030804181033.GA17265@lucon.org>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks H.J., this patch works for me!  I had to add one more for xfs
(included), but after that, things seemed to work.

Thanks,
Jesse

On Mon, Aug 04, 2003 at 11:10:33AM -0700, H. J. Lu wrote:
> On Mon, Aug 04, 2003 at 11:00:16AM -0700, Jesse Barnes wrote:
> > On Mon, Aug 04, 2003 at 10:53:08AM -0700, H. J. Lu wrote:
> > > On Mon, Aug 04, 2003 at 10:37:39AM -0700, David Mosberger wrote:
> > > > As of this morning, Linus's current bk tree
> > > > (http://linux.bkbits.net:8080/linux-2.5) builds and works out of the
> > > > box for ia64!
> > > > 
> > > 
> > > Does it work on bigsur? Does it support kernel modules?
> > 
> > I just tried the latest on my big sur, and though I think modules work
> > (at least they build for other machines), big sur is broken because
> > non-ACPI based PCI enumeration has been removed from the tree.
> > 
> 
> Can you try this patch for bigsur?

diff -Nru a/fs/xfs/linux/xfs_vfs.h b/fs/xfs/linux/xfs_vfs.h
--- a/fs/xfs/linux/xfs_vfs.h	Wed Jul 16 12:10:39 2003
+++ b/fs/xfs/linux/xfs_vfs.h	Wed Jul 16 12:10:39 2003
@@ -44,8 +44,8 @@
 
 typedef struct vfs {
 	u_int			vfs_flag;	/* flags */
-	fsid_t			vfs_fsid;	/* file system ID */
-	fsid_t			*vfs_altfsid;	/* An ID fixed for life of FS */
+	__kernel_fsid_t			vfs_fsid;	/* file system ID */
+	__kernel_fsid_t			*vfs_altfsid;	/* An ID fixed for life of FS */
 	bhv_head_t		vfs_bh;		/* head of vfs behavior chain */
 	struct super_block	*vfs_super;	/* Linux superblock structure */
 	struct task_struct	*vfs_sync_task;
diff -Nru a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
--- a/fs/xfs/xfs_mount.c	Wed Jul 16 12:10:39 2003
+++ b/fs/xfs/xfs_mount.c	Wed Jul 16 12:10:39 2003
@@ -889,7 +889,7 @@
 	 *  File systems that don't support user level file handles (i.e.
 	 *  all of them except for XFS) will leave vfs_altfsid as NULL.
 	 */
-	vfsp->vfs_altfsid = (fsid_t *)mp->m_fixedfsid;
+	vfsp->vfs_altfsid = (__kernel_fsid_t *)mp->m_fixedfsid;
 	mp->m_dmevmask = 0;	/* not persistent; set after each mount */
 
 	/*

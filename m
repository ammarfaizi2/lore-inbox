Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933056AbWKWHw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933056AbWKWHw7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 02:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933043AbWKWHw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 02:52:59 -0500
Received: from tomts43-srv.bellnexxia.net ([209.226.175.110]:23526 "EHLO
	tomts43-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S933056AbWKWHw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 02:52:58 -0500
Date: Thu, 23 Nov 2006 02:52:56 -0500
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Greg KH <greg@kroah.com>
Cc: ltt-dev@shafik.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] DebugFS : coding style fixes
Message-ID: <20061123075256.GC1703@Krystal>
References: <20061120181838.GB7328@Krystal> <20061122052730.GD20836@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_Krystal-5426-1164268376-0001-2"
Content-Disposition: inline
In-Reply-To: <20061122052730.GD20836@kroah.com>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 02:51:50 up 92 days,  4:59,  3 users,  load average: 0.22, 0.23, 0.18
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_Krystal-5426-1164268376-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Minor coding style fixes along the way : 80 cols and a white space.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>


* Greg KH (greg@kroah.com) wrote:
> On Mon, Nov 20, 2006 at 01:18:38PM -0500, Mathieu Desnoyers wrote:
> > Hi Greg,
> > 
> > I just had to add inotify support to my LTTng consumer so I could inform it
> > of the presence of new CPUs (for CPU hotplug). I noticed that no
> > notification event was being sent when a debugfs file is created from within
> > the kernel through debugfs_create. There are probably other notifications
> > missing, but here is the patch adding the one I care about. Should it be added
> > in libfs or in debugfs ?
> 
> So does this fix the inotify issue?
> 
> > A second problem I noticed is when a caller calls debugfs_create_file more than
> > once : the result is that the debugfs_remove will fail. I guess the second call
> > to debugfs_create_file increments the reference counts (there is not fix for
> > this issue in my patch).
> > 
> > Third problem : a failing call to debugfs_remove keeps the filesystem pinned.
> > (fixed by calling simple_release_fs in the error path).
> > 
> > The third problem : When a process is in a directory, the call to simple_rmdir
> > will fail. Debugfs does not use its return value. I noticed that calling
> > simple_unlink on a directory when simple_rmdir fails removes the directory that
> > would otherwise be left there. I am not sure if this approach is correct
> > through.
> > 
> > This patch is against Linux 2.6.18.
> 
> Care to split this into 4 different patches (you seem to have 4 issues
> here), so that it's easier to see them, and it will follow the
> 1-patch-per-issue rule?
> 
> thanks,
> 
> greg k-h
> 
OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 

--=_Krystal-5426-1164268376-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch02-debugfs-codingstyle.diff"

--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -54,7 +54,8 @@
 			inode->i_op = &simple_dir_inode_operations;
 			inode->i_fop = &simple_dir_operations;
 
-			/* directory inodes start off with i_nlink == 2 (for "." entry) */
+			/* directory inodes start off with i_nlink == 2
+			 * (for "." entry) */
 			inode->i_nlink++;
 			break;
 		}
@@ -135,7 +136,7 @@
 	 * block. A pointer to that is in the struct vfsmount that we
 	 * have around.
 	 */
-	if (!parent ) {
+	if (!parent) {
 		if (debugfs_mount && debugfs_mount->mnt_sb) {
 			parent = debugfs_mount->mnt_sb->s_root;
 		}

--=_Krystal-5426-1164268376-0001-2--

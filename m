Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751851AbWCDMOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751851AbWCDMOx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 07:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751827AbWCDMOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 07:14:44 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:22288 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751828AbWCDMOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 07:14:39 -0500
Date: Sat, 4 Mar 2006 13:14:39 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] kernel/futex.c: make futexfs_get_sb() static again
Message-ID: <20060304121439.GP9295@stusta.de>
References: <20060303045651.1f3b55ec.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060303045651.1f3b55ec.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2006 at 04:56:51AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.16-rc5-mm1:
>...
> +nfs-apply-mount-root-dentry-override-to-filesystems.patch
>...
>  Share nfs superblocks between mounts from the same server.
>...


futexfs_get_sb() became global for no good reason.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc5-mm2-full/kernel/futex.c.old	2006-03-03 18:18:09.000000000 +0100
+++ linux-2.6.16-rc5-mm2-full/kernel/futex.c	2006-03-03 18:18:27.000000000 +0100
@@ -1057,9 +1057,9 @@
 			(unsigned long)uaddr2, val2, val3);
 }
 
-int futexfs_get_sb(struct file_system_type *fs_type,
-		   int flags, const char *dev_name, void *data,
-		   struct vfsmount *mnt)
+static int futexfs_get_sb(struct file_system_type *fs_type,
+			  int flags, const char *dev_name, void *data,
+			  struct vfsmount *mnt)
 {
 	return get_sb_pseudo(fs_type, "futex", NULL, 0xBAD1DEA, mnt);
 }


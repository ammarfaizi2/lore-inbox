Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbUBHBao (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 20:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbUBHB3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 20:29:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:179 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261967AbUBHB2x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 20:28:53 -0500
Date: Sat, 7 Feb 2004 17:31:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: Valdis.Kletnieks@vt.edu
Cc: jmorris@redhat.com, linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil
Subject: Re: 2.6.2-mm1, selinux, and initrd
Message-Id: <20040207173102.07b0e932.akpm@osdl.org>
In-Reply-To: <200402080115.i181Fn9q002138@turing-police.cc.vt.edu>
References: <Xine.LNX.4.44.0402070846040.19428-100000@thoron.boston.redhat.com>
	<200402080115.i181Fn9q002138@turing-police.cc.vt.edu>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
>
> On Sat, 07 Feb 2004 08:49:28 EST, James Morris said:
> 
> > Ok, looks like a problem where devfs is passing an empty string to 
> > do_mount when it expects a page.
> > 
> > Please try the patch below against 2.6.2-mm1.
> 
> OK, thanks.. that's a "confirmed working"...
> 


So I queue up the below patch, yes?



From: James Morris <jmorris@redhat.com>

devfs is passing an empty string to do_mount when it expects a page.



---

 fs/devfs/base.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN fs/devfs/base.c~devfs-do_mount-fix fs/devfs/base.c
--- 25/fs/devfs/base.c~devfs-do_mount-fix	2004-02-07 07:37:51.000000000 -0800
+++ 25-akpm/fs/devfs/base.c	2004-02-07 07:37:51.000000000 -0800
@@ -2840,7 +2840,7 @@ void __init mount_devfs_fs (void)
     int err;
 
     if ( !(boot_options & OPTION_MOUNT) ) return;
-    err = do_mount ("none", "/dev", "devfs", 0, "");
+    err = do_mount ("none", "/dev", "devfs", 0, NULL);
     if (err == 0) printk (KERN_INFO "Mounted devfs on /dev\n");
     else PRINTK ("(): unable to mount devfs, err: %d\n", err);
 }   /*  End Function mount_devfs_fs  */

_


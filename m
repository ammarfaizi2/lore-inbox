Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267338AbTBKJeT>; Tue, 11 Feb 2003 04:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267339AbTBKJeT>; Tue, 11 Feb 2003 04:34:19 -0500
Received: from verein.lst.de ([212.34.181.86]:39692 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S267338AbTBKJeR>;
	Tue, 11 Feb 2003 04:34:17 -0500
Date: Tue, 11 Feb 2003 10:43:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove some dead mtrr code
Message-ID: <20030211104356.A21407@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the devfs interface code in mtrr that has been
stubbed out by an ifdef forever.  It's one of the few remaining users
of regular files on devfs so there's some urge for me to get rid of it :)


--- 1.4/arch/i386/kernel/cpu/mtrr/if.c	Sat Dec 21 22:17:44 2002
+++ edited/arch/i386/kernel/cpu/mtrr/if.c	Wed Feb  5 01:52:11 2003
@@ -1,6 +1,5 @@
 #include <linux/init.h>
 #include <linux/proc_fs.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/ctype.h>
 #include <linux/module.h>
 #include <linux/seq_file.h>
@@ -300,8 +299,6 @@
 
 #  endif			/*  CONFIG_PROC_FS  */
 
-static devfs_handle_t devfs_handle;
-
 char * attrib_to_str(int x)
 {
 	return (x <= 6) ? mtrr_strings[x] : "?";
@@ -337,7 +334,6 @@
 			     attrib_to_str(type), usage_table[i]);
 		}
 	}
-	devfs_set_file_size(devfs_handle, len);	
 	return 0;
 }
 
@@ -350,11 +346,6 @@
 		proc_root_mtrr->owner = THIS_MODULE;
 		proc_root_mtrr->proc_fops = &mtrr_fops;
 	}
-#endif
-#ifdef USERSPACE_INTERFACE
-	devfs_handle = devfs_register(NULL, "cpu/mtrr", DEVFS_FL_DEFAULT, 0, 0,
-				      S_IFREG | S_IRUGO | S_IWUSR,
-				      &mtrr_fops, NULL);
 #endif
 	return 0;
 }

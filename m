Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275971AbRJBJi6>; Tue, 2 Oct 2001 05:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275982AbRJBJit>; Tue, 2 Oct 2001 05:38:49 -0400
Received: from t2.redhat.com ([199.183.24.243]:29175 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S275971AbRJBJii>; Tue, 2 Oct 2001 05:38:38 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: JFFS and JFFS2 MODULE_* tags.
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 02 Oct 2001 10:38:44 +0100
Message-ID: <2828.1002015524@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The addition of MODULE_LICENSE(sic) prompted me to add MODULE_AUTHOR and 
MODULE_DESCRIPTION tags too. This also fixes an unnecessary use of min_t().

diff -uNr -x CVS linux-ac/fs/jffs/inode-v23.c linux-ac-mtd/fs/jffs/inode-v23.c
--- linux-ac/fs/jffs/inode-v23.c	Tue Oct  2 10:18:44 2001
+++ linux-ac-mtd/fs/jffs/inode-v23.c	Tue Oct  2 10:32:22 2001
@@ -10,7 +10,7 @@
  * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
  *
- * $Id: inode-v23.c,v 1.69 2001/09/23 23:28:36 dwmw2 Exp $
+ * $Id: inode-v23.c,v 1.70 2001/10/02 09:16:02 dwmw2 Exp $
  *
  * Ported to Linux 2.3.x and MTD:
  * Copyright (C) 2000  Alexander Larsson (alex@cendio.se), Cendio Systems AB
@@ -1467,7 +1467,7 @@
 
 		D3(printk("jffs_file_write(): new f_pos %ld.\n", (long)pos));
 
-		thiscount = min_t(unsigned int, c->fmc->max_chunk_size - sizeof(struct jffs_raw_inode), count);
+		thiscount = min(c->fmc->max_chunk_size - sizeof(struct jffs_raw_inode), count);
 	}
  out:
 	D3(printk (KERN_NOTICE "file_write(): up biglock\n"));
@@ -1764,4 +1764,7 @@
 
 module_init(init_jffs_fs)
 module_exit(exit_jffs_fs)
+
+MODULE_DESCRIPTION("The Journalling Flash File System");
+MODULE_AUTHOR("Axis Communications AB.");
 MODULE_LICENSE("GPL");
diff -uNr -x CVS linux-ac/fs/jffs2/super.c linux-ac-mtd/fs/jffs2/super.c
--- linux-ac/fs/jffs2/super.c	Tue Oct  2 10:18:44 2001
+++ linux-ac-mtd/fs/jffs2/super.c	Tue Oct  2 10:32:27 2001
@@ -31,7 +31,7 @@
  * provisions above, a recipient may use your version of this file
  * under either the RHEPL or the GPL.
  *
- * $Id: super.c,v 1.47 2001/09/23 11:00:04 dwmw2 Exp $
+ * $Id: super.c,v 1.48 2001/10/02 09:16:23 dwmw2 Exp $
  *
  */
 
@@ -381,4 +381,8 @@
 
 module_init(init_jffs2_fs);
 module_exit(exit_jffs2_fs);
-MODULE_LICENSE("GPL"); // Also uses the RHEPL
+
+MODULE_DESCRIPTION("The Journalling Flash File System, v2");
+MODULE_AUTHOR("Red Hat, Inc.");
+MODULE_LICENSE("GPL"); // Actually dual-licensed, but it doesn't matter for 
+		       // the sake of this tag. It's Free Software.


--
dwmw2



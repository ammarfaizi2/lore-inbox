Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288533AbSADIE1>; Fri, 4 Jan 2002 03:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288534AbSADIDs>; Fri, 4 Jan 2002 03:03:48 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:31928 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S288533AbSADID0>; Fri, 4 Jan 2002 03:03:26 -0500
Date: Fri, 4 Jan 2002 00:03:25 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: linux-2.5.2-pre7/drivers/block/rd.c kdev_t fix
Message-ID: <20020104000325.A13203@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	The following patch fixes a kdev_t compilation problem
in linux-2.5.2-pre7/drivers/block/rd.c.  Note that I have not yet
gotten 2.5.2-pre7 to fully build, so this patch is untested.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rd.diff"

--- linux-2.5.2-pre7/drivers/block/rd.c	Thu Jan  3 19:52:01 2002
+++ linux/drivers/block/rd.c	Thu Jan  3 23:47:12 2002
@@ -453,7 +482,7 @@
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	/* We ought to separate initrd operations here */
-	register_disk(NULL, MKDEV(MAJOR_NR,INITRD_MINOR), 1, &rd_bd_op, rd_size<<1);
+	register_disk(NULL, mk_kdev(MAJOR_NR,INITRD_MINOR), 1, &rd_bd_op, rd_size<<1);
 	devfs_register(devfs_handle, "initrd", DEVFS_FL_DEFAULT, MAJOR_NR,
 			INITRD_MINOR, S_IFBLK | S_IRUSR, &rd_bd_op, NULL);
 #endif

--gKMricLos+KVdGMg--

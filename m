Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285060AbSALGRo>; Sat, 12 Jan 2002 01:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285062AbSALGRf>; Sat, 12 Jan 2002 01:17:35 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:5288 "EHLO ns1.yggdrasil.com")
	by vger.kernel.org with ESMTP id <S285060AbSALGRR>;
	Sat, 12 Jan 2002 01:17:17 -0500
Date: Fri, 11 Jan 2002 22:17:11 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: linux-kernel@vger.kernel.org, osst@riede.org, torvalds@transmeta.com
Cc: osst@linux1.onstream.nl
Subject: Patch: linux-2.5.2-pre11/drivers/scsi/osst.c kdev_t compilation fixes
Message-ID: <20020111221711.A13710@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	Per advice by Jens Axboe and Arnaldo Carvalho de Melo,
I am holding off on requesting integration most of my other
drivers/scsi compilation fixes that I posted earlier today, pending
some related changes that will require updates to those patches.  

	However, I think the changes to osst.c should go in now,
since the changes to that file are only only kdev_t compilation fixes.
Here is the patch.  If nobody complains, please apply.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="osst.diffs"

--- linux-2.5.2-pre11/drivers/scsi/osst.c	Thu Jan 10 07:59:28 2002
+++ linux/drivers/scsi/osst.c	Thu Jan 10 07:32:08 2002
@@ -125,8 +125,8 @@
 #define OSST_TIMEOUT (200 * HZ)
 #define OSST_LONG_TIMEOUT (1800 * HZ)
 
-#define TAPE_NR(x) (MINOR(x) & ~(128 | ST_MODE_MASK))
-#define TAPE_MODE(x) ((MINOR(x) & ST_MODE_MASK) >> ST_MODE_SHIFT)
+#define TAPE_NR(x) (minor(x) & ~(128 | ST_MODE_MASK))
+#define TAPE_MODE(x) ((minor(x) & ST_MODE_MASK) >> ST_MODE_SHIFT)
 
 /* Internal ioctl to set both density (uppermost 8 bits) and blocksize (lower
    24 bits) */
@@ -4103,7 +4103,7 @@
 		return (-EBUSY);
 	}
 	STp->in_use       = 1;
-	STp->rew_at_close = (MINOR(inode->i_rdev) & 0x80) == 0;
+	STp->rew_at_close = (minor(inode->i_rdev) & 0x80) == 0;
 
 	if (STp->device->host->hostt->module)
 		 __MOD_INC_USE_COUNT(STp->device->host->hostt->module);
@@ -4124,7 +4124,7 @@
 	flags = filp->f_flags;
 	STp->write_prot = ((flags & O_ACCMODE) == O_RDONLY);
 
-	STp->raw = (MINOR(inode->i_rdev) & 0x40) != 0;
+	STp->raw = (minor(inode->i_rdev) & 0x40) != 0;
 
 	/* Allocate a buffer for this user */
 	need_dma_buffer = STp->restr_dma;
@@ -5407,7 +5407,7 @@
 #endif
 
 	tpnt->device = SDp;
-	tpnt->devt = MKDEV(MAJOR_NR, i);
+	tpnt->devt = mk_kdev(MAJOR_NR, i);
 	tpnt->dirty = 0;
 	tpnt->in_use = 0;
 	tpnt->drv_buffer = 1;  /* Try buffering if no mode sense */

--4Ckj6UjgE2iN1+kY--

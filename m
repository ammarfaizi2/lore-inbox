Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318314AbSHEVDL>; Mon, 5 Aug 2002 17:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318421AbSHEVDK>; Mon, 5 Aug 2002 17:03:10 -0400
Received: from h-64-105-137-168.SNVACAID.covad.net ([64.105.137.168]:45529
	"EHLO freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S318314AbSHEVDH>; Mon, 5 Aug 2002 17:03:07 -0400
Date: Mon, 5 Aug 2002 14:06:34 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
To: ldm@flatcap.org, aia21@cantab.ne, jakob.kemi@telia.com,
       ldm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Patch: linux-2.5.30/fs/partitions/ldm.c BUG_ON(cond1 || cond2) separation
Message-ID: <20020805140634.A2999@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	linux-2.5.30/fs/partitions/ldm.c had 23 statements 
of the form BUG_ON(condition1 || condition2).  This patch changes
them to:

		BUG_ON(condition1);
		BUG_ON(condition2);

	This way you may get more useful information if somebody
trips one of them.  I recently tripped such a statement with a
sporadic bug and was pretty frustrated by the reduced opportunity
to track it down, so I've decided to submit patches to fix all
such instances in the kernel.  Grepping for 'BUG_ON.*\|\|' reveals
only four kernel components with such statements:
drivers/usb/storage/transport.c, ach/arm/mach-iop310/iq80310-pci.c,
fs/ntfs/, and fs/partitions/ldm.c.  This is the final patch in the
series, which should eliminate all such BUG_ON(cond1 || cond2) statements.

	I would like to get this patch into Linus's 2.5 tree.
Could you please let me know if you want to handle submitting it
to Linus, if you want me to do so, if you want to follow some other
course of action?  Thanks in advance.

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ldm.diff"

--- linux-2.5.30/fs/partitions/ldm.c	2002-08-01 14:16:20.000000000 -0700
+++ linux/fs/partitions/ldm.c	2002-08-05 13:55:38.000000000 -0700
@@ -136,7 +136,8 @@
  */
 static BOOL ldm_parse_privhead (const u8 *data, struct privhead *ph)
 {
-	BUG_ON (!data || !ph);
+	BUG_ON (!data);
+	BUG_ON (!ph);
 
 	if (MAGIC_PRIVHEAD != BE64 (data)) {
 		ldm_error ("Cannot find PRIVHEAD structure. LDM database is"
@@ -193,7 +194,8 @@
  */
 static BOOL ldm_parse_tocblock (const u8 *data, struct tocblock *toc)
 {
-	BUG_ON (!data || !toc);
+	BUG_ON (!data);
+	BUG_ON (!toc);
 
 	if (MAGIC_TOCBLOCK != BE64 (data)) {
 		ldm_crit ("Cannot find TOCBLOCK, database may be corrupt.");
@@ -239,7 +241,8 @@
  */
 static BOOL ldm_parse_vmdb (const u8 *data, struct vmdb *vm)
 {
-	BUG_ON (!data || !vm);
+	BUG_ON (!data);
+	BUG_ON (!vm);
 
 	if (MAGIC_VMDB != BE32 (data)) {
 		ldm_crit ("Cannot find the VMDB, database may be corrupt.");
@@ -275,7 +278,8 @@
 static BOOL ldm_compare_privheads (const struct privhead *ph1,
 				   const struct privhead *ph2)
 {
-	BUG_ON (!ph1 || !ph2);
+	BUG_ON (!ph1);
+	BUG_ON (!ph2);
 
 	return ((ph1->ver_major          == ph2->ver_major)		&&
 		(ph1->ver_minor          == ph2->ver_minor)		&&
@@ -299,7 +303,8 @@
 static BOOL ldm_compare_tocblocks (const struct tocblock *toc1,
 				   const struct tocblock *toc2)
 {
-	BUG_ON (!toc1 || !toc2);
+	BUG_ON (!toc1);
+	BUG_ON (!toc2);
 
 	return ((toc1->bitmap1_start == toc2->bitmap1_start)	&&
 		(toc1->bitmap1_size  == toc2->bitmap1_size)	&&
@@ -336,7 +341,8 @@
 	long num_sects;
 	int i;
 
-	BUG_ON (!bdev || !ph1);
+	BUG_ON (!bdev);
+	BUG_ON (!ph1);
 
 	ph[1] = kmalloc (sizeof (*ph[1]), GFP_KERNEL);
 	ph[2] = kmalloc (sizeof (*ph[2]), GFP_KERNEL);
@@ -424,7 +430,8 @@
 	BOOL result = FALSE;
 	int i;
 
-	BUG_ON (!bdev || !ldb);
+	BUG_ON (!bdev);
+	BUG_ON (!ldb);
 
 	ph    = &ldb->ph;
 	tb[0] = &ldb->toc;
@@ -493,7 +500,8 @@
 	struct vmdb *vm;
 	struct tocblock *toc;
 
-	BUG_ON (!bdev || !ldb);
+	BUG_ON (!bdev);
+	BUG_ON (!ldb);
 
 	vm  = &ldb->vm;
 	toc = &ldb->toc;
@@ -632,7 +640,8 @@
 	struct vblk_part *part;
 	int part_num = 1;
 
-	BUG_ON (!pp || !ldb);
+	BUG_ON (!pp);
+	BUG_ON (!ldb);
 
 	disk = ldm_get_disk_objid (ldb);
 	if (!disk) {
@@ -740,7 +749,8 @@
 {
 	int length;
 
-	BUG_ON (!block || !buffer);
+	BUG_ON (!block);
+	BUG_ON (!buffer);
 
 	length = block[0];
 	if (length >= buflen) {
@@ -769,7 +779,8 @@
 	int r_objid, r_name, r_vstate, r_child, r_parent, r_stripe, r_cols, len;
 	struct vblk_comp *comp;
 
-	BUG_ON (!buffer || !vb);
+	BUG_ON (!buffer);
+	BUG_ON (!vb);
 
 	r_objid  = ldm_relative (buffer, buflen, 0x18, 0);
 	r_name   = ldm_relative (buffer, buflen, 0x18, r_objid);
@@ -820,7 +831,8 @@
 	int r_objid, r_name, r_diskid, r_id1, r_id2, len;
 	struct vblk_dgrp *dgrp;
 
-	BUG_ON (!buffer || !vb);
+	BUG_ON (!buffer);
+	BUG_ON (!vb);
 
 	r_objid  = ldm_relative (buffer, buflen, 0x18, 0);
 	r_name   = ldm_relative (buffer, buflen, 0x18, r_objid);
@@ -865,7 +877,8 @@
 	int r_objid, r_name, r_id1, r_id2, len;
 	struct vblk_dgrp *dgrp;
 
-	BUG_ON (!buffer || !vb);
+	BUG_ON (!buffer);
+	BUG_ON (!vb);
 
 	r_objid  = ldm_relative (buffer, buflen, 0x18, 0);
 	r_name   = ldm_relative (buffer, buflen, 0x18, r_objid);
@@ -908,7 +921,8 @@
 	int r_objid, r_name, r_diskid, r_altname, len;
 	struct vblk_disk *disk;
 
-	BUG_ON (!buffer || !vb);
+	BUG_ON (!buffer);
+	BUG_ON (!vb);
 
 	r_objid   = ldm_relative (buffer, buflen, 0x18, 0);
 	r_name    = ldm_relative (buffer, buflen, 0x18, r_objid);
@@ -947,7 +961,8 @@
 	int r_objid, r_name, len;
 	struct vblk_disk *disk;
 
-	BUG_ON (!buffer || !vb);
+	BUG_ON (!buffer);
+	BUG_ON (!vb);
 
 	r_objid = ldm_relative (buffer, buflen, 0x18, 0);
 	r_name  = ldm_relative (buffer, buflen, 0x18, r_objid);
@@ -980,7 +995,8 @@
 	int r_objid, r_name, r_size, r_parent, r_diskid, r_index, len;
 	struct vblk_part *part;
 
-	BUG_ON (!buffer || !vb);
+	BUG_ON (!buffer);
+	BUG_ON (!vb);
 
 	r_objid  = ldm_relative (buffer, buflen, 0x18, 0);
 	r_name   = ldm_relative (buffer, buflen, 0x18, r_objid);
@@ -1033,7 +1049,8 @@
 	int r_drive, len;
 	struct vblk_volu *volu;
 
-	BUG_ON (!buffer || !vb);
+	BUG_ON (!buffer);
+	BUG_ON (!vb);
 
 	r_objid  = ldm_relative (buffer, buflen, 0x18, 0);
 	r_name   = ldm_relative (buffer, buflen, 0x18, r_objid);
@@ -1103,7 +1120,8 @@
 	BOOL result = FALSE;
 	int r_objid;
 
-	BUG_ON (!buf || !vb);
+	BUG_ON (!buf);
+	BUG_ON (!vb);
 
 	r_objid = ldm_relative (buf, len, 0x18, 0);
 	if (r_objid < 0) {
@@ -1155,7 +1173,8 @@
 	struct vblk *vb;
 	struct list_head *item;
 
-	BUG_ON (!data || !ldb);
+	BUG_ON (!data);
+	BUG_ON (!ldb);
 
 	vb = kmalloc (sizeof (*vb), GFP_KERNEL);
 	if (!vb) {
@@ -1216,7 +1235,8 @@
 	struct list_head *item;
 	int rec, num, group;
 
-	BUG_ON (!data || !frags);
+	BUG_ON (!data);
+	BUG_ON (!frags);
 
 	group = BE32 (data + 0x08);
 	rec   = BE16 (data + 0x0C);
@@ -1296,7 +1316,8 @@
 	struct frag *f;
 	struct list_head *item;
 
-	BUG_ON (!frags || !ldb);
+	BUG_ON (!frags);
+	BUG_ON (!ldb);
 
 	list_for_each (item, frags) {
 		f = list_entry (item, struct frag, list);
@@ -1334,7 +1355,8 @@
 	BOOL result = FALSE;
 	LIST_HEAD (frags);
 
-	BUG_ON (!bdev || !ldb);
+	BUG_ON (!bdev);
+	BUG_ON (!ldb);
 
 	size   = ldb->vm.vblk_size;
 	perbuf = 512 / size;
@@ -1420,7 +1442,8 @@
 	unsigned long base;
 	int result = -1;
 
-	BUG_ON (!pp || !bdev);
+	BUG_ON (!pp);
+	BUG_ON (!bdev);
 
 	/* Look for signs of a Dynamic Disk */
 	if (!ldm_validate_partition_table (bdev))

--vtzGhvizbBRQ85DL--

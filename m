Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266274AbUI0OyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266274AbUI0OyT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 10:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266296AbUI0OyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 10:54:19 -0400
Received: from ppsw-3.csi.cam.ac.uk ([131.111.8.133]:28291 "EHLO
	ppsw-3.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S266274AbUI0OyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 10:54:14 -0400
Date: Mon, 27 Sep 2004 15:54:03 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [2-6-BK-patch] Tiny update for LDM driver (fs/partitions/ldm.c)
Message-ID: <Pine.LNX.4.60.0409271550440.1867@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, Linus, please do a

	bk pull http://linux-ntfs.bkbits.net/ldm-2.6

Or alternatively, pipe this email to bk receive (or just apply the below 
patch).  Thanks!

This is a tiny update for the LDM driver (fs/partitions/ldm.c): The
last_vblkd_seq can be before the end of the vmdb, just make sure it is not
out of bounds.  If it is abort.  If it is not just continue happily.

This makes the warning message reported by Marcin Gibula disappear.

Richard Russon, the LDM maintainer is happy with this change.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

This will update the following files:

 fs/partitions/ldm.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

through these ChangeSets:

<aia21@cantab.net> (04/09/27 1.1995)
   Update for the LDM driver (fs/partitions/ldm.c): The last_vblkd_seq can
   be before the end of the vmdb, just make sure it is not out of bounds.
   If it is abort.  If it is not just continue happily.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>


diff -Nru a/fs/partitions/ldm.c b/fs/partitions/ldm.c
--- a/fs/partitions/ldm.c	2004-09-27 15:43:39 +01:00
+++ b/fs/partitions/ldm.c	2004-09-27 15:43:39 +01:00
@@ -2,7 +2,7 @@
  * ldm - Support for Windows Logical Disk Manager (Dynamic Disks)
  *
  * Copyright (C) 2001,2002 Richard Russon <ldm@flatcap.org>
- * Copyright (C) 2001      Anton Altaparmakov <aia21@cantab.net>
+ * Copyright (c) 2001-2004 Anton Altaparmakov
  * Copyright (C) 2001,2002 Jakob Kemi <jakob.kemi@telia.com>
  *
  * Documentation is available at http://linux-ntfs.sf.net/ldm
@@ -517,9 +517,15 @@
 	if (vm->vblk_offset != 512)
 		ldm_info ("VBLKs start at offset 0x%04x.", vm->vblk_offset);
 
-	/* FIXME: How should we handle this situation? */
-	if ((vm->vblk_size * vm->last_vblk_seq) != (toc->bitmap1_size << 9))
-		ldm_info ("VMDB and TOCBLOCK don't agree on the database size.");
+	/*
+	 * The last_vblkd_seq can be before the end of the vmdb, just make sure
+	 * it is not out of bounds.
+	 */
+	if ((vm->vblk_size * vm->last_vblk_seq) > (toc->bitmap1_size << 9)) {
+		ldm_crit ("VMDB exceeds allowed size specified by TOCBLOCK.  "
+				"Database is corrupt.  Aborting.");
+		goto out;
+	}
 
 	result = TRUE;
 out:

===================================================================

This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


M'XL( !LG6$$  [5576_;-A1]%G_%1?IBMY-,4E^1%AM)[*$MFB)!VNQE& **
MHFTNDJB)M#NOZG\?J6XQEMD/&5J)$"CR\%SRW'.E%W"G19=[3#)*T MXH[3)
M/<X:PXJ@$<8.W2IEAR9K58N)[OBD*FN?!@FR4S?,\#5L1:=SCP3AXXC9M2+W
M;G]Z?7=U<8O0= KS-6M6XH,P,)TBH[HMJTI]SLRZ4DU@.M;H6A@6<%7WC]">
M8DSM'9,TQ''2DP1':<])20B+B"@QC4Z3"+7"B$[1<R,J.3#\\@__K__FBG!&
M$Y)$61SV.+$76@ )2);%@*,)SB8T!1+G(<T)?85)CC$,LISOY8!7!'R,+N';
M'F&..-RU)3,"EJH#LQ9PM7@/92>MMC!:ZDG+.B.-5(UV^@=\G,-'BZJ8-O?;
MHGHH[[7X'>Q&+5,A;+,\8B 230EJ.72W=5G\ +]MM(&:/0C0&XN1!J2&1AE0
M&^.0A=HTI0XLT=OEW[.L4)T)8#_@X ,/5XV1S4; FK6MK'9NF6T?Y*H1I:^6
M2[_8Y7#1&-7 1668/8<-K;9P]E3:&7H'<9)%Z&9O%N0_\T((,XQFT#H;'L[-
M 3'W6<I(%).>A&D8][Q,*1/I:8;#A%,N_F.&8U3.9RF)0HJC/DY30H8*. !V
MM? ]=HK80UN?EW(EU)-Z.$(9XI 0G$:4T#[&873ZM3+"IW6!H^-U@<&/ODMA
M'/;Y\UQN:8[Y')YC<\OS:'1KUR&YU^!WGX9F_7=S*,__P\:+& AZZQ[P$N:J
MW75RM38PXF.PRA'?V>Q 6=EU%$-H5U(*&?(F+Y%G";Z)A([HZ,?"3DZ0)Y<P
M&FUK?^;BW&OYI[!KW/MC<!=[##,8&<7]62%-S5KR%7EV!MEX#)^1YUG5[GEG
M@XU.?GZ_N 3Q!Q>BM FJ*O5)E##@=2NX7$K[6NS@X_7\\NIZ_LYF[\02>-[)
M@EEO,BW<AKGJNDWK4GOA4BR;57 R_M'B5LHH=Q3;_[+_H?&UX ]Z4T\YC0L2
,TPC]!>GU0+8G!P  
 

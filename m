Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265045AbUASOPf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 09:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265053AbUASOPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 09:15:34 -0500
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:10977 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S265045AbUASOPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 09:15:22 -0500
Date: Mon, 19 Jan 2004 14:15:14 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH-BK-2.6] NTFS fix "du" and "stat" output (NTFS 2.1.6). 
Message-ID: <Pine.SOL.4.58.0401191413180.7391@yellow.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

	bk pull http://linux-ntfs.bkbits.net/ntfs-2.6

Thanks!

This fixes the erroneous "du" and "stat" output people reported on ntfs
partitions containing compressed directories.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

This will update the following files:

 Documentation/filesystems/ntfs.txt |    3 +++
 fs/ntfs/ChangeLog                  |    8 ++++++++
 fs/ntfs/Makefile                   |    2 +-
 fs/ntfs/inode.c                    |    4 ++--
 4 files changed, 14 insertions(+), 3 deletions(-)

through these ChangeSets:

<aia21@cantab.net> (04/01/19 1.1474.98.1)
   Fix minor bug in handling of compressed directories that fixes the
   erroneous "du" and "stat" output people reported.


diff -Nru a/Documentation/filesystems/ntfs.txt b/Documentation/filesystems/ntfs.txt
--- a/Documentation/filesystems/ntfs.txt	Mon Jan 19 14:11:25 2004
+++ b/Documentation/filesystems/ntfs.txt	Mon Jan 19 14:11:25 2004
@@ -272,6 +272,9 @@

 Note, a technical ChangeLog aimed at kernel hackers is in fs/ntfs/ChangeLog.

+2.1.6:
+	- Fix minor bug in handling of compressed directories that fixes the
+	  erroneous "du" and "stat" output people reported.
 2.1.5:
 	- Minor bug fix in attribute list attribute handling that fixes the
 	  I/O errors on "ls" of certain fragmented files found by at least two
diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	Mon Jan 19 14:11:25 2004
+++ b/fs/ntfs/ChangeLog	Mon Jan 19 14:11:25 2004
@@ -20,6 +20,14 @@
 	  sufficient for synchronisation here. We then just need to make sure
 	  ntfs_readpage/writepage/truncate interoperate properly with us.

+2.1.6 - Fix minor bug in handling of compressed directories.
+
+	- Fix bug in handling of compressed directories.  A compressed
+	  directory is not really compressed so when we set the ->i_blocks
+	  field of a compressed directory inode we were setting it from the
+	  non-existing field ni->itype.compressed.size which gave random
+	  results...  For directories we now always use ni->allocated_size.
+
 2.1.5 - Fix minor bug in attribute list attribute handling.

 	- Fix bug in attribute list handling.  Actually it is not as much a bug
diff -Nru a/fs/ntfs/Makefile b/fs/ntfs/Makefile
--- a/fs/ntfs/Makefile	Mon Jan 19 14:11:25 2004
+++ b/fs/ntfs/Makefile	Mon Jan 19 14:11:25 2004
@@ -5,7 +5,7 @@
 ntfs-objs := aops.o attrib.o compress.o debug.o dir.o file.o inode.o mft.o \
 	     mst.o namei.o super.o sysctl.o time.o unistr.o upcase.o

-EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.5\"
+EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.6\"

 ifeq ($(CONFIG_NTFS_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
diff -Nru a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c	Mon Jan 19 14:11:25 2004
+++ b/fs/ntfs/inode.c	Mon Jan 19 14:11:25 2004
@@ -1,7 +1,7 @@
 /**
  * inode.c - NTFS kernel inode handling. Part of the Linux-NTFS project.
  *
- * Copyright (c) 2001-2003 Anton Altaparmakov
+ * Copyright (c) 2001-2004 Anton Altaparmakov
  *
  * This program/include file is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as published
@@ -1046,7 +1046,7 @@
 	 * sizes of all non-resident attributes present to give us the Linux
 	 * correct size that should go into i_blocks (after division by 512).
 	 */
-	if (!NInoCompressed(ni))
+	if (S_ISDIR(vi->i_mode) || !NInoCompressed(ni))
 		vi->i_blocks = ni->allocated_size >> 9;
 	else
 		vi->i_blocks = ni->itype.compressed.size >> 9;

===================================================================

This BitKeeper patch contains the following changesets:
1.1474.98.1
## Wrapped with gzip_uu ##


M'XL( (_E"T   ]U7:V_B.!3]3'[%7>9+NR."G7>0&)4I[0R:;J>"Z6JE[0J9
MQ(&H28QB V65'[]V4@KEH2VHLQ\VH 3R.-?WW'/LFP]PSVG>JI&8&%C[ %\9
M%ZU:0#)!1GI&A3S59TR>:DY82IOE;<U,1+QAZ(XFK]X1$4Q@3G/>JF'=?#DC
MEE/:JO6OOMS?=/J:UF[#Y81D8SJ@ MIM3;!\3I*07Q Q25BFBYQD/*6"Z %+
MBY=;"P,A0WYL[)K(=@KL(,LM AQB3"Q,0V18GF.MT=0@=<;#1&?Y^#6,A3#R
ML8]<TR],!R-+ZP+6L>5:NN_I&)#51+B)?<!FR_!;MOL1H19"4*9\L68$/EK0
M0-IG>-\4+K4 KN,G2..,Y3":C2'.0&*$29R-@44@0:<YY9R&$,8Y#63XF'(0
M$R(@BI_*GU2"T#QG&64S#O5P5@>) '4NB*@#FXGI3,"4LFE"(:=3E@L:ZMHW
M,&UL&=K=ND1:X\A-TQ!!VB?X_*V(>"F0YF_DD49Q0@OLNTB2CY&)?-LOD/SC
M%A$-\,C&,G"(S-$NS;LP50VQCTW#M\W"\"1J%;'+@EE*Y9,B9EE3W<R77-"T
M0M#%D]@S!H0+UT8.=5%D4&<4CLS1[B#>@+PU+,M!GO.:"%G1D.K!/AZL8A2$
M9N0Y@>.%*/!=XS 1*YBM@([A>_[K@%49;]AX7]I.$49.Y!,LLZ>1Z4;6X9!K
MH.V@R+/LTM7_SI"R^SL623NQ2"96FVN;EE68ECR6_K?0CO'-@\8W?Y;Q[Z<A
M$;2<164*RI&5C+Y#(U^47^FPNS=P?8)O>X9K@:D9.M:=EE9KO,<L5(,3IB&E
MIAWA/8OG1&7O:F6OLC>E8=A8$E\N#89_A#:\GZR-EP$K=53VVU+'3FHGB<$
MK]("G*0$77M8:>CMSP!T-BXI]:RN+B'FD#$A94*29+D)P!DL)C2#!04N"R!E
M!XU/\7"4L."1*XPHIDFHHI)]<26RFD_5XPN:EQA"C3*6.LY9NI)QQK(&?8IY
M>:U"S&(91[4W^AI6Y_'?$F@2R\YG3.92UC)KEBH$><,L$5S799K7DLI-V\C@
M&5L 219DR6'&:0DN,V6!K'DX5*B*T4UKK-;#+6<<M=H>]L7F:OO*%I[C^Z4M
M7/L(5V!HX/]HQJSZ@0.>6*5U@B6Z'F"MIW97?_SH=X:7US>=+P-H0Z-[^^-Z
M,/S]JC_H?;]M/]1+VSS47U7K>='>*M91'8%&'J?I11B/*5-T_;DB\Z]]G8'D
M#7F20-LV"MGD>FXUE2'GB*(9T##^7_UMU2,=T,8S>Z=(PU+24#OX%2[9=)G'
MXXF L^ <)"FXH9HFZ&2"9=!)!)F2/"6/;*YUY=N'KQY]/M;B",X&P]Z@V^N?
MS=7T,DSEF,ZA*."7VU[&+E^X.<OB\_/U>U<PH7*VFZ5M.[!-%+A8^P>,6Q*K
$T0T


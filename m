Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264927AbSJ3Vfr>; Wed, 30 Oct 2002 16:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264928AbSJ3Vfr>; Wed, 30 Oct 2002 16:35:47 -0500
Received: from smtp3.us.dell.com ([143.166.148.134]:57618 "EHLO
	smtp3.us.dell.com") by vger.kernel.org with ESMTP
	id <S264927AbSJ3Vfp>; Wed, 30 Oct 2002 16:35:45 -0500
Date: Wed, 30 Oct 2002 15:42:10 -0600 (CST)
From: Matt Domsch <Matt_Domsch@Dell.com>
X-X-Sender: mdomsch@humbolt.us.dell.com
Reply-To: Matt Domsch <Matt_Domsch@Dell.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH 2.5.44] EDD updates 3/4
In-Reply-To: <Pine.LNX.4.44.0210301356050.27031-100000@humbolt.us.dell.com>
Message-ID: <Pine.LNX.4.44.0210301541100.28435-100000@humbolt.us.dell.com>
X-GPG-Fingerprint: 17A4 17D0 81F5 4B5F DB1C  AEF8 21AB EEF7 92F0 FC09
X-GPG-Key: http://domsch.com/mdomsch_pub.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resend, with right patch #3 of 4.
-Matt

You can import this changeset into BK by piping this whole message to
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.811, 2002-10-23 11:25:28-05:00, Matt_Domsch@dell.com
  EDD: remove list_head from edd_device, don't delete symlinks
  
  Update comments
  Remove list_head from edd_device, don't delete it
  Don't delete symlinks - driverfs_remove_dir() will.


 edd.c |   11 +++--------
 1 files changed, 3 insertions, 8 deletions


diff -Nru a/arch/i386/kernel/edd.c b/arch/i386/kernel/edd.c
--- a/arch/i386/kernel/edd.c	Wed Oct 23 13:16:00 2002
+++ b/arch/i386/kernel/edd.c	Wed Oct 23 13:16:00 2002
@@ -26,14 +26,13 @@
 
 /*
  * Known issues:
- * - module unload leaves a directory around.  Seems related to
- *   creating symlinks in that directory.  Seen on kernel 2.5.41.
+ * - module unload leaves directories around if a symlink was
+ *   created in that directory.  Confirmed is a driverfs bug, not
+ *   ours.  Seen on kernel 2.5.41.
  * - refcounting of struct device objects could be improved.
  *
  * TODO:
  * - Add IDE and USB disk device support
- * - when driverfs model of discs and partitions changes,
- *   update symlink accordingly.
  * - Get symlink creator helper functions exported from
  *   drivers/base instead of duplicating them here.
  * - move edd.[ch] to better locations if/when one is decided
@@ -80,7 +79,6 @@
 struct edd_device {
 	char name[EDD_DEVICE_NAME_SIZE];
 	struct edd_info *info;
-	struct list_head node;
 	struct driver_dir_entry dir;
 };
 
@@ -860,10 +858,7 @@
 static inline void
 edd_device_unregister(struct edd_device *edev)
 {
-	driverfs_remove_file(&edev->dir, "pci_dev");
-	driverfs_remove_file(&edev->dir, "disc");
 	driverfs_remove_dir(&edev->dir);
-	list_del_init(&edev->node);
 }
 
 static int

===================================================================


This BitKeeper patch contains the following changesets:
1.811
## Wrapped with gzip_uu ##


begin 664 bkpatch19598
M'XL(`&#GMCT``\54;6O;,!#^'/V*@W[86VWKQ6\Q9'2KRS:VL9+2ST&QE-K$
MMHJD)"OXQ^^2K-G8LD%+QVQA?*>[T_/</>@$KIVVQ>BS]'Y6FLY5-3F!]\;Y
M8J1TVX:5Z=`Q-08=46TZ'75J%Q;-EU';]*NO`0^30"L5>+.U'<'X2^FK&M;:
MNF+$0G'P^+M;78RF%^^N/[V9$C*9P'DM^QM]I3U,)L0;NY:M<F?2UZWI0V]E
M[SKMY1;&<`@=.*4<WX1E@B;IP%(:9T/%%&,R9EI1'N=I3'[B=';/Y9<BC'+!
M4I8G?.`B%XR4P,*<,:`\8C3B`A@K>%+P/*!)02D<JPFO&`24O(6GA7].*K@H
MRP*L[LQ:0]LX/ZNU5+"P>"AV?*;TNJGT*2C3/_.`>+37X.XZG,/283JNZULE
MT8D`.MW[K7/ZL'*-QYSRV`$0@+(-#GGA9GN,,]78YR]@TV!CR$?`EO*$7/Z8
M,0D>^!!")26OC[9]D!95V(@\C9;:]KJ-D$-8?9\K'7/*1!(/+.%9/(S3=)PM
M%ME<*K'(9/6(BENE\(2+(4DR&N_$>SQ^J^0G!_R(BGMIH[1H3K-X)^WX-V&+
MOPI;0)#_$V'_3UGNY_<%`KO9+939Y1]&^0C!EGP,G'P0%`2!EPBF,VK5:ECU
MK4%6K99K[0`1Z0K;VN"_M&;5*V@6(.])P$:Z;39`934V"G=[\+7TA\2[$.#<
M](O&=MM=K')@#?/5S2GTQN\KF)5U&'RE=0^FAST]P$L[C%E(2I$@W#)'0>`W
?%3LC3=$Z7-I5K:NE6W433F4VUV--O@%=[TW6-@8`````
`
end


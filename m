Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263526AbTLSTBl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 14:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263343AbTLSTBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 14:01:41 -0500
Received: from linux.us.dell.com ([143.166.224.162]:23200 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S263015AbTLSTBd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 14:01:33 -0500
Date: Fri, 19 Dec 2003 13:01:29 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: linux-kernel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Subject: Re: [RFC] 2.6.0 EDD enhancements
Message-ID: <20031219130129.B6530@lists.us.dell.com>
References: <Pine.LNX.4.44.0312191254550.2465-100000@humbolt.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0312191254550.2465-100000@humbolt.us.dell.com>; from Matt_Domsch@dell.com on Fri, Dec 19, 2003 at 12:57:06PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can import this changeset into BK by piping this whole message to
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.1532.1.2, 2003-12-18 16:35:16-06:00, Matt_Domsch@dell.com
  EDD: enable symlinks to SCSI devices
  
  Symlinks from /sys/firmware/edd/int13_dev8x/disc to the appropriate
  SCSI discs were added a year ago, but disabled because the
  scsi_bus list contained non-'scsi_device's at that time, which
  could have lead to an improper pointer following.    The SCSI
  mid-layer has rectified this, so this code can be re-enabled
  in edd.c once again.


 edd.c |   18 ++++--------------
 1 files changed, 4 insertions, 14 deletions


diff -Nru a/arch/i386/kernel/edd.c b/arch/i386/kernel/edd.c
--- a/arch/i386/kernel/edd.c	Fri Dec 19 12:53:18 2003
+++ b/arch/i386/kernel/edd.c	Fri Dec 19 12:53:18 2003
@@ -60,7 +60,7 @@
 MODULE_DESCRIPTION("sysfs interface to BIOS EDD information");
 MODULE_LICENSE("GPL");
 
-#define EDD_VERSION "0.11 2003-Dec-17"
+#define EDD_VERSION "0.12 2003-Dec-18"
 #define EDD_DEVICE_NAME_SIZE 16
 #define REPORT_URL "http://domsch.com/linux/edd30/results.html"
 
@@ -561,16 +561,6 @@
 	return sysfs_create_link(&edev->kobj,&pci_dev->dev.kobj,"pci_dev");
 }
 
-/*
- * FIXME - as of 15-Jan-2003, there are some non-"scsi_device"s on the
- * scsi_bus list.  The following functions could possibly mis-access
- * memory in that case.  This is actually a problem with the SCSI
- * layer, which is being addressed there.  Until then, don't use the
- * SCSI functions.
- */
-
-#undef CONFIG_SCSI
-#undef CONFIG_SCSI_MODULE
 #if defined(CONFIG_SCSI) || defined(CONFIG_SCSI_MODULE)
 
 struct edd_match_data {
@@ -639,11 +629,11 @@
 	pci_dev = edd_get_pci_dev(edev);
 	if (pci_dev) {
 		struct scsi_device * sdev = edd_find_matching_scsi_device(edev);
-		if (sdev && get_device(&sdev->sdev_driverfs_dev)) {
+		if (sdev && get_device(&sdev->sdev_gendev)) {
 			rc = sysfs_create_link(&edev->kobj,
-					       &sdev->sdev_driverfs_dev.kobj,
+					       &sdev->sdev_gendev.kobj,
 					       "disc");
-			put_device(&sdev->sdev_driverfs_dev);
+			put_device(&sdev->sdev_gendev);
 		}
 	}
 	return rc;

===================================================================


This BitKeeper patch contains the following changesets:
1.1532.1.2
## Wrapped with gzip_uu ##


M'XL( !Y)XS\  \55:8_;-A#];/V*01;8).A*(JG#1^$@[7K1+GIDL6[ZU:#)
MD<5:$@V17L>H?WR'<HX>VP!;!"@MD#8Y;_AF]!Y\ 6\=]K/13]+[U<*V3M71
M!7QOG9^--#9-HFQ+&_?6TD9:VQ;35@]AZ7J;HM9I8[K]NU@D14R_(HJ]DU[5
M\("]FXUXDGW<\<<=SD;W-]^]_?&;^RB:S^&ZEMT&E^AA/H^\[1]DH]UKZ>O&
M=HGO9>=:]#)0.'T,/0G&!'T*/LY849YXR?+Q27'-N<PY:B;R29E'?ZKG]8<Z
M_IHDXX)/!.=95IZ*\;04T0)XPHM,)#P1P+*4BY1/@)>SK)CQ,F;EC#%X+#%\
MQ2%FT;?P96NXCA3<+!8SP$ZN&P1W;*G96T?7P/)Z>0L:'XQ"1V'T+#^<5CTQ
M2MW1I97IVX/L<7A/IO,\6Q%D\B[5QJF0Q=<(<K?K[:XWTF/(,N2E8P<'[.E4
M:]0@X8BR![FQ5[#>^Q 0&&E8HY)[AR$1@0EE5NN]@\8X#\IV7IJ.HCK;Q<^'
MPS/CYPZD)TR83(M7<*@-Z4X19-]HJ.4#0H-2!XJR ],&AMC#SE(1M%:V:>S!
M=)L$:/Q"103:A&^-CAMYI)!:.NA1>5,9(N!KXZ[ V>$+W:(1%"5>(\7$Y^YJ
M@IL.J%.) MLI*GU#[)/H!PCJX-'=)[E&\1-'%#')HE>/BN<D>S*3R29ENL6^
MPR8=. P:X8Q-!>-9D9]X(<;Y:5J6TW%5C==29]58JJ=F/(M>9 4K@N@%&WSX
M>'PPY1<G_-2,[UW*IOGT)#(VR0:7"O9W?[+BL_[,(>;Y_V?004/4[#<0]X?A
M(4W<_4O?_X.Z%F4&/+H=Y@N-%;DN$%O]>G._O'WS,SQC"1<0VADO4,5\\BQ:
M%&4.G!$T%P-V6$8C4\$+1[SA\A(VZ-\[]L5EV(M?A7FUP8Z6ER_A]X#.S^A\
M0-. \_@G(-G:]6]7 5*>(>49LMM_[I:O/_VEJ!K5UNW;N2@$(J^*Z \JUFC(
$O@8     
 

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293092AbSDQQAh>; Wed, 17 Apr 2002 12:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293132AbSDQQAg>; Wed, 17 Apr 2002 12:00:36 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:33740 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S293092AbSDQQA1>; Wed, 17 Apr 2002 12:00:27 -0400
Date: Wed, 17 Apr 2002 18:00:25 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [BKPATCH 2.5] meye driver: get parameters from the kernel command line
Message-ID: <20020417160025.GI1519@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch enables the meye driver to get its parameters from
the kernel command line using a "meye=" style syntax.

Linus, please apply.

Stelian.


You can import this changeset into BK by piping this whole message to
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.533, 2002-04-17 16:54:44+02:00, stelian@popies.net
  Enable the meye driver to get parameters on the kernel command line.


 Documentation/video4linux/meye.txt |   10 +++++++++-
 drivers/media/video/meye.c         |   21 +++++++++++++++++++++
 drivers/media/video/meye.h         |    2 +-
 3 files changed, 31 insertions(+), 2 deletions(-)


diff -Nru a/Documentation/video4linux/meye.txt b/Documentation/video4linux/meye.txt
--- a/Documentation/video4linux/meye.txt	Wed Apr 17 16:55:08 2002
+++ b/Documentation/video4linux/meye.txt	Wed Apr 17 16:55:08 2002
@@ -15,8 +15,16 @@
 
 MJPEG hardware grabbing is supported via a private API (see below).
 
-Module options:
+Driver options:
 ---------------
+
+Several options can be passed to the meye driver, either by adding them
+to /etc/modules.conf file, when the driver is compiled as a module, or
+by adding the following to the kernel command line (in your bootloader):
+
+	meye=gbuffers[,gbufsize[,video_nr]]
+
+where:
 
 	gbuffers:	number of capture buffers, default is 2 (32 max)
 
diff -Nru a/drivers/media/video/meye.c b/drivers/media/video/meye.c
--- a/drivers/media/video/meye.c	Wed Apr 17 16:55:08 2002
+++ b/drivers/media/video/meye.c	Wed Apr 17 16:55:08 2002
@@ -1420,6 +1420,27 @@
 	pci_unregister_driver(&meye_driver);
 }
 
+#ifndef MODULE
+static int __init meye_setup(char *str) {
+	int ints[4];
+
+	str = get_options(str, ARRAY_SIZE(ints), ints);
+	if (ints[0] <= 0) 
+		goto out;
+	gbuffers = ints[1];
+	if (ints[0] == 1)
+		goto out;
+	gbufsize = ints[2];
+	if (ints[0] == 2)
+		goto out;
+	video_nr = ints[3];
+out:
+	return 1;
+}
+
+__setup("meye=", meye_setup);
+#endif
+
 MODULE_AUTHOR("Stelian Pop <stelian.pop@fr.alcove.com>");
 MODULE_DESCRIPTION("video4linux driver for the MotionEye camera");
 MODULE_LICENSE("GPL");
diff -Nru a/drivers/media/video/meye.h b/drivers/media/video/meye.h
--- a/drivers/media/video/meye.h	Wed Apr 17 16:55:08 2002
+++ b/drivers/media/video/meye.h	Wed Apr 17 16:55:08 2002
@@ -29,7 +29,7 @@
 #define _MEYE_PRIV_H_
 
 #define MEYE_DRIVER_MAJORVERSION	1
-#define MEYE_DRIVER_MINORVERSION	3
+#define MEYE_DRIVER_MINORVERSION	4
 
 /****************************************************************************/
 /* Motion JPEG chip registers                                               */

===================================================================


This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch17009
M'XL(`,R,O3P``\U7;6_;-A#^;/Z*0_,E7AV+I"C95N:A66UT1ILF<)`!7188
MM$1%0F72D.BDZ;3_OI,<-YWC)$Y6#/$+(1_OCG?/\>'1.W!:J#QH%%9EJ=1D
M!WXSA0T:<S-/5='6RJ)H;`R*G,3,E&-3G9J%\UGE6F5.ENK%ESW>]@BJ'4L;
M)G"I\B)HL+;[36*OYRIHC(?O3C\<C`GI]^%M(O6%.E$6^GUB37XILZAX(VV2
M&=VVN=3%3%G9#LVL_*9:<DHYOCW6<:GGE\RGHE.&+&),"J8BRD77%^0FD3>W
M":R[$*S#A/!XKV2,,TH&P-J>ZP+E#A4.ZP#S`T\$0KRF/*`4[GJ$UR[L4?(K
M_-C0WY(0AEI.,P4V43!3UPJB/$5`<2&XP'7G,I?H'A$&HVNE91T`EYM)'0'6
M0[7)>V!4^)0<WP)-]I[X(H1*2G[!);&$F_-;QE8X,Q6ETKE,(V6<*NAV>)MP
MCU&7E8(S3Y2>)V4H12?B?!I2M@'81UW6M?.$ZY?XV'UN?,G=^-R.5T9N''=Z
MO!LJ-Y[ZL?>D`)/U`+GK=;V'`QR8<#%3VDJ;&KUT)FI&+5W:+_9.H+3G>V5W
M.NTJWHF$Z,F.8-&F0+?U_1VB?J_CU_1\W+;B[?^0V`]:`P?7PS6Z/EW2_0[9
M7?\!LO=@C[UDLM=U.X*]_*K^('>/MRCA,TZ$`>L"(Z-Z'"QC-?-J@2)`:0^Z
MY$]RHE`LL]4$A%+#5&$R1:&B*K6U;%N@4A3E,+T&&46IOJ@T9M@5P%$V=&8F
M6F18B=#H&.(T4RVX2M02CQN\TJ*"9(YS$<@")"QM6F!R\B^O$)LL,U?U+W,?
MHK";:K@V"XP(VUYF9*3R9H"9-:JH^Q?311QC3<Y:U5.1?E5GK1K>B<[/SU$-
MH\M54//H_M/L$?[\QY-U4Q/<ZF3%KNB5PL6=6].$\2?QA+,7WA7KEK%&E/MQ
M>09!1DQP#IR1G336D8KA\&AP^F&(]4`>AI!J"Y,)7J!LG<:D4'8QWPT3F<-/
MA<V;\!=I5#KX+<[$^7ZUZ5`._2K-R0VC=E'2@H/Q^.#3Y&3TQW"WTFZV:J/F
M/CJ(H1:=T7/XN0^T":31N#"(E5E8G%]M8/1:J['S-2/<N*QYUZ;:ZBL;OL&&
MK]FL2+&R<=$&9P+2R#'M7`/;)W]CAI,;&%[5]'K5^@X:3&='Z2B-4>U!/B7/
MY=.6-X$G$>K&I\L$\YGOBOHF();7S"?QB;WPOK.\X6S+I^0Y#<?E5<.IQQWD
M4W4\'PX_#2>#\>CWX7AR./IX-,:'D]'1QX:X_0\2)BK\7"QF?=>/?=6+IN0?
(K3)?N>@,````
`
end
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292870AbSDQP4Z>; Wed, 17 Apr 2002 11:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293048AbSDQP4Y>; Wed, 17 Apr 2002 11:56:24 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:58570 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S292870AbSDQP4W>; Wed, 17 Apr 2002 11:56:22 -0400
Date: Wed, 17 Apr 2002 17:56:20 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BKPATCH 2.4] meye driver: get parameters from the kernel command line
Message-ID: <20020417155620.GF1519@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch enables the meye driver to get parameters on the 
kernel command line using a "meye=" style syntax.

Marcelo, please apply.

Stelian.


You can import this changeset into BK by piping this whole message to
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.419, 2002-04-17 16:34:37+02:00, stelian@popies.net
  Enable the meye driver to get parameters on the kernel command line.


 Documentation/video4linux/meye.txt |   10 +++++++++-
 drivers/media/video/meye.c         |   21 +++++++++++++++++++++
 drivers/media/video/meye.h         |    2 +-
 3 files changed, 31 insertions(+), 2 deletions(-)


diff -Nru a/Documentation/video4linux/meye.txt b/Documentation/video4linux/meye.txt
--- a/Documentation/video4linux/meye.txt	Wed Apr 17 16:35:04 2002
+++ b/Documentation/video4linux/meye.txt	Wed Apr 17 16:35:04 2002
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
--- a/drivers/media/video/meye.c	Wed Apr 17 16:35:04 2002
+++ b/drivers/media/video/meye.c	Wed Apr 17 16:35:04 2002
@@ -1415,6 +1415,27 @@
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
--- a/drivers/media/video/meye.h	Wed Apr 17 16:35:04 2002
+++ b/drivers/media/video/meye.h	Wed Apr 17 16:35:04 2002
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


begin 664 bkpatch16247
M'XL(`!F(O3P``\U7;6_;-A#^;/Z*0_,E7AV+I*C7S$.RVNB,-4W@(`.Z+#!H
MB8J$RJ(AR4FS:?]])REN.CLO3E8,\0LA'^^.S]WQX=$[<%:HW.\4I4H3F9$=
M^$47I=]9Z$6BBGZF2A1-M$:1$>NY,LHD2_32^*SR3*5&FF3++WN\+PBJG<@R
MB.%*Y87?87WSJZ2\62B_,QF]/_MP."%D,(!WL<PNU:DJ83`@I<ZO9!H6![*,
M4YWURUQFQ5R5LA_H>?55M>*4<GQ;S#&I95?,IL*I`A8R)@53(>7"M06Y#>3@
M+H!U%X(Y3'!/\$IXCBO($%A?,`\H-Z@PF`/,]DWAF\Y;RGU*8=,CO#5ACY*?
MX?M"?T<"&&5REBHH8P5S=:,@S!-,*"X$E[CN0N82W6.&06>-4EL'P.7F,@L!
MZZ'ZY%<0KJ`6.;E+--E[YHL0*BGY"9?$$MX?7XNM,.8J3*1QE81*&S7H?G`7
ML,>HR2K!F24JRY(RD,().9\%E-V3V"==-K4SA<DKRS&]E^*+-_&9CE6%9A0Y
M'G<#948S.[*>!3!>!\A-R[4>!SC4P7*NLE*6B<Y:9Z)A5.NR_%)N`*6>;57N
M;.8J[H1">-(1++P/Z+:^[P!3VW/LAIY/V]:\_1\"^TYKX&!:N(9K4]K0W=P@
M.W^$[![LL==,]J9NQ["77S<?Y.[)%B5\P8DP9"XP,F[&88M5+^H%"A^E'KCD
M#W*J4"S3U00$,H.9PF"*0H5U:&O1]D`E*,IA=@,R#)/LLM:88U<`0Y6!,=?A
M,L5*!#J+($I2U8/K6+7YN,U74M0I6>!<"+(`":U-#W1._N45(IVF^KKYI1_*
M*.PF&=SH)2+"MI=J&:J\ZV-DG1KUX'*VC"*LR7FO?BJ2/]5YKTGO-,LO+E`-
MT>7*;WCT\&GV!'_^X\EZ7Q/<ZF3EGNE4)G6%T]!DLR<^1A/.7GE3;%O&&E$>
MSLL+"#)FF$;@C.PD41:J"(Z.AV<?1E@/Y&$`25;"=(H7J+*)8UJH<KG8#6*9
MPP]%F7?A+]*I=?!;G(N+_7K3H1P&=9S36T;MHJ0'AY/)X:?IZ?CWT6ZMW>TU
M1MU]=!!!(SJG%_#C`&@72*=SJ3%9>EGB_&H#H]=&C5VL&>'&9=U-FWJKKVSX
M/39\S69%BI6-B38XXY-.CF'G&;!]\C=&.+U-PYN&7F]ZWZ0&P]E169A$J/8H
MG^*7\FG+F\"*4'W<[P=1WI=IH*_45JY-=,R%0]L+07O;M)[%*_;*VT][T=F6
M5O%+^H[)Z[[3C#M(J_J4/AI]&DV'D_%OH\GT:/SQ>((/I^/CCYUO_HH$L0H^
4%\OY(+)=2P6V)/\`:FHA0.\,````
`
end
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com

Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315083AbSD2LBw>; Mon, 29 Apr 2002 07:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315087AbSD2LBv>; Mon, 29 Apr 2002 07:01:51 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:12416 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S315083AbSD2LBt>; Mon, 29 Apr 2002 07:01:49 -0400
Date: Mon, 29 Apr 2002 13:01:36 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BKPATCH 2.4.19-pre7] minor sonypi driver update
Message-ID: <20020429110136.GH2740@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This minor patch enables several processes to open the sonypi device
at the same time. This is useful for example when one process polls
for events while a second one is used to control the screen 
brightness...

Marcelo, please apply.

Thanks.

Stelian.

You can import this changeset into BK by piping this whole message to
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.459, 2002-04-29 12:43:03+02:00, stelian@popies.net
  Allow multiple processes to open the sonypi device


 sonypi.c |   13 +++++++------
 sonypi.h |    2 +-
 2 files changed, 8 insertions(+), 7 deletions(-)


diff -Nru a/drivers/char/sonypi.c b/drivers/char/sonypi.c
--- a/drivers/char/sonypi.c	Mon Apr 29 12:44:53 2002
+++ b/drivers/char/sonypi.c	Mon Apr 29 12:44:53 2002
@@ -485,12 +485,10 @@
 
 static int sonypi_misc_open(struct inode * inode, struct file * file) {
 	down(&sonypi_device.lock);
-	if (sonypi_device.open_count)
-		goto out;
+	/* Flush input queue on first open */
+	if (!sonypi_device.open_count)
+		sonypi_initq();
 	sonypi_device.open_count++;
-	/* Flush input queue */
-	sonypi_initq();
-out:
 	up(&sonypi_device.lock);
 	return 0;
 }
@@ -718,9 +716,12 @@
 	       SONYPI_DRIVER_MAJORVERSION,
 	       SONYPI_DRIVER_MINORVERSION);
 	printk(KERN_INFO "sonypi: detected %s model, "
-	       "camera = %s, compat = %s, nojogdial = %s\n",
+	       "verbose = %s, fnkeyinit = %s, camera = %s, "
+	       "compat = %s, nojogdial = %s\n",
 	       (sonypi_device.model == SONYPI_DEVICE_MODEL_TYPE1) ?
 			"type1" : "type2",
+	       verbose ? "on" : "off",
+	       fnkeyinit ? "on" : "off",
 	       camera ? "on" : "off",
 	       compat ? "on" : "off",
 	       nojogdial ? "on" : "off");
diff -Nru a/drivers/char/sonypi.h b/drivers/char/sonypi.h
--- a/drivers/char/sonypi.h	Mon Apr 29 12:44:53 2002
+++ b/drivers/char/sonypi.h	Mon Apr 29 12:44:53 2002
@@ -35,7 +35,7 @@
 #ifdef __KERNEL__
 
 #define SONYPI_DRIVER_MAJORVERSION	 1
-#define SONYPI_DRIVER_MINORVERSION	12
+#define SONYPI_DRIVER_MINORVERSION	13
 
 #include <linux/types.h>
 #include <linux/pci.h>

===================================================================


This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch3343
M'XL(`"4DS3P``\V5ZV[3,!2`?\=/<>B$Q"YM?$N<!!4&;$`%;%6G(2$A32%U
MEK#4#HFS,2D/C],6"J-,W0023A3;QY=S^^QLP6DMJ\BIC2SR6*$M>*UK$SFE
M+G-9#Y0T5C31VHK<3,^D:W*5Z\:]D)62A5ODJOG:IP..[+1Q;)(,+F551PX9
ML!\2<UW*R)D<OCI]^VR"T'`(+[)8G<L3:6`X1$97EW$QK?=CDQ5:#4P5JWHF
M33Q(]*S],;6E&%/[>$0P[/DM\3$7;4*FA,2<R"FF//`Y.J_D^?Y%I>-LW7).
M&>T:8<M8X'OH`,B`>R%@ZF+NTA`(C3B+,-O%-,(8EF'97X4#=BGT,7H.?]?L
M%RB!9T6AKV#6%"8O"PEEI1-9U[*VJD"74H'))-1:79<Y3.5EGDCT!JP?08#&
MJY"B_AT+0CC&Z`F47;+6>S.M\BZM;I+%E;NP8)"L/`L)9J3E1'"_91Y.`R$"
MCGD0))Z_)H2W;<=IMUG(1$N)YX=W-RO[W:P@%"WSDY`+GE(A4I],Q:9F93?-
MXMP7P1SBM5YT0/^;0*([!I((8I=ZM"7<9V)..L&_@,["B(E;0!?0]_\?T!<\
M'$._NIJ_%MSQ^AS<XP0<V!@#12,>A,"0X^[`RZ*I,\A5V1CXTLA&@E:0YE5M
M%B;NN,C)4WCT8*'U;&'GH!L[2W2CS#9RG.68O3+-ET?;CZV:D-C]#P0E0-"H
MJRAR8%%ZUI-/NI8PA(?U'J3J0EYW*Y?]))[)*EYV>JM5-@D6N*5<Z<_Z?)K'
MQ;S_4?7V.BWL)RW?E3R%GE8]B&R5IG;:]_&5VILS_L1\=@_F-SREFS*?W62^
M.Z7W8IY`G_P_S"\NFPV8S^[#/`LZ".??K:E,<R7AY/CHPWAT=C`9O3^<G+T;
D'1U/;.-D='SD$+;ZQR>93"[J9C9D-F->0##Z!@EPA?Y("```
`
end
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com

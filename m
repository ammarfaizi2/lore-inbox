Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312997AbSDJMhI>; Wed, 10 Apr 2002 08:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312883AbSDJMgX>; Wed, 10 Apr 2002 08:36:23 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:4108 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S312996AbSDJMfY>; Wed, 10 Apr 2002 08:35:24 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 10 Apr 2002 13:10:33 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@transmeta.com>,
        Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] meye v4l video driver fix
Message-ID: <20020410131033.A26486@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch adapts the meye videodev driver to the -pre1 videodev fixes.

  Gerd

PS: For "bk receive" the video drivers patch sent earlier must be
    applied first.  "bk import" shouldn't care ...

==============================[ cut here ]==============================
# ChangeSet
#   1.587 02/04/08 10:14:01 kraxel@bytesex.org +1 -0
#   adapt meye v4l driver to 2.5.8-pre1 videodev fixes.
# 
#   drivers/media/video/meye.c
#     1.10 02/03/19 18:24:39 kraxel@bytesex.org +9 -4
#     adapt meye v4l driver to 2.5.8-pre1 videodev fixes.
# 
======================================================================
diff -Nru a/drivers/media/video/meye.c b/drivers/media/video/meye.c
--- a/drivers/media/video/meye.c	Mon Apr  8 10:18:35 2002
+++ b/drivers/media/video/meye.c	Mon Apr  8 10:18:35 2002
@@ -893,8 +893,8 @@
 	return 0;
 }
 
-static int meye_ioctl(struct inode *inode, struct file *file,
-		      unsigned int cmd, void *arg) {
+static int meye_do_ioctl(struct inode *inode, struct file *file,
+			 unsigned int cmd, void *arg) {
 
 	switch (cmd) {
 
@@ -1169,6 +1169,12 @@
 	return 0;
 }
 
+static int meye_ioctl(struct inode *inode, struct file *file,
+		     unsigned int cmd, unsigned long arg)
+{
+	return video_usercopy(inode, file, cmd, arg, meye_do_ioctl);
+}
+
 static int meye_mmap(struct file *file, struct vm_area_struct *vma) {
 	unsigned long start = vma->vm_start;
 	unsigned long size  = vma->vm_end - vma->vm_start;
@@ -1209,7 +1215,7 @@
 	open:		meye_open,
 	release:	meye_release,
 	mmap:		meye_mmap,
-	ioctl:		video_generic_ioctl,
+	ioctl:		meye_ioctl,
 	llseek:		no_llseek,
 };
 
@@ -1219,7 +1225,6 @@
 	type:		VID_TYPE_CAPTURE,
 	hardware:	VID_HARDWARE_MEYE,
 	fops:		&meye_fops,
-	kernel_ioctl:	meye_ioctl,
 };
 
 static int __devinit meye_probe(struct pci_dev *pcidev, 
======================================================================
This BitKeeper patch contains the following changesets:
1.587
## Wrapped with gzip_uu ##


begin 664 bkpatch4904
M'XL(`%M2L3P``\U4;6O;,!#^;/V*@W[I2V+K9/EU9'1KNZULL-+1;X.BR&IB
MXEA!5M*&>O]]LE/2;6U7.C:89"RX.]T]]]R#=N"B42;W9D;<J(KLP`?=V-P;
MKZUJU(VOS<39SK5VMN!:FUDPG@7,CX*K\F:X*@NEB?.?"2NGL%*FR3WTPZW%
MKA<J]\Y/WE]\>G-.R&@$1U-13]0796$T(E:;E:B*YE#8::5KWQI1-W-EA2_U
MO-V&MHQ2YG:$24BCN,68\J256"`*CJJ@C*<Q)YL.#G]`_FL*3E.W(YJU/(NB
MF!P#^E&:`&4!Y0%-`6F./*=X0%E.*3S,"`<(0TK>PM^%?D0DB$(L+,S56L&*
M5U"8TO'IZH!CVT^'"Z,0>L(+M0+'OFI\\A%<(PF2LWM>R?"%BQ`J*'D-BVYB
MC[>SP=($<U64(NA!!!U07][WER$-L>4,(]Y&D1!2\*1@;"PI/L+CLRG[46'(
MPY:'CKM>.T_?Z<3T[_"3QJJJ%/7A0B]*1WOMYOI<RA`YQAB'O`V1\:27&M)>
M:6&`&6":,YZ'V0'%IY26P9#_-TI[!QAG/..\TUP_D<\P--?]YS1T]IOA_($B
MC],L!D9.TRQQ1V.%+264]0;T9:$O2RUMM=M8LY36.1Q2V.^/`=P9K\K*V;K_
M@'B>!\NZ*2>U*OHT<EX,8*7+`O:%F>S!+3E%3!#B![5>6@BZ];#6UN(F.(&N
M)KDEGE%V:>H-UY=+]PQ+O5COWJ7O,VYNN_C!SZWOO2+?R%=RC`P9H$._.;W>
DF7O>/?9!%\0ZY_95EE,E9\UR/DJ83,;Q54*^`Z*_K$(%!@``
`
end

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbVJOTQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbVJOTQW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 15:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbVJOTQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 15:16:22 -0400
Received: from ms-smtp-02-smtplb.rdc-nyc.rr.com ([24.29.109.6]:57536 "EHLO
	ms-smtp-02.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S1751202AbVJOTQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 15:16:21 -0400
Subject: [PATCH / 2.6.13.4] fix vpx3220 offset issue in SECAM
From: "Ronald S. Bultje" <rbultje@ronald.bitfreak.net>
To: akpm@osdl.org
Cc: casteyde.christian@free.fr, linux-kernel@vger.kernel.org,
       mjpeg-developer@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="=-fXMU64i5kGwotm3EApZM"
Date: Sat, 15 Oct 2005 15:18:14 -0400
Message-Id: <1129403894.2684.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fXMU64i5kGwotm3EApZM
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

attached patch fixes bug #5404 in kernel bugzilla; it basically updates
the vpx3220 initialization tables with some newer values that we've had
in CVS for a while (and that, for some reason, never ended up in the
kernel... must've gotten lost). Those fix a ~16 pixels noise at the top
of the picture in at least SECAM, although (now that I think about it)
PAL was probably affected, also.

Same as previous patch, it's against 2.6.13.4 because I can't find a
full 2.6.14-current tarball to generate it against. Should apply just
fine.

Signed-off-by: Ronald S. Bultje <rbultje@ronald.bitfreak.net>

Cheers,
Ronald

--=-fXMU64i5kGwotm3EApZM
Content-Disposition: attachment; filename=vpx3220-fix-offset.patch
Content-Type: text/x-patch; name=vpx3220-fix-offset.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.13.4/drivers/media/video/vpx3220-old.c	2005-10-10 14:54:29.000000000 -0400
+++ linux-2.6.13.4/drivers/media/video/vpx3220.c	2005-10-15 13:24:53.000000000 -0400
@@ -203,7 +203,7 @@
 	0x8c, 640,		/* Horizontal length */
 	0x8d, 640,		/* Number of pixels */
 	0x8f, 0xc00,		/* Disable window 2 */
-	0xf0, 0x173,		/* 13.5 MHz transport, Forced
+	0xf0, 0x73,		/* 13.5 MHz transport, Forced
 				 * mode, latch windows */
 	0xf2, 0x13,		/* NTSC M, composite input */
 	0xe7, 0x1e1,		/* Enable vertical standard
@@ -212,38 +212,36 @@
 
 static const unsigned short init_pal[] = {
 	0x88, 23,		/* Window 1 vertical begin */
-	0x89, 288 + 16,		/* Vertical lines in (16 lines
+	0x89, 288,		/* Vertical lines in (16 lines
 				 * skipped by the VFE) */
-	0x8a, 288 + 16,		/* Vertical lines out (16 lines
+	0x8a, 288,		/* Vertical lines out (16 lines
 				 * skipped by the VFE) */
 	0x8b, 16,		/* Horizontal begin */
 	0x8c, 768,		/* Horizontal length */
 	0x8d, 784, 		/* Number of pixels
 				 * Must be >= Horizontal begin + Horizontal length */
 	0x8f, 0xc00,		/* Disable window 2 */
-	0xf0, 0x177,		/* 13.5 MHz transport, Forced
+	0xf0, 0x77,		/* 13.5 MHz transport, Forced
 				 * mode, latch windows */
 	0xf2, 0x3d1,		/* PAL B,G,H,I, composite input */
-	0xe7, 0x261,		/* PAL/SECAM set to 288 + 16 lines 
-				 * change to 0x241 for 288 lines */
+	0xe7, 0x241,		/* PAL/SECAM set to 288 lines */
 };
 
 static const unsigned short init_secam[] = {
-	0x88, 23  - 16,		/* Window 1 vertical begin */
-	0x89, 288 + 16,		/* Vertical lines in (16 lines
+	0x88, 23,		/* Window 1 vertical begin */
+	0x89, 288,		/* Vertical lines in (16 lines
 				 * skipped by the VFE) */
-	0x8a, 288 + 16,		/* Vertical lines out (16 lines
+	0x8a, 288,		/* Vertical lines out (16 lines
 				 * skipped by the VFE) */
 	0x8b, 16,		/* Horizontal begin */
 	0x8c, 768,		/* Horizontal length */
 	0x8d, 784,		/* Number of pixels
 				 * Must be >= Horizontal begin + Horizontal length */
 	0x8f, 0xc00,		/* Disable window 2 */
-	0xf0, 0x177,		/* 13.5 MHz transport, Forced
+	0xf0, 0x77,		/* 13.5 MHz transport, Forced
 				 * mode, latch windows */
 	0xf2, 0x3d5,		/* SECAM, composite input */
-	0xe7, 0x261,		/* PAL/SECAM set to 288 + 16 lines 
-				 * change to 0x241 for 288 lines */
+	0xe7, 0x241,		/* PAL/SECAM set to 288 lines */
 };
 
 static const unsigned char init_common[] = {

--=-fXMU64i5kGwotm3EApZM--


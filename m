Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262804AbTI2F2U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 01:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262808AbTI2F2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 01:28:20 -0400
Received: from mail007.syd.optusnet.com.au ([211.29.132.55]:985 "EHLO
	mail007.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262804AbTI2F2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 01:28:19 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16247.49897.60412.898864@wombat.chubb.wattle.id.au>
Date: Mon, 29 Sep 2003 15:28:09 +1000
To: petero2@telia.com, linux-kernel@vger.kernel.org
Subject: Linux-2.6.0-test6: synaptics upside down? 
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi folks,
   On the latest 2.6.0-test6 kernel, the synaptics touchpad on my
Clevo is upside down -- moving my finger up moves the pointer down,
et vice versa.

This patch fixed the problem for me, but is probably not the right
fix.

===== drivers/input/mouse/synaptics.c 1.9 vs edited =====
--- 1.9/drivers/input/mouse/synaptics.c	Fri Sep 26 16:58:04 2003
+++ edited/drivers/input/mouse/synaptics.c	Mon Sep 29 15:18:53 2003
@@ -529,7 +529,11 @@
 	/* Post events */
 	if (hw.z > 0) {
 		input_report_abs(dev, ABS_X, hw.x);
+#if 0
 		input_report_abs(dev, ABS_Y, YMAX_NOMINAL + YMIN_NOMINAL - hw.y);
+#else
+		input_report_abs(dev, ABS_Y, hw.y);
+#endif
 	}
 	input_report_abs(dev, ABS_PRESSURE, hw.z);
 

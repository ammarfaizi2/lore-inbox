Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261778AbTI3Xbv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 19:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbTI3Xbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 19:31:51 -0400
Received: from mail008.syd.optusnet.com.au ([211.29.132.212]:8611 "EHLO
	mail008.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261778AbTI3Xbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 19:31:49 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16250.4701.976132.141380@wombat.chubb.wattle.id.au>
Date: Wed, 1 Oct 2003 09:31:41 +1000
To: Henrik Christian Grove <grove@sslug.dk>
Cc: linux-kernel@vger.kernel.org, ajoshi@shell.unixbox.com
Subject: Radeon framebuffer problems i 2.6.0-test6
In-Reply-To: <7gisna11e1.fsf@serena.fsr.ku.dk>
References: <7gisna11e1.fsf@serena.fsr.ku.dk>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Try this patch that's been floating around for a while.

Ani, can you please push this patch to Linus?  It fixes the Radeon
problems for a lot of people.


===== drivers/video/radeonfb.c 1.30 vs edited =====
--- 1.30/drivers/video/radeonfb.c	Fri Aug  1 01:58:45 2003
+++ edited/drivers/video/radeonfb.c	Tue Sep  9 13:18:36 2003
@@ -2090,7 +2090,7 @@
 	
 	}
 	/* Update fix */
-        info->fix.line_length = rinfo->pitch*64;
+        info->fix.line_length = mode->xres_virtual*(mode->bits_per_pixel/8);
         info->fix.visual = rinfo->depth == 8 ? FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_DIRECTCOLOR;
 
 #ifdef CONFIG_BOOTX_TEXT

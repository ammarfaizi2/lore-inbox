Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292734AbSBZTkD>; Tue, 26 Feb 2002 14:40:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292739AbSBZTjx>; Tue, 26 Feb 2002 14:39:53 -0500
Received: from CompactServ-SUrNet.ll.surnet.ru ([195.54.9.58]:16370 "EHLO
	zzz.zzz") by vger.kernel.org with ESMTP id <S292734AbSBZTjl>;
	Tue, 26 Feb 2002 14:39:41 -0500
Date: Wed, 27 Feb 2002 00:26:02 +0500
From: Denis Zaitsev <zzz@cd-club.ru>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] matroxfb_base.c - a little fix
Message-ID: <20020227002602.A16317@natasha.zzz.zzz>
In-Reply-To: <20020204060107.A18956@zzz.zzz.zzz> <20020204010854.GC2572@ppc.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020204010854.GC2572@ppc.vc.cvut.cz>; from vandrove@vc.cvut.cz on Mon, Feb 04, 2002 at 02:08:54AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It was two identical if-else branches in matroxfb_decode_var - one for
        var->bits_per_pixel == 4
and the other for
        var->bits_per_pixel <= 8
.  So, I've removed 4's one.  It should be ok, if this branch was ok -
i.e. was intentionally made the same as the 8bpp's.  So, Petr, please,
apply this fix, if all ok.


--- drivers/video/matrox/matroxfb_base.c.orig	Mon Feb 25 21:38:33 2002
+++ drivers/video/matrox/matroxfb_base.c	Tue Feb 26 16:38:33 2002
@@ -494,16 +494,6 @@ static int matroxfb_decode_var(CPMINFO s
 		var->transp.offset = 0;
 		var->transp.length = 0;
 		*visual = MX_VISUAL_PSEUDOCOLOR;
-	} else if (var->bits_per_pixel == 4) {
-		var->red.offset = 0;
-		var->red.length = 8;
-		var->green.offset = 0;
-		var->green.length = 8;
-		var->blue.offset = 0;
-		var->blue.length = 8;
-		var->transp.offset = 0;
-		var->transp.length = 0;
-		*visual = MX_VISUAL_PSEUDOCOLOR;
 	} else if (var->bits_per_pixel <= 8) {
 		var->red.offset = 0;
 		var->red.length = 8;

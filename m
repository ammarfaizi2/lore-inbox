Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317368AbSFHANT>; Fri, 7 Jun 2002 20:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317370AbSFHANT>; Fri, 7 Jun 2002 20:13:19 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:6528 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S317368AbSFHANS>;
	Fri, 7 Jun 2002 20:13:18 -0400
Date: Sat, 8 Jun 2002 02:12:56 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: [PATCH] matroxfb dies when you try to use secondary head in 2.5.x
Message-ID: <20020608001256.GA5090@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
   please apply this to 2.5.20. James introduced bad bug which
causes NULL pointer dereference as soon as you'll try to use
secondary head because of screen_base is not initialized
(it is initialized on wrong head).
				Thanks,
					Petr Vandrovec
					vandrove@vc.cvut.cz


diff -urdN linux/drivers/video/matrox/matroxfb_crtc2.c linux/drivers/video/matrox/matroxfb_crtc2.c
--- linux/drivers/video/matrox/matroxfb_crtc2.c	Mon Jun  3 01:44:45 2002
+++ linux/drivers/video/matrox/matroxfb_crtc2.c	Fri Jun  7 23:03:07 2002
@@ -383,7 +383,7 @@
 		chgvar = 0;
 	p->var = *var;
 	/* cmap */
-	ACCESS_FBINFO(fbcon.screen_base) = vaddr_va(m2info->video.vbase);
+	m2info->fbcon.screen_base = vaddr_va(m2info->video.vbase);
 	p->visual = visual;
 	p->ypanstep = 1;
 	p->ywrapstep = 0;

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264264AbTEOWg0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 18:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264274AbTEOWg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 18:36:26 -0400
Received: from pc-80-195-159-32-du.blueyonder.co.uk ([80.195.159.32]:6528 "EHLO
	skymoo.dyndns.org") by vger.kernel.org with ESMTP id S264264AbTEOWgZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 18:36:25 -0400
Date: Thu, 15 May 2003 23:49:10 +0100
From: Adam Mercer <r.a.mercer@blueyonder.co.uk>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix vesafb with large memory, this time properly
Message-ID: <20030515224910.GA8375@skymoo.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Marcelo

Thanks for apply my previous patch, but Geert Uytterhoeven noticed the
following problem with it

> video_size must be in bytes, hence it must be
> 
> video_size = screen_info.lfb_width*screen_info.lfb_height*video_bpp/8;

The attached patch, against 2.4.21-rc2, fixes this

Cheers

Adam

--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.4.21-rc2-vesafb.patch"

diff -urN linux-2.4.21-rc2/drivers/video/vesafb.c linux-2.4.21-rc2-patched/drivers/video/vesafb.c
--- linux-2.4.21-rc2/drivers/video/vesafb.c	2003-05-15 07:42:55.000000000 +0100
+++ linux-2.4.21-rc2-patched/drivers/video/vesafb.c	2003-05-15 07:39:53.000000000 +0100
@@ -520,7 +520,7 @@
 	video_width         = screen_info.lfb_width;
 	video_height        = screen_info.lfb_height;
 	video_linelength    = screen_info.lfb_linelength;
-	video_size          = screen_info.lfb_width *	screen_info.lfb_height * video_bpp;
+	video_size          = screen_info.lfb_width *	screen_info.lfb_height * video_bpp / 8;
 	video_visual = (video_bpp == 8) ?
 		FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_TRUECOLOR;
 

--PNTmBPCT7hxwcZjr--

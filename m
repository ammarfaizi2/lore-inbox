Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750849AbWDRXuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbWDRXuk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 19:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851AbWDRXuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 19:50:40 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:64266 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750840AbWDRXuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 19:50:39 -0400
Date: Wed, 19 Apr 2006 01:50:38 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net,
       Darren Jenkins <darrenrjenkins@gmail.com>, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fix section mismatch in pm2fb.o
Message-ID: <20060418235038.GC11582@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Darren Jenkins <darrenrjenkins@gmail.com>

There are a couple of Section mismatch problems in drivers/video/pm2fb.o

WARNING: drivers/video/pm2fb.o - Section mismatch: reference
to .init.data: from .text after 'pm2fb_set_par' (at offset 0xd5d)
WARNING: drivers/video/pm2fb.o - Section mismatch: reference
to .init.data: from .text after 'pm2fb_set_par' (at offset 0xd82)

They are caused because pm2fb_set_par() uses lowhsync and lowvsync which
are marked __devinitdata.

This patch simply removes the __devinitdata annotations.

Signed-off-by: Darren Jenkins <darrenrjenkins@gmail.com>
Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 9 Apr 2006

--- 2.6.16-git20/drivers/video/pm2fb.c.orig	2006-04-03 19:08:51.000000000 +1000
+++ 2.6.16-git20/drivers/video/pm2fb.c	2006-04-03 19:09:34.000000000 +1000
@@ -73,8 +73,8 @@ static char *mode __devinitdata = NULL;
  * these flags allow the user to specify that requests for +ve sync
  * should be silently turned in -ve sync.
  */
-static int lowhsync __devinitdata = 0;
-static int lowvsync __devinitdata = 0;
+static int lowhsync = 0;
+static int lowvsync = 0;
 
 /*
  * The hardware state of the graphics card that isn't part of the



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030729AbWKORna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030729AbWKORna (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 12:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030640AbWKORna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 12:43:30 -0500
Received: from posti6.jyu.fi ([130.234.4.43]:29409 "EHLO posti6.jyu.fi")
	by vger.kernel.org with ESMTP id S1030766AbWKORn3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 12:43:29 -0500
Date: Wed, 15 Nov 2006 19:43:16 +0200 (EET)
From: Tero Roponen <teanropo@jyu.fi>
X-X-Sender: teanropo@jalava.cc.jyu.fi
To: linux-kernel@vger.kernel.org
cc: akpm@osdl.org
Subject: [PATCH -mm] fb: modedb uses wrong default_mode
Message-ID: <Pine.LNX.4.64.0611151933070.12799@jalava.cc.jyu.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It seems that default_mode is always overwritten in
fb_find_mode() if caller gives its own modedb; this
patch should fix it.

dmesg diff before and after the following patch:

 neofb: mapped framebuffer at c4a80000
 -Mode (640x400) won't display properly on LCD
 -Mode (640x400) won't display properly on LCD
 -neofb v0.4.2: 2048kB VRAM, using 640x480, 31.469kHz, 59Hz
 -Console: switching to colour frame buffer device 80x30
 +neofb v0.4.2: 2048kB VRAM, using 800x600, 37.878kHz, 60Hz
 +Console: switching to colour frame buffer device 100x37
  fb0: MagicGraph 128XD frame buffer device

Signed-off-by: Tero Roponen <teanropo@jyu.fi>
---

--- linux-2.6.19-rc5-mm2/drivers/video/modedb.c.orig	2006-11-15 19:03:03.000000000 +0200
+++ linux-2.6.19-rc5-mm2/drivers/video/modedb.c	2006-11-15 19:02:57.000000000 +0200
@@ -507,7 +507,7 @@ int fb_find_mode(struct fb_var_screeninf
     }
     if (!default_mode && db != modedb)
 	default_mode = &db[0];
-    else
+    else if (!default_mode)
 	default_mode = &modedb[DEFAULT_MODEDB_INDEX];
 
     if (!default_bpp)

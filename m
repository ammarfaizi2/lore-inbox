Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265141AbUF1TcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265141AbUF1TcP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 15:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265135AbUF1TcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 15:32:15 -0400
Received: from cantor.suse.de ([195.135.220.2]:35482 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265181AbUF1Ta2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 15:30:28 -0400
Date: Mon, 28 Jun 2004 21:30:18 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       jsimmons@infradead.org
Subject: [PATCH] signed bug in drivers/video/console/fbcon.c con2fb_map[]
Message-ID: <20040628193018.GA648@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


drivers/video/console/fbcon.c:310: warning: comparison is always true due to limited range of data type

char can be either signed or unsigned, depending on the target system.
patch is against 2.6.7-bk11


--- drivers/video/console/fbcon.c
+++ drivers/video/console/fbcon.c	2004/06/28 19:22:45
@@ -101,7 +101,7 @@
 #endif
 
 struct display fb_display[MAX_NR_CONSOLES];
-char con2fb_map[MAX_NR_CONSOLES];
+signed char con2fb_map[MAX_NR_CONSOLES];
 static int logo_height;
 static int logo_lines;
 static int logo_shown = -1;
--- drivers/video/console/fbcon.h
+++ drivers/video/console/fbcon.h	2004/06/28 19:23:06
@@ -36,7 +36,7 @@
 };
 
 /* drivers/video/console/fbcon.c */
-extern char con2fb_map[MAX_NR_CONSOLES];
+extern signed char con2fb_map[MAX_NR_CONSOLES];
 extern int set_con2fb_map(int unit, int newidx);
 
     /*
-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG

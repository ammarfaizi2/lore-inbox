Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287990AbSACAB6>; Wed, 2 Jan 2002 19:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288068AbSACAAx>; Wed, 2 Jan 2002 19:00:53 -0500
Received: from www.transvirtual.com ([206.14.214.140]:29203 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S288063AbSACAAU>; Wed, 2 Jan 2002 19:00:20 -0500
Date: Wed, 2 Jan 2002 15:59:41 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] pre6 tty_io.c and devfs broken
Message-ID: <Pine.LNX.4.10.10201021558370.9689-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If you have devfs on tty_io.c doesn't compile. This patch fixes this
problem.

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'_   _/`\
 ___)=(___/

--- /usr/src/linux-2.5.2-pre6/drivers/char/tty_io.c	Wed Jan  2 14:07:54 2002
+++ tty_io.c	Wed Jan  2 16:53:20 2002
@@ -2006,15 +2006,11 @@
 	int idx = minor - driver->minor_start;
 	char buf[32];
 
-	switch (device) {
-		case TTY_DEV:
-		case PTMX_DEV:
+	if (IS_TTY_DEV(device) || IS_PTMX_DEV(device)) 
+		mode |= S_IRGRP | S_IWGRP | S_IROTH | S_IWOTH;
+	else {
+		if (driver->major == PTY_MASTER_MAJOR)
 			mode |= S_IRGRP | S_IWGRP | S_IROTH | S_IWOTH;
-			break;
-		default:
-			if (driver->major == PTY_MASTER_MAJOR)
-				mode |= S_IRGRP | S_IWGRP | S_IROTH | S_IWOTH;
-			break;
 	}
 	if ( (minor <  driver->minor_start) || 
 	     (minor >= driver->minor_start + driver->num) ) {


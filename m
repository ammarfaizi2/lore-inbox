Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313190AbSGUThZ>; Sun, 21 Jul 2002 15:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313202AbSGUThZ>; Sun, 21 Jul 2002 15:37:25 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:24849 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313190AbSGUThX>; Sun, 21 Jul 2002 15:37:23 -0400
Subject: PATCH: 2.5.27 fix abusers of set_bit
To: torvalds@transmeta.com, davej@suse.de, linux-kernel@vger.kernel.org
Date: Sun, 21 Jul 2002 21:04:41 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17WMwb-0007Xg-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neither epca nor specialix actually -care- what the event flag size is so
switching to unsigned long makes life happy and maybe makes it work 64bit
bigendian.

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.27/drivers/char/epca.h linux-2.5.27-ac1/drivers/char/epca.h
--- linux-2.5.27/drivers/char/epca.h	Sat Jul 20 20:11:23 2002
+++ linux-2.5.27-ac1/drivers/char/epca.h	Sun Jul 21 15:31:27 2002
@@ -121,7 +121,7 @@
 	int    close_delay;
 	int    count;
 	int    blocked_open;
-	int    event;
+	ulong  event;
 	int    asyncflags;
 	uint   dev;
 	long   session;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.27/drivers/char/specialix_io8.h linux-2.5.27-ac1/drivers/char/specialix_io8.h
--- linux-2.5.27/drivers/char/specialix_io8.h	Sat Jul 20 20:11:04 2002
+++ linux-2.5.27-ac1/drivers/char/specialix_io8.h	Sun Jul 21 15:35:45 2002
@@ -110,7 +110,7 @@
 	struct tty_struct 	* tty;
 	int			count;
 	int			blocked_open;
-	int			event;
+	ulong			event;
 	int			timeout;
 	int			close_delay;
 	long			session;

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263795AbTI2RH1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 13:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263810AbTI2RHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 13:07:01 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:26807 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S263795AbTI2RE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 13:04:56 -0400
To: torvalds@osdl.org
From: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove unnecessary checks in pcmcia
Message-Id: <E1A41Rq-0000NP-00@hardwired>
Date: Mon, 29 Sep 2003 18:04:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

io->stop/start are 16 bits, so will never be >0xffff

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/pcmcia/i82092.c linux-2.5/drivers/pcmcia/i82092.c
--- bk-linus/drivers/pcmcia/i82092.c	2003-09-13 14:44:55.000000000 +0100
+++ linux-2.5/drivers/pcmcia/i82092.c	2003-09-13 16:20:24.000000000 +0100
@@ -675,7 +675,7 @@ static int i82092aa_set_io_map(struct pc
 		leave("i82092aa_set_io_map with invalid map");
 		return -EINVAL;
 	}
-	if ((io->start > 0xffff) || (io->stop > 0xffff) || (io->stop < io->start)){
+	if (io->stop < io->start) {
 		leave("i82092aa_set_io_map with invalid io");
 		return -EINVAL;
 	}

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/pcmcia/i82365.c linux-2.5/drivers/pcmcia/i82365.c
--- bk-linus/drivers/pcmcia/i82365.c	2003-09-11 21:18:34.000000000 +0100
+++ linux-2.5/drivers/pcmcia/i82365.c	2003-09-12 15:37:05.000000000 +0100
@@ -1143,8 +1143,8 @@ static int i365_set_io_map(u_short sock,
 	  "%#4.4x-%#4.4x)\n", sock, io->map, io->flags,
 	  io->speed, io->start, io->stop);
     map = io->map;
-    if ((map > 1) || (io->start > 0xffff) || (io->stop > 0xffff) ||
-	(io->stop < io->start)) return -EINVAL;
+    if ((map > 1) || (io->stop < io->start))
+	return -EINVAL;
     /* Turn off the window before changing anything */
     if (i365_get(sock, I365_ADDRWIN) & I365_ENA_IO(map))
 	i365_bclr(sock, I365_ADDRWIN, I365_ENA_IO(map));

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/pcmcia/tcic.c linux-2.5/drivers/pcmcia/tcic.c
--- bk-linus/drivers/pcmcia/tcic.c	2003-09-11 21:18:34.000000000 +0100
+++ linux-2.5/drivers/pcmcia/tcic.c	2003-09-12 15:37:05.000000000 +0100
@@ -786,8 +786,8 @@ static int tcic_set_io_map(struct pcmcia
     DEBUG(1, "tcic: SetIOMap(%d, %d, %#2.2x, %d ns, "
 	  "%#4.4x-%#4.4x)\n", lsock, io->map, io->flags,
 	  io->speed, io->start, io->stop);
-    if ((io->map > 1) || (io->start > 0xffff) || (io->stop > 0xffff) ||
-	(io->stop < io->start)) return -EINVAL;
+    if ((io->map > 1) || (io->stop < io->start))
+		return -EINVAL;
     tcic_setw(TCIC_ADDR+2, TCIC_ADR2_INDREG | (psock << TCIC_SS_SHFT));
     addr = TCIC_IWIN(psock, io->map);
 

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266387AbSLJATH>; Mon, 9 Dec 2002 19:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266406AbSLJATH>; Mon, 9 Dec 2002 19:19:07 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:24466 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S266387AbSLJATG>; Mon, 9 Dec 2002 19:19:06 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.4.21-BK] Missing bits for new IDE from -AC
Date: Tue, 10 Dec 2002 01:26:21 +0100
User-Agent: KMail/1.4.3
Organization: WOLK - Working Overloaded Linux Kernel
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
MIME-Version: 1.0
Message-Id: <200212100125.00509.m.c.p@wolk-project.de>
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_XVNV17JCQBBXMN8ETUS7"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_XVNV17JCQBBXMN8ETUS7
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Marcelo,

again a missing bit for $subject to fix this at reboot(8)/halt(8) time:

- flushing ide devices: hda hdb ... hd$foo

=2E.. in an endless loop.

Taken, by advice from Alan, out of latest -ac :)


ciao, Marc
--------------Boundary-00=_XVNV17JCQBBXMN8ETUS7
Content-Type: text/x-diff;
  charset="us-ascii";
  name="missing-llrwblkc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="missing-llrwblkc.patch"

--- linux-2.4.21-BK/drivers/block/ll_rw_blk.c	2002-12-05 18:54:22.000000000 +0100
+++ linux-2.4.20-ac1/drivers/block/ll_rw_blk.c	2002-12-06 16:14:01.000000000 +0100
@@ -1413,12 +1452,6 @@
 #ifdef CONFIG_ISP16_CDI
 	isp16_init();
 #endif
-#if defined(CONFIG_IDE) && defined(CONFIG_BLK_DEV_IDE)
-	ide_init();		/* this MUST precede hd_init */
-#endif
-#if defined(CONFIG_IDE) && defined(CONFIG_BLK_DEV_HD)
-	hd_init();
-#endif
 #ifdef CONFIG_BLK_DEV_PS2
 	ps2esdi_init();
 #endif

--------------Boundary-00=_XVNV17JCQBBXMN8ETUS7--


Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314444AbSEaCQh>; Thu, 30 May 2002 22:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314451AbSEaCQg>; Thu, 30 May 2002 22:16:36 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:12784 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S314444AbSEaCQf>; Thu, 30 May 2002 22:16:35 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15606.56577.526580.360836@wombat.chubb.wattle.id.au>
Date: Fri, 31 May 2002 12:16:33 +1000
To: linux-kernel@vger.kernel.org, axboe@suse.de, trivial@rustcorp.com.au
Subject: [PATCH] Remove bogus casts in ide-cd.c
X-Mailer: VM 7.03 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
X-Face: .slVUC18R`%{j(W3ztQe~*ATzet;h`*Wv33MZ]*M,}9AP<`+C=U)c#NzI5vK!0^d#6:<_`a
 {#.<}~(T^aJ~]-.C'p~saJ7qZXP-$AY==]7,9?WVSH5sQ}g3,8j>u%@f$/Z6,WR7*E~BFY.Yjw,H6<
 F.cEDj2$S:kO2+-5<]afj@kC!:uw\(<>lVpk)lPZs+2(=?=D/TZPG+P9LDN#1RRUPxdX
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch against 2.5.19 gets rid of some bogus casts in ide-cd.c
In my opinion the casts as is are bugs waiting to happen.

===== drivers/ide/ide-cd.c 1.48 vs edited =====
--- 1.48/drivers/ide/ide-cd.c	Fri May 24 11:19:15 2002
+++ edited/drivers/ide/ide-cd.c	Fri May 31 12:05:41 2002
@@ -2480,8 +2480,8 @@
 	devinfo->dev = mk_kdev(drive->channel->major, minor);
 	devinfo->ops = &ide_cdrom_dops;
 	devinfo->mask = 0;
-	*(int *)&devinfo->speed = CDROM_STATE_FLAGS (drive)->current_speed;
-	*(int *)&devinfo->capacity = nslots;
+	devinfo->speed = CDROM_STATE_FLAGS (drive)->current_speed;
+	devinfo->capacity = nslots;
 	devinfo->handle = (void *) drive;
 	strcpy(devinfo->name, drive->name);
 

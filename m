Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289280AbSAIJHv>; Wed, 9 Jan 2002 04:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289279AbSAIJHq>; Wed, 9 Jan 2002 04:07:46 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:63459 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S289281AbSAIJHb>; Wed, 9 Jan 2002 04:07:31 -0500
Date: Wed, 9 Jan 2002 11:07:33 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: Jens Axboe <axboe@suse.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Oops with eject and cdrom affects 2.4 & 2.5
In-Reply-To: <20020109091217.K19814@suse.de>
Message-ID: <Pine.LNX.4.33.0201091023380.8076-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2002, Jens Axboe wrote:

> Yes, just kill the printk instead.

Here are patches for 2.5.2-pre10 and 2.4.18-pre2 respectively

--- linux-2.5.2-pre10/drivers/ide/ide-cd.c.orig	Wed Jan  9 10:18:40 2002
+++ linux-2.5.2-pre10/drivers/ide/ide-cd.c	Wed Jan  9 10:28:22 2002
@@ -1398,11 +1398,8 @@
 		ide_init_drive_cmd (&req);
 		req.flags = REQ_PC;
 		req.special = (char *) pc;
-		if (ide_do_drive_cmd (drive, &req, ide_wait)) {
-			printk("%s: do_drive_cmd returned stat=%02x,err=%02x\n",
-				drive->name, req.buffer[0], req.buffer[1]);
-			/* FIXME: we should probably abort/retry or something */
-		}
+		ide_do_drive_cmd (drive, &req, ide_wait);
+
 		if (pc->stat != 0) {
 			/* The request failed.  Retry if it was due to a unit
 			   attention status




--- linux-2.4.18-pre2/drivers/ide/ide-cd.c.orig	Wed Jan  9 11:04:47 2002
+++ linux-2.4.18-pre2/drivers/ide/ide-cd.c	Wed Jan  9 11:05:14 2002
@@ -1462,11 +1462,8 @@
 		ide_init_drive_cmd (&req);
 		req.cmd = PACKET_COMMAND;
 		req.buffer = (char *)pc;
-		if (ide_do_drive_cmd (drive, &req, ide_wait)) {
-			printk("%s: do_drive_cmd returned stat=%02x,err=%02x\n",
-				drive->name, req.buffer[0], req.buffer[1]);
-			/* FIXME: we should probably abort/retry or something */
-		}
+		ide_do_drive_cmd (drive, &req, ide_wait);
+
 		if (pc->stat != 0) {
 			/* The request failed.  Retry if it was due to a unit
 			   attention status


Cheers,
	Zwane Mwaikambo




Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290921AbSASIV6>; Sat, 19 Jan 2002 03:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290923AbSASIVs>; Sat, 19 Jan 2002 03:21:48 -0500
Received: from netfinity.realnet.co.sz ([196.28.7.2]:1736 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S290921AbSASIVg>; Sat, 19 Jan 2002 03:21:36 -0500
Date: Sat, 19 Jan 2002 10:19:16 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Ben Clifford <benc@hawaga.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: OOPs reading audio data from CD, ide-cd.
In-Reply-To: <Pine.LNX.4.33.0201180923490.18054-100000@barbarella.hawaga.org.uk>
Message-ID: <Pine.LNX.4.44.0201191017360.10159-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2002, Ben Clifford wrote:

> 2.5.2, patched with: accessfs, i810_audio 0.20

I submitted a patch to fix this in 2.4.18-pre2. Here it is again, 
hopefully it will apply, if not send me drivers/ide/ide-cd.c and i'll do a 
patch for you.

Regards,
	Zwane Mwaikambo

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


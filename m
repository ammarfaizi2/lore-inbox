Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbTEHLUx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 07:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbTEHLUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 07:20:53 -0400
Received: from mail0.ewetel.de ([212.6.122.12]:7101 "EHLO mail0.ewetel.de")
	by vger.kernel.org with ESMTP id S261322AbTEHLUv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 07:20:51 -0400
Date: Thu, 8 May 2003 13:33:18 +0200 (CEST)
From: Pascal Schmidt <der.eremit@email.de>
To: Jens Axboe <axboe@suse.de>
cc: Pascal Schmidt <der.eremit@email.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [IDE] trying to make MO drive work with ide-floppy/ide-cd
In-Reply-To: <20030507193347.GU823@suse.de>
Message-ID: <Pine.LNX.4.44.0305081331570.1155-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 May 2003, Jens Axboe wrote:

> Definitely, this looks like a fine start. As far as I'm concerned, it
> would be fine to commit to 2.5.

As maintainer of ide-cd, would you forward it to Linus, then?
CCed Alan for the ide-probe.c change.

Index: drivers/ide/ide-cd.c
===================================================================
RCS file: /home/bkcvs/linux-2.5/drivers/ide/ide-cd.c,v
retrieving revision 1.107
diff -u -1 -b -p -r1.107 ide-cd.c
--- drivers/ide/ide-cd.c	20 Apr 2003 21:52:14 -0000	1.107
+++ drivers/ide/ide-cd.c	7 May 2003 17:34:30 -0000
@@ -2873,2 +2873,7 @@ int ide_cdrom_probe_capabilities (ide_dr
 
+	if (drive->media == ide_optical) {
+		printk("%s: ATAPI magneto-optical drive\n", drive->name);
+		return nslots;
+	}
+
 	if (CDROM_CONFIG_FLAGS(drive)->nec260) {
@@ -3339,3 +3344,3 @@ static int ide_cdrom_attach (ide_drive_t
 		goto failed;
-	if (drive->media != ide_cdrom)
+	if (drive->media != ide_cdrom && drive->media != ide_optical)
 		goto failed;
Index: drivers/ide/ide-probe.c
===================================================================
RCS file: /home/bkcvs/linux-2.5/drivers/ide/ide-probe.c,v
retrieving revision 1.85
diff -u -1 -b -p -r1.85 ide-probe.c
--- drivers/ide/ide-probe.c	24 Apr 2003 17:07:04 -0000	1.85
+++ drivers/ide/ide-probe.c	7 May 2003 17:25:37 -0000
@@ -1237,3 +1237,3 @@ struct gendisk *ata_probe(dev_t dev, int
 			(void) request_module("ide-scsi");
-		if (drive->media == ide_cdrom)
+		if (drive->media == ide_cdrom || drive->media == ide_optical)
 			(void) request_module("ide-cd");

-- 
Ciao,
Pascal


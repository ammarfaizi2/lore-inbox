Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292730AbSD2Nhb>; Mon, 29 Apr 2002 09:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311483AbSD2Nh3>; Mon, 29 Apr 2002 09:37:29 -0400
Received: from [195.63.194.11] ([195.63.194.11]:48398 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S292730AbSD2NhV>; Mon, 29 Apr 2002 09:37:21 -0400
Message-ID: <3CCD3DE7.3060100@evision-ventures.com>
Date: Mon, 29 Apr 2002 14:34:47 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PATCH] 2.5.11 IDE 45
Content-Type: multipart/mixed;
 boundary="------------010304030008030004050803"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010304030008030004050803
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

- Fix bogus set_multimode() change. I tough I had reverted it before diff-ing.
   This was causing hangs of /dev/hdparm -m8 /dev/hda and similar commands.



--------------010304030008030004050803
Content-Type: text/plain;
 name="ide-clean-45.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-45.diff"

diff -urN linux-2.5.11/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux-2.5.11/drivers/ide/ide-disk.c	2002-04-29 05:11:18.000000000 +0200
+++ linux/drivers/ide/ide-disk.c	2002-04-29 14:16:42.000000000 +0200
@@ -562,17 +562,17 @@
  */
 static int set_multcount(ide_drive_t *drive, int arg)
 {
-	struct ata_taskfile args;
+	struct request rq;
 
 	if (drive->special_cmd & ATA_SPECIAL_MMODE)
 		return -EBUSY;
 
-	memset(&args, 0, sizeof(args));
+	ide_init_drive_cmd(&rq);
 
 	drive->mult_req = arg;
 	drive->special_cmd |= ATA_SPECIAL_MMODE;
 
-	ide_raw_taskfile(drive, &args, NULL);
+	ide_do_drive_cmd (drive, &rq, ide_wait);
 
 	return (drive->mult_count == arg) ? 0 : -EIO;
 }

--------------010304030008030004050803--


Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312426AbSEDKsk>; Sat, 4 May 2002 06:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312447AbSEDKsj>; Sat, 4 May 2002 06:48:39 -0400
Received: from smtp1.wanadoo.nl ([194.134.35.136]:23546 "EHLO smtp1.wanadoo.nl")
	by vger.kernel.org with ESMTP id <S312426AbSEDKsi>;
	Sat, 4 May 2002 06:48:38 -0400
Message-Id: <4.1.20020504114136.0094c330@pop.cablewanadoo.nl>
X-Mailer: QUALCOMM Windows Eudora Pro Version 4.1
Date: Sat, 04 May 2002 12:43:48 +0200
To: Dave Jones <davej@suse.de>
From: Rudmer van Dijk <rudmer@legolas.dynup.net>
Subject: Re: Linux 2.5.13-dj1
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4.1.20020504102844.00940230@pop.cablewanadoo.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:49 4-5-02 +0200, I wrote:
>compiled ok, booted ok, but got the same problem as with 2.5.1[02]-dj1 on
>my p100 (with F00F bug):
>
>the boot process stopped after fsck of hda1 (root partition) and the
>message 'hda lost interrupt' popped up every 5 sec or so.
>reboot into 2.4.19-pre8 resulted in a panic due to ext2 corruption, fscking
>hda1 from a rescue partition gave the message: Group descriptors look
>bad... using backup 
>
>so how can I try to find the cause of this problem??
>
applied the pio-patch of Osamu Tomita:
--- linux-2.5.10/drivers/ide/ide-taskfile.c Wed Apr 24 16:15:19 2002
+++ linux/drivers/ide/ide-taskfile.c Fri Apr 26 15:44:42 2002
@@ -202,7 +202,7 @@
 			ata_write_slow(drive, buffer, wcount);
 		else
 #endif
- 			ata_write_16(drive, buffer, wcount<<1); 
+ 			ata_write_16(drive, buffer, wcount); 
 	} 
 }

now the system keeps working after fsck and thus surviving the first write
to the disk...

after ~half an hour of heavy use (finding+grepping through the kernel
sources, hdparm -tT, dd from /dev/zero to file, all while running
SETI@home) it silently stopped. no messages, no response, SysRq-space gave
no message and it took about five times pressing SysRq-b for the system to
reboot. This time no kernel panic and no errors on filesystem.

	Rudmer

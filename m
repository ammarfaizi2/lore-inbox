Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290442AbSAQUa3>; Thu, 17 Jan 2002 15:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290441AbSAQUaT>; Thu, 17 Jan 2002 15:30:19 -0500
Received: from smtp2.us.dell.com ([143.166.82.242]:42974 "EHLO
	smtp2.us.dell.com") by vger.kernel.org with ESMTP
	id <S290442AbSAQUaM>; Thu, 17 Jan 2002 15:30:12 -0500
Date: Thu, 17 Jan 2002 14:28:52 -0600 (CST)
From: Matt Domsch <Matt_Domsch@Dell.com>
X-X-Sender: <mdomsch@localhost.localdomain>
Reply-To: Matt Domsch <Matt_Domsch@Dell.com>
To: <linux-kernel@vger.kernel.org>
Subject: BLKGETSIZE64 (bytes or sectors?)
Message-ID: <Pine.LNX.4.33.0201171420100.2747-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is the BLKGETSIZE64 ioctl supposed to return the size of the device in 
bytes (as the comment says, and is implemented in all places *except* 
blkpg.c), or in sectors (as is implemented in blkpg.c since 2.4.15)?

It would seem that blkpg.c gets it wrong, that it should be in bytes.  
Assuming that's the case, here's the patch to fix it against 2.4.18-pre4.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer
Dell Linux Solutions www.dell.com/linux
#1 US Linux Server provider with 24.5% (IDC Dec 2001)
#2 Worldwide Linux Server provider with 18.2% (IDC Dec 2001)


--- linux-2.4.18-pre4/drivers/block/blkpg.c.orig	Thu Jan 17 14:24:24 2002
+++ linux-2.4.18-pre4/drivers/block/blkpg.c	Thu Jan 17 14:26:43 2002
@@ -247,7 +247,7 @@ int blk_ioctl(kdev_t dev, unsigned int c
 			if (cmd == BLKGETSIZE)
 				return put_user((unsigned long)ullval, (unsigned long *)arg);
 			else
-				return put_user(ullval, (u64 *)arg);
+				return put_user((u64)ullval << 9 , (u64 *)arg);
 #if 0
 		case BLKRRPART: /* Re-read partition tables */
 			if (!capable(CAP_SYS_ADMIN)) 


Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314081AbSEAWyV>; Wed, 1 May 2002 18:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314082AbSEAWyU>; Wed, 1 May 2002 18:54:20 -0400
Received: from nycsmtp2fb.rdc-nyc.rr.com ([24.29.99.78]:23308 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S314081AbSEAWyQ>;
	Wed, 1 May 2002 18:54:16 -0400
Date: Wed, 1 May 2002 18:45:15 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: <fdavis@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
cc: <torvalds@transmeta.com>, <fdavis@si.rr.com>
Subject: [PATCH] 2.5.12 drivers/ide/pdcadma.c
Message-ID: <Pine.LNX.4.33.0205011837010.7159-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
 This patch addresses the following error :

pdcadma.c: In function `pdcadma_dmaproc`
pdcadma.c:69: too few arguments to function `ide_dmaproc`
make[3]: *** [pdcadma.o] Error 1

Its missing the "struct request * " argument, which I set to NULL

Please review for inclusion. 

Regards,
Frank

--- drivers/ide/pdcadma.c.old	Mon Apr 15 20:57:57 2002
+++ drivers/ide/pdcadma.c	Wed May  1 18:35:12 2002
@@ -66,7 +66,7 @@
 		default:
 			break;
 	}
-	return ide_dmaproc(func, drive);	/* use standard DMA stuff */
+	return ide_dmaproc(func, drive, NULL);	/* use standard DMA stuff */
 }
 #endif /* CONFIG_BLK_DEV_IDEDMA */
 


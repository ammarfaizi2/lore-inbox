Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130540AbQKRTAx>; Sat, 18 Nov 2000 14:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130614AbQKRTAo>; Sat, 18 Nov 2000 14:00:44 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:1796 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S130540AbQKRTA2>; Sat, 18 Nov 2000 14:00:28 -0500
Date: Sat, 18 Nov 2000 18:30:22 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] more up_and_exit() fixes.
Message-ID: <Pine.LNX.4.30.0011181829460.1056-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Index: drivers/media/video/msp3400.c
===================================================================
RCS file: /net/passion/inst/cvs/linux/drivers/media/video/Attic/msp3400.c,v
retrieving revision 1.1.2.2
diff -u -r1.1.2.2 msp3400.c
--- drivers/media/video/msp3400.c	2000/11/15 12:15:02	1.1.2.2
+++ drivers/media/video/msp3400.c	2000/11/18 18:27:17
@@ -912,7 +912,7 @@
 	msp->thread = NULL;

 	if(msp->notify != NULL)
-		up(msp->notify);
+		up_and_exit(msp->notify, 0);
 	return 0;
 }

Index: drivers/media/video/tvaudio.c
===================================================================
RCS file: /net/passion/inst/cvs/linux/drivers/media/video/Attic/tvaudio.c,v
retrieving revision 1.1.2.1
diff -u -r1.1.2.1 tvaudio.c
--- drivers/media/video/tvaudio.c	2000/11/15 12:15:02	1.1.2.1
+++ drivers/media/video/tvaudio.c	2000/11/18 18:27:19
@@ -291,7 +291,7 @@
 	chip->thread = NULL;
 	dprintk("%s: thread exiting\n", chip->c.name);
 	if(chip->notify != NULL)
-		up(chip->notify);
+		up_and_exit(chip->notify, 0);

 	return 0;
 }

-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277918AbRLBNYx>; Sun, 2 Dec 2001 08:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282873AbRLBNYn>; Sun, 2 Dec 2001 08:24:43 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:38546 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S277918AbRLBNY1>; Sun, 2 Dec 2001 08:24:27 -0500
Date: Sun, 2 Dec 2001 15:28:57 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] floppy.c #defines
In-Reply-To: <3C0A1B2B.D2285CB@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0112021526530.3767-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- linux-2.5.1-pre5/drivers/block/floppy.c	Sun Dec  2 14:26:22 2001
+++ linux-2.5.1-pre5-test/drivers/block/floppy.c	Sun Dec  2 15:25:07 2001
@@ -496,7 +496,7 @@

 #define NO_SIGNAL (!interruptible || !signal_pending(current))
 #define CALL(x) if ((x) == -EINTR) return -EINTR
-#define ECALL(x) if ((ret = (x))) return ret;
+#define ECALL(x) if ((ret = (x))) return ret
 #define _WAIT(x,i) CALL(ret=wait_til_done((x),i))
 #define WAIT(x) _WAIT((x),interruptible)
 #define IWAIT(x) _WAIT((x),1)
@@ -663,23 +663,8 @@
 	timeout_message = message;
 }

-static int maximum(int a, int b)
-{
-	if (a > b)
-		return a;
-	else
-		return b;
-}
-#define INFBOUND(a,b) (a)=maximum((a),(b));
-
-static int minimum(int a, int b)
-{
-	if (a < b)
-		return a;
-	else
-		return b;
-}
-#define SUPBOUND(a,b) (a)=minimum((a),(b));
+#define INFBOUND(a,b) (a)=max((a),(b))
+#define SUPBOUND(a,b) (a)=min((a),(b))


 /*
@@ -2474,12 +2459,12 @@
 	int size;

 	max_sector = transfer_size(ssize,
-				   minimum(max_sector, max_sector_2),
+				   min(max_sector, max_sector_2),
 				   CURRENT->nr_sectors);

 	if (current_count_sectors <= 0 && CT(COMMAND) == FD_WRITE &&
 	    buffer_max > fsector_t + CURRENT->nr_sectors)
-		current_count_sectors = minimum(buffer_max - fsector_t,
+		current_count_sectors = min(buffer_max - fsector_t,
 						CURRENT->nr_sectors);

 	remaining = current_count_sectors << 9;
@@ -2497,7 +2482,7 @@
 	}
 #endif

-	buffer_max = maximum(max_sector, buffer_max);
+	buffer_max = max(max_sector, buffer_max);

 	dma_buffer = floppy_track_buffer + ((fsector_t - buffer_min) << 9);

@@ -2653,7 +2638,7 @@
 	if ((_floppy->rate & FD_2M) && (!TRACK) && (!HEAD)){
 		max_sector = 2 * _floppy->sect / 3;
 		if (fsector_t >= max_sector){
-			current_count_sectors = minimum(_floppy->sect - fsector_t,
+			current_count_sectors = min(_floppy->sect - fsector_t,
 							CURRENT->nr_sectors);
 			return 1;
 		}
@@ -3506,7 +3491,7 @@
 	/* copyin */
 	CLEARSTRUCT(&inparam);
 	if (_IOC_DIR(cmd) & _IOC_WRITE)
-		ECALL(fd_copyin((void *)param, &inparam, size))
+		ECALL(fd_copyin((void *)param, &inparam, size));

 	switch (cmd) {
 		case FDEJECT:


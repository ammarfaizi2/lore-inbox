Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280554AbRKFVKh>; Tue, 6 Nov 2001 16:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280570AbRKFVK0>; Tue, 6 Nov 2001 16:10:26 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:26640 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S280554AbRKFVKV>; Tue, 6 Nov 2001 16:10:21 -0500
Date: Tue, 6 Nov 2001 22:10:14 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: <andrewm@uow.edu.au>, <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andreas Dilger <adilger@turbolabs.com>
Subject: [PATCH] slip.c jiffies cleanup
In-Reply-To: <3BE84479.7FAC046C@mandrakesoft.com>
Message-ID: <Pine.LNX.4.30.0111062152270.23828-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Nov 2001, Jeff Garzik wrote:

> would you wind CC'ing drivers/net/* stuff to me?
>

Sorry for not keeping you informed. Please also drop a note if I shall
not yet Cc: Linus and Alan. While I have read lkml archives for many years
now, I am not yet used to Cc:ing policy as this information is not
kept the archives.

I could not find a maintainer for slip.c, which is the last of my network
patches for now.

Tim

--- ../linux-2.4.14-pre6/drivers/net/slip.c	Sun Sep 30 21:26:07 2001
+++ drivers/net/slip.c	Tue Nov  6 19:56:48 2001
@@ -483,7 +483,7 @@
 		 *      14 Oct 1994 Dmitry Gorodchanin.
 		 */
 #ifdef SL_CHECK_TRANSMIT
-		if (jiffies - dev->trans_start  < 20 * HZ)  {
+		if (time_before(jiffies, dev->trans_start + 20 * HZ))  {
 			/* 20 sec timeout not reached */
 			goto out;
 		}
@@ -1387,7 +1387,7 @@
 	int i;

 	if (slip_ctrls != NULL) {
-		unsigned long start = jiffies;
+		unsigned long timeout = jiffies + HZ;
 		int busy = 0;

 		/* First of all: check for active disciplines and hangup them.
@@ -1412,7 +1412,7 @@
 				spin_unlock(&slc->ctrl.lock);
 			}
 			local_bh_enable();
-		} while (busy && jiffies - start < 1*HZ);
+		} while (busy && time_before(jiffies, timeout);

 		busy = 0;
 		for (i = 0; i < slip_maxdev; i++) {




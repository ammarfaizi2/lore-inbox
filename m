Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287402AbRL3NQV>; Sun, 30 Dec 2001 08:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287399AbRL3NQM>; Sun, 30 Dec 2001 08:16:12 -0500
Received: from colorfullife.com ([216.156.138.34]:41996 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S287405AbRL3NQC>;
	Sun, 30 Dec 2001 08:16:02 -0500
Message-ID: <3C2F138C.63EAAE71@colorfullife.com>
Date: Sun, 30 Dec 2001 14:15:56 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.5.1-dj6 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: torvalds@transmeta.com
Subject: [PATCH, COMPILE-FIX, TYPO] drivers/char/pc110pad.c
Content-Type: multipart/mixed;
 boundary="------------DAFE3B0BD61F57FF51FCB700"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------DAFE3B0BD61F57FF51FCB700
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

pc110pad.c doesn't compile if SMP is enabled. This patch is needed:
<<<<<<
--- 2.5/drivers/char/pc110pad.c Sat Dec 29 19:13:41 2001
+++ build-2.5/drivers/char/pc110pad.c   Sun Dec 30 14:02:32 2001
@@ -590,7 +590,7 @@
        spin_lock_irqsave(&pc110_lock, flags);
        if (!--active_count)
                outb(0x30, current_params.io+2);  /* switch off
digitiser */
-       spin_unlock_irqrestore(&active_lock, flags);
+       spin_unlock_irqrestore(&pc110_lock, flags);
        return 0;
 }
 
<<<<<<<<<

The bug was introduced between 2.4.17 and 2.5.1: someone added
spinlocks instead of cli(), without adding his name to the changelog.


--
	Manfred
P.S.: Netscape eats space, I've attached is as MIME, too.
--------------DAFE3B0BD61F57FF51FCB700
Content-Type: text/plain; charset=us-ascii;
 name="patch-pc110"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-pc110"

--- 2.5/drivers/char/pc110pad.c	Sat Dec 29 19:13:41 2001
+++ build-2.5/drivers/char/pc110pad.c	Sun Dec 30 14:02:32 2001
@@ -590,7 +590,7 @@
 	spin_lock_irqsave(&pc110_lock, flags);
 	if (!--active_count)
 		outb(0x30, current_params.io+2);  /* switch off digitiser */
-	spin_unlock_irqrestore(&active_lock, flags);	
+	spin_unlock_irqrestore(&pc110_lock, flags);	
 	return 0;
 }
 

--------------DAFE3B0BD61F57FF51FCB700--


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266416AbSKGJOD>; Thu, 7 Nov 2002 04:14:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266420AbSKGJOD>; Thu, 7 Nov 2002 04:14:03 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:10386 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S266416AbSKGJOB>; Thu, 7 Nov 2002 04:14:01 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 7 Nov 2002 11:16:23 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Kernel List <linux-kernel@vger.kernel.org>,
       Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: [patch] gemtek radio fix
Message-ID: <20021107101623.GA1924@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch makes the gemtek radio device start muted.

please apply,

  Gerd

--- linux-2.5.46/drivers/media/radio/radio-gemtek.c	2002-11-07 09:18:21.000000000 +0100
+++ linux/drivers/media/radio/radio-gemtek.c	2002-11-07 09:22:16.000000000 +0100
@@ -269,14 +269,14 @@
 	printk(KERN_INFO "GemTek Radio Card driver.\n");
 
 	spin_lock_init(&lock);
- 	/* mute card - prevents noisy bootups */
-	outb(0x10, io);
-	udelay(5);
-	gemtek_unit.muted = 1;
 
 	/* this is _maybe_ unnecessary */
 	outb(0x01, io);
 
+ 	/* mute card - prevents noisy bootups */
+	gemtek_unit.muted = 0;
+	gemtek_mute(&gemtek_unit);
+
 	return 0;
 }
 

-- 
You can't please everybody.  And usually if you _try_ to please
everybody, the end result is one big mess.
				-- Linus Torvalds, 2002-04-20

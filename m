Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317391AbSFCPEl>; Mon, 3 Jun 2002 11:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317393AbSFCPEk>; Mon, 3 Jun 2002 11:04:40 -0400
Received: from [195.63.194.11] ([195.63.194.11]:49671 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317391AbSFCPEk>; Mon, 3 Jun 2002 11:04:40 -0400
Message-ID: <3CFB77D3.7010007@evision-ventures.com>
Date: Mon, 03 Jun 2002 16:06:11 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        breed@users.sourceforge.net
Subject: [PATCH] 2.5.20 airo wireless -  "I can't get no, compilation..."
In-Reply-To: <Pine.LNX.4.33.0206021853030.1383-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------030501090509090409060204"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030501090509090409060204
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Fix namespace clash with proc stuff an compilation warnings.

--------------030501090509090409060204
Content-Type: text/plain;
 name="ario-2.5.20.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ario-2.5.20.diff"

diff -urN linux-2.5.20/drivers/net/wireless/airo.c linux/drivers/net/wireless/airo.c
--- linux-2.5.20/drivers/net/wireless/airo.c	2002-06-03 03:44:41.000000000 +0200
+++ linux/drivers/net/wireless/airo.c	2002-06-03 09:55:16.000000000 +0200
@@ -191,12 +191,6 @@
 #ifndef RUN_AT
 #define RUN_AT(x) (jiffies+(x))
 #endif
-#ifndef PDE
-static inline struct proc_dir_entry *PDE(const struct inode *inode)
-{
-	return inode->u.generic_ip;
-}
-#endif
 
 
 /* These variables are for insmod, since it seems that the rates
@@ -723,7 +717,7 @@
 
 /* Leave gap of 40 commands after AIROGSTATSD32 for future */
 
-#define AIROPCAP               	AIROGSTATSD32 + 40
+#define AIROPCAP		AIROGSTATSD32 + 40
 #define AIROPVLIST              AIROPCAP      + 1
 #define AIROPSLIST		AIROPVLIST    + 1
 #define AIROPCFG		AIROPSLIST    + 1
@@ -845,7 +839,7 @@
 	struct proc_dir_entry *proc_entry;
 	struct airo_info *next;
         spinlock_t aux_lock;
-        int flags;
+        unsigned long flags;
 #define FLAG_PROMISC   IFF_PROMISC
 #define FLAG_RADIO_OFF 0x02
 #define FLAG_LOCKED    2
@@ -866,7 +860,7 @@
 #ifdef WIRELESS_EXT
 	struct iw_statistics	wstats;		// wireless stats
 	unsigned long		scan_timestamp;	/* Time started to scan */
-	struct tq_struct 	event_task;
+	struct tq_struct	event_task;
 #ifdef WIRELESS_SPY
 	int			spy_number;
 	u_char			spy_address[IW_MAX_SPY][6];

--------------030501090509090409060204--


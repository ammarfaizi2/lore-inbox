Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271861AbRIMQrb>; Thu, 13 Sep 2001 12:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271863AbRIMQrT>; Thu, 13 Sep 2001 12:47:19 -0400
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:18693 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S271864AbRIMQqx>; Thu, 13 Sep 2001 12:46:53 -0400
Date: Thu, 13 Sep 2001 18:43:43 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: torvalds@transmeta.com
Subject: [x86-64 patch 10/11] random.c precise timers on x86-64
Message-ID: <20010913184343.A2641@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This patch adds precise timing support on x86-64 into random.c.

diff -urN linux-x86_64/drivers/char/random.c linux/drivers/char/random.c
--- linux-x86_64/drivers/char/random.c	Thu Sep 13 15:17:33 2001
+++ linux/drivers/char/random.c	Tue Sep 11 09:49:17 2001
@@ -717,6 +717,10 @@
 	} else {
 		time = jiffies;
 	}
+#elif defined (__x86_64__)
+	__u32 high;
+	rdtsc(time, high);
+	num ^= high;
 #else
 	time = jiffies;
 #endif

-- 
Vojtech Pavlik
SuSE Labs

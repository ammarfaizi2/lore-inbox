Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268086AbUIAXVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268086AbUIAXVy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 19:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267599AbUIAXSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 19:18:16 -0400
Received: from baikonur.stro.at ([213.239.196.228]:59610 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S268073AbUIAXQb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 19:16:31 -0400
Subject: [patch 09/14]  radio/radio-sf16fmi: replace 	schedule_timeout() with msleep()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Thu, 02 Sep 2004 01:16:28 +0200
Message-ID: <E1C2eL6-0002pp-AW@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org







I would appreciate any comments from the janitor@sternweltens list.

Thanks,
Nish



Description: Replaced schedule_timeout() with msleep() to guarantee the
task delays the desired time.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.9-rc1-bk7-max/drivers/media/radio/radio-sf16fmi.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff -puN drivers/media/radio/radio-sf16fmi.c~msleep-drivers_media_radio-sf16fmi drivers/media/radio/radio-sf16fmi.c
--- linux-2.6.9-rc1-bk7/drivers/media/radio/radio-sf16fmi.c~msleep-drivers_media_radio-sf16fmi	2004-09-01 19:35:13.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/drivers/media/radio/radio-sf16fmi.c	2004-09-01 19:35:13.000000000 +0200
@@ -89,8 +89,7 @@ static inline int fmi_setfreq(struct fmi
 
 	outbits(16, RSF16_ENCODE(freq), myport);
 	outbits(8, 0xC0, myport);
-	current->state = TASK_UNINTERRUPTIBLE;
-	schedule_timeout(HZ/7);
+	msleep(143);		/* was schedule_timeout(HZ/7) */
 	up(&lock);
 	if (dev->curvol) fmi_unmute(myport);
 	return 0;
@@ -107,8 +106,7 @@ static inline int fmi_getsigstr(struct f
 	val = dev->curvol ? 0x08 : 0x00;	/* unmute/mute */
 	outb(val, myport);
 	outb(val | 0x10, myport);
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(HZ/7);
+	msleep(143); 		/* was schedule_timeout(HZ/7) */
 	res = (int)inb(myport+1);
 	outb(val, myport);
 	

_

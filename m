Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268116AbUIAXRW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268116AbUIAXRW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 19:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268115AbUIAXRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 19:17:12 -0400
Received: from baikonur.stro.at ([213.239.196.228]:18151 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S268114AbUIAXQg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 19:16:36 -0400
Subject: [patch 10/14]  radio/radio-sf16fmr2: 	replace	schedule_timeout() with msleep()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Thu, 02 Sep 2004 01:16:33 +0200
Message-ID: <E1C2eLB-0002qX-PK@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org







On Tue, Jul 27, 2004 at 10:14:49AM -0400, Mark Hollomon wrote:
> since sleep_delay is only called once (with the intent to sleep for 110 
> ms), wouldn't it be better to simply replace the call to sleep_delay 
> with msleep (and remove sleep_delay)?

I wasn't sure if I should leave the function in, in case someone wanted
to modify the driver later. But, if you think it's ok, find this fix below.
Thanks again, Mark.

-Nish



Description: Replace single invocation of sleep_delay() with msleep() and
remove definition of sleep_delay().

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.9-rc1-bk7-max/drivers/media/radio/radio-sf16fmr2.c |   15 -----------
 1 files changed, 1 insertion(+), 14 deletions(-)

diff -puN drivers/media/radio/radio-sf16fmr2.c~msleep-drivers_media_radio-sf16fmr2 drivers/media/radio/radio-sf16fmr2.c
--- linux-2.6.9-rc1-bk7/drivers/media/radio/radio-sf16fmr2.c~msleep-drivers_media_radio-sf16fmr2	2004-09-01 19:35:14.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/drivers/media/radio/radio-sf16fmr2.c	2004-09-01 19:35:14.000000000 +0200
@@ -55,19 +55,6 @@ static int radio_nr = -1;
 #define RSF16_MINFREQ 87*16000
 #define RSF16_MAXFREQ 108*16000
 
-/* from radio-aimslab */
-static void sleep_delay(unsigned long n)
-{
-	unsigned d=n/(1000000U/HZ);
-	if (!d)
-		udelay(n);
-	else
-	{
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(d);
-	}
-}
-
 static inline void wait(int n,int port)
 {
 	for (;n;--n) inb(port);
@@ -153,7 +140,7 @@ static int fmr2_setfreq(struct fmr2_devi
 	fmr2_unmute(port);
 
 	/* wait 0.11 sec */
-	sleep_delay(110000LU);
+	msleep(110);
 
 	/* NOTE if mute this stop radio
 	   you must set freq on unmute */

_

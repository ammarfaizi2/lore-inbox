Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267435AbUIAXAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267435AbUIAXAM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 19:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268058AbUIAVBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 17:01:41 -0400
Received: from baikonur.stro.at ([213.239.196.228]:30177 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267994AbUIAU53
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:57:29 -0400
Subject: [patch 20/25]  ec3104: replace schedule_timeout() with 	msleep()
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Wed, 01 Sep 2004 22:57:28 +0200
Message-ID: <E1C2cAa-0007TW-JF@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org







I would appreciate any comments from the janitor@sternweltens list. This is one (of
a few) places where I had to make a decision to set the state before the
call to

schedule_timeout();

This of course affected any decision to replace the code with msleep()
or not. Please inform if the other state from the one I used is desired.

Thanks,
Nish



Description: Uses msleep() instead of schedule_timeout() to guarantee
the task delays at least the desired time amount.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.9-rc1-bk7-max/drivers/char/ec3104_keyb.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/char/ec3104_keyb.c~msleep-drivers_char_ec3104_keyb drivers/char/ec3104_keyb.c
--- linux-2.6.9-rc1-bk7/drivers/char/ec3104_keyb.c~msleep-drivers_char_ec3104_keyb	2004-09-01 19:34:45.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/drivers/char/ec3104_keyb.c	2004-09-01 19:34:45.000000000 +0200
@@ -412,7 +412,7 @@ static void ec3104_keyb_clear_state(void
 	k->last_msr = 0;
 
 	for (;;) {
-		schedule_timeout(HZ/10);
+		msleep(100);
 
 		msr = ctrl_inb(EC3104_SER4_MSR);
 	

_

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264954AbUIWUYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264954AbUIWUYG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 16:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265795AbUIWUWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:22:31 -0400
Received: from baikonur.stro.at ([213.239.196.228]:51898 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S266196AbUIWUTw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:19:52 -0400
Subject: [patch 5/5]  pcmcia/sa1100_h3600: replace 	schedule_timeout() with msleep()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:19:53 +0200
Message-ID: <E1CAa4H-0007JW-Ub@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org







I would appreciate any comments from the janitor@sternweltens list. 



Description: Use msleep() instead of schedule_timeout() to 
guarantee the task delays for the desired time.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.9-rc2-bk7-max/drivers/pcmcia/sa1100_h3600.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/pcmcia/sa1100_h3600.c~msleep-drivers_pcmcia_sa1100_h3600 drivers/pcmcia/sa1100_h3600.c
--- linux-2.6.9-rc2-bk7/drivers/pcmcia/sa1100_h3600.c~msleep-drivers_pcmcia_sa1100_h3600	2004-09-21 20:51:18.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/pcmcia/sa1100_h3600.c	2004-09-21 20:51:18.000000000 +0200
@@ -10,6 +10,7 @@
 #include <linux/device.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
+#include <linux/delay.h>
 
 #include <asm/hardware.h>
 #include <asm/irq.h>
@@ -96,8 +97,7 @@ static void h3600_pcmcia_socket_init(str
 	set_h3600_egpio(IPAQ_EGPIO_OPT_ON);
 	clr_h3600_egpio(IPAQ_EGPIO_OPT_RESET);
 
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(10*HZ / 1000);
+	msleep(10);
 
 	soc_pcmcia_enable_irqs(skt, irqs, ARRAY_SIZE(irqs));
 }
_

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbUJ3Www@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbUJ3Www (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 18:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbUJ3WvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 18:51:18 -0400
Received: from baikonur.stro.at ([213.239.196.228]:50068 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261378AbUJ3WrM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 18:47:12 -0400
Subject: [patch 2/8]  pcmcia/yenta_socket: 	replace schedule_timeout() with msleep()
To: rmk+lkml@arm.linux.org.uk
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, janitor@sternwelten.at,
       nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Sun, 31 Oct 2004 00:47:02 +0200
Message-ID: <E1CO1zz-0002xy-38@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated.

Description: Use msleep() instead of schedule_timeout()
to guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.10-rc1-max/drivers/pcmcia/yenta_socket.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -puN drivers/pcmcia/yenta_socket.c~msleep-drivers_net_irda_pcmcia_yenta_socket drivers/pcmcia/yenta_socket.c
--- linux-2.6.10-rc1/drivers/pcmcia/yenta_socket.c~msleep-drivers_net_irda_pcmcia_yenta_socket	2004-10-24 17:04:56.000000000 +0200
+++ linux-2.6.10-rc1-max/drivers/pcmcia/yenta_socket.c	2004-10-24 17:04:56.000000000 +0200
@@ -827,8 +827,7 @@ static int yenta_probe_cb_irq(struct yen
 	cb_writel(socket, CB_SOCKET_MASK, CB_CSTSMASK);
 	cb_writel(socket, CB_SOCKET_FORCE, CB_FCARDSTS);
 	
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(HZ/10);
+	msleep(100);
 
 	/* disable interrupts */
 	cb_writel(socket, CB_SOCKET_MASK, 0);
_

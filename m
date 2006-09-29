Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161028AbWI3AFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161028AbWI3AFS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 20:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWI3AEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 20:04:30 -0400
Received: from www.osadl.org ([213.239.205.134]:38804 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1422858AbWI3AEU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 20:04:20 -0400
Message-Id: <20060929234441.435573000@cruncher.tec.linutronix.de>
References: <20060929234435.330586000@cruncher.tec.linutronix.de>
Date: Fri, 29 Sep 2006 23:58:43 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: [patch 23/23] dynticks: decrease I8042_POLL_PERIOD
Content-Disposition: inline; filename=i8042-poll-less.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

decrease the rate of timers going off. Also work around apparent
kbd-init bug by making the first timeout short.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
--
 drivers/input/serio/i8042.c |    2 +-
 drivers/input/serio/i8042.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.18-mm2/drivers/input/serio/i8042.c
===================================================================
--- linux-2.6.18-mm2.orig/drivers/input/serio/i8042.c	2006-09-30 01:41:08.000000000 +0200
+++ linux-2.6.18-mm2/drivers/input/serio/i8042.c	2006-09-30 01:41:20.000000000 +0200
@@ -1101,7 +1101,7 @@ static int __devinit i8042_probe(struct 
 		goto err_controller_cleanup;
 	}
 
-	mod_timer(&i8042_timer, jiffies + I8042_POLL_PERIOD);
+	mod_timer(&i8042_timer, jiffies + 2); //I8042_POLL_PERIOD);
 	return 0;
 
  err_unregister_ports:
Index: linux-2.6.18-mm2/drivers/input/serio/i8042.h
===================================================================
--- linux-2.6.18-mm2.orig/drivers/input/serio/i8042.h	2006-09-30 01:41:08.000000000 +0200
+++ linux-2.6.18-mm2/drivers/input/serio/i8042.h	2006-09-30 01:41:20.000000000 +0200
@@ -43,7 +43,7 @@
  * polling.
  */
 
-#define I8042_POLL_PERIOD	HZ/20
+#define I8042_POLL_PERIOD	(10*HZ)
 
 /*
  * Status register bits.

--


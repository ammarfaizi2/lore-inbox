Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261710AbSJFROK>; Sun, 6 Oct 2002 13:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261724AbSJFRNb>; Sun, 6 Oct 2002 13:13:31 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:48900 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261744AbSJFRNB>; Sun, 6 Oct 2002 13:13:01 -0400
Subject: PATCH: 2.5.40 clena up sf16fmi radio
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Sun, 6 Oct 2002 18:09:45 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17yEuX-0001rt-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.40/drivers/media/radio/radio-sf16fmi.c linux.2.5.40-ac5/drivers/media/radio/radio-sf16fmi.c
--- linux.2.5.40/drivers/media/radio/radio-sf16fmi.c	2002-07-20 20:11:13.000000000 +0100
+++ linux.2.5.40-ac5/drivers/media/radio/radio-sf16fmi.c	2002-10-05 23:38:39.000000000 +0100
@@ -116,15 +116,8 @@
 	val = dev->curvol ? 0x08 : 0x00;	/* unmute/mute */
 	outb(val, myport);
 	outb(val | 0x10, myport);
-	for(i=0; i< 100; i++)
-	{
-		udelay(1400);
-		cond_resched();
-	}
-/* If this becomes allowed use it ... 	
-	current->state = TASK_UNINTERRUPTIBLE;
+	set_current_state(TASK_UNINTERRUPTIBLE);
 	schedule_timeout(HZ/7);
-*/	
 	res = (int)inb(myport+1);
 	outb(val, myport);
 	
@@ -296,7 +289,7 @@
 	if (io < 0)
 		io = isapnp_fmi_probe();
 	if (io < 0) {
-		printk(KERN_ERR "radio-sf16fmi: No PnP card found.");
+		printk(KERN_ERR "radio-sf16fmi: No PnP card found.\n");
 		return io;
 	}
 	if (!request_region(io, 2, "radio-sf16fmi")) {

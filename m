Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263456AbSJHV63>; Tue, 8 Oct 2002 17:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263479AbSJHV62>; Tue, 8 Oct 2002 17:58:28 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:20725 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S263456AbSJHV6I>; Tue, 8 Oct 2002 17:58:08 -0400
Date: Tue, 8 Oct 2002 18:03:50 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: mingo@redhat.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [patch] silence an unnescessary raid5 debugging message
Message-ID: <20021008180350.A15858@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ingo,

LVM manages to trigger the "raid5: switching cache buffer size" printk 
quiet voluminously when using a snapshot device.  The following patch 
disables it by placing it under the debugging PRINTK macro.

		-ben
-- 
"Do you seek knowledge in time travel?"

diff -urN linux.orig/drivers/md/raid5.c linux/drivers/md/raid5.c
--- linux.orig/drivers/md/raid5.c	Mon Feb 25 14:37:58 2002
+++ linux/drivers/md/raid5.c	Tue Oct  8 17:56:43 2002
@@ -282,7 +282,7 @@
 				}
 
 				if (conf->buffer_size != size) {
-					printk("raid5: switching cache buffer size, %d --> %d\n", oldsize, size);
+					PRINTK("raid5: switching cache buffer size, %d --> %d\n", oldsize, size);
 					shrink_stripe_cache(conf);
 					if (size==0) BUG();
 					conf->buffer_size = size;

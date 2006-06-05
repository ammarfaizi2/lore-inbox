Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750886AbWFEKSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbWFEKSy (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 06:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbWFEKSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 06:18:53 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:51146 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750878AbWFEKSw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 06:18:52 -0400
Date: Mon, 5 Jun 2006 12:18:39 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: torvalds@osdl.org, akpm@osdl.org
Subject: [PATCH] printk time parameter
Message-ID: <Pine.LNX.4.61.0606051212020.31612@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,


Currently, enabling/disabling printk timestamps is only possible through 
reboot (bootparam) or recompile. I normally do not run with timestamps 
(since syslog handles that in a good manner), but for measuring small 
kernel delays (e.g. irq probing - see parport thread) I needed subsecond 
precision, but then again, just for some minutes rather than all kernel 
messages to come.
The following patch adds a module_param() with which the timestamps can be 
en-/disabled in a live system through 
/sys/modules/printk/parameters/printk_time.

Signed-off-by: Jan Engelhardt <jengelh@gmx.de>

diff --fast -Ndpru linux-2.6.17-rc5~/kernel/printk.c linux-2.6.17-rc5+/kernel/printk.c
--- linux-2.6.17-rc5~/kernel/printk.c	2006-06-03 13:30:10.000000000 +0200
+++ linux-2.6.17-rc5+/kernel/printk.c	2006-06-05 11:49:11.655884000 +0200
@@ -24,6 +24,7 @@
 #include <linux/console.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/interrupt.h>			/* For in_interrupt() */
 #include <linux/config.h>
 #include <linux/delay.h>
@@ -436,6 +437,7 @@ static int printk_time = 1;
 #else
 static int printk_time = 0;
 #endif
+module_param(printk_time, int, S_IRUGO | S_IWUSR);
 
 static int __init printk_time_setup(char *str)
 {
#<<eof>>


Jan Engelhardt
-- 

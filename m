Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269536AbUJTJBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269536AbUJTJBl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 05:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270176AbUJTIUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 04:20:47 -0400
Received: from ozlabs.org ([203.10.76.45]:4019 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S270067AbUJTHuK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 03:50:10 -0400
Subject: [PATCH] Remove MODULE_PARM from i386 defconfig.
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1098258609.10571.145.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 20 Oct 2004 17:50:09 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This cleans up defconfig for i386.  Not much work.

Name: Remove MODULE_PARM from i386 defconfig
Status: Compiled on 2.6-bk
Depends: Module/MODULE_PARM-warning.patch.gz
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

This patch removes MODULE_PARM for everything made by "defconfig" on
x86.  There are only a few left.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22800-linux-2.6-bk/drivers/acpi/thermal.c .22800-linux-2.6-bk.updated/drivers/acpi/thermal.c
--- .22800-linux-2.6-bk/drivers/acpi/thermal.c	2004-10-19 14:33:56.000000000 +1000
+++ .22800-linux-2.6-bk.updated/drivers/acpi/thermal.c	2004-10-20 16:30:52.000000000 +1000
@@ -76,7 +76,7 @@ MODULE_DESCRIPTION(ACPI_THERMAL_DRIVER_N
 MODULE_LICENSE("GPL");
 
 static int tzp;
-MODULE_PARM(tzp, "i");
+module_param(tzp, int, 0);
 MODULE_PARM_DESC(tzp, "Thermal zone polling frequency, in 1/10 seconds.\n");
 
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22800-linux-2.6-bk/drivers/cdrom/cdrom.c .22800-linux-2.6-bk.updated/drivers/cdrom/cdrom.c
--- .22800-linux-2.6-bk/drivers/cdrom/cdrom.c	2004-10-20 15:14:56.000000000 +1000
+++ .22800-linux-2.6-bk.updated/drivers/cdrom/cdrom.c	2004-10-20 17:14:07.000000000 +1000
@@ -296,12 +296,12 @@ static int lockdoor = 1;
 static int check_media_type;
 /* automatically restart mrw format */
 static int mrw_format_restart = 1;
-MODULE_PARM(debug, "i");
-MODULE_PARM(autoclose, "i");
-MODULE_PARM(autoeject, "i");
-MODULE_PARM(lockdoor, "i");
-MODULE_PARM(check_media_type, "i");
-MODULE_PARM(mrw_format_restart, "i");
+module_param(debug, bool, 0);
+module_param(autoclose, bool, 0);
+module_param(autoeject, bool, 0);
+module_param(lockdoor, bool, 0);
+module_param(check_media_type, bool, 0);
+module_param(mrw_format_restart, bool, 0);
 
 static spinlock_t cdrom_lock = SPIN_LOCK_UNLOCKED;
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22800-linux-2.6-bk/drivers/char/lp.c .22800-linux-2.6-bk.updated/drivers/char/lp.c
--- .22800-linux-2.6-bk/drivers/char/lp.c	2004-06-17 08:48:08.000000000 +1000
+++ .22800-linux-2.6-bk.updated/drivers/char/lp.c	2004-10-20 16:47:06.000000000 +1000
@@ -749,8 +749,8 @@ static int parport_nr[LP_NO] = { [0 ... 
 static char *parport[LP_NO] = { NULL,  };
 static int reset = 0;
 
-MODULE_PARM(parport, "1-" __MODULE_STRING(LP_NO) "s");
-MODULE_PARM(reset, "i");
+module_param_array(parport, charp, NULL, 0);
+module_param(reset, bool, 0);
 
 #ifndef MODULE
 static int __init lp_setup (char *str)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22800-linux-2.6-bk/drivers/ide/ide-cd.c .22800-linux-2.6-bk.updated/drivers/ide/ide-cd.c
--- .22800-linux-2.6-bk/drivers/ide/ide-cd.c	2004-10-20 15:14:59.000000000 +1000
+++ .22800-linux-2.6-bk.updated/drivers/ide/ide-cd.c	2004-10-20 16:38:42.000000000 +1000
@@ -3433,7 +3433,7 @@ static struct block_device_operations id
 /* options */
 char *ignore = NULL;
 
-MODULE_PARM(ignore, "s");
+module_param(ignore, charp, 0400);
 MODULE_DESCRIPTION("ATAPI CD-ROM Driver");
 
 static int ide_cdrom_attach (ide_drive_t *drive)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22800-linux-2.6-bk/drivers/net/8139too.c .22800-linux-2.6-bk.updated/drivers/net/8139too.c
--- .22800-linux-2.6-bk/drivers/net/8139too.c	2004-10-20 15:15:00.000000000 +1000
+++ .22800-linux-2.6-bk.updated/drivers/net/8139too.c	2004-10-20 17:06:15.000000000 +1000
@@ -599,10 +599,10 @@ MODULE_AUTHOR ("Jeff Garzik <jgarzik@pob
 MODULE_DESCRIPTION ("RealTek RTL-8139 Fast Ethernet driver");
 MODULE_LICENSE("GPL");
 
-MODULE_PARM (multicast_filter_limit, "i");
-MODULE_PARM (media, "1-" __MODULE_STRING(MAX_UNITS) "i");
-MODULE_PARM (full_duplex, "1-" __MODULE_STRING(MAX_UNITS) "i");
-MODULE_PARM (debug, "i");
+module_param(multicast_filter_limit, int, 0);
+module_param_array(media, int, NULL, 0);
+module_param_array(full_duplex, int, NULL, 0);
+module_param(debug, int, 0);
 MODULE_PARM_DESC (debug, "8139too bitmapped message enable number");
 MODULE_PARM_DESC (multicast_filter_limit, "8139too maximum number of filtered multicast addresses");
 MODULE_PARM_DESC (media, "8139too: Bits 4+9: force full duplex, bit 5: 100Mbps");
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22800-linux-2.6-bk/drivers/net/s2io.c .22800-linux-2.6-bk.updated/drivers/net/s2io.c
--- .22800-linux-2.6-bk/drivers/net/s2io.c	2004-10-20 15:15:01.000000000 +1000
+++ .22800-linux-2.6-bk.updated/drivers/net/s2io.c	2004-10-20 17:17:03.000000000 +1000
@@ -3983,14 +3983,14 @@ static void s2io_init_pci(nic_t * sp)
 
 MODULE_AUTHOR("Raghavendra Koushik <raghavendra.koushik@s2io.com>");
 MODULE_LICENSE("GPL");
-MODULE_PARM(ring_num, "1-" __MODULE_STRING(1) "i");
-MODULE_PARM(frame_len, "1-" __MODULE_STRING(8) "i");
-MODULE_PARM(ring_len, "1-" __MODULE_STRING(8) "i");
-MODULE_PARM(fifo_num, "1-" __MODULE_STRING(1) "i");
-MODULE_PARM(fifo_len, "1-" __MODULE_STRING(8) "i");
-MODULE_PARM(rx_prio, "1-" __MODULE_STRING(1) "i");
-MODULE_PARM(tx_prio, "1-" __MODULE_STRING(1) "i");
-MODULE_PARM(latency_timer, "1-" __MODULE_STRING(1) "i");
+module_param(ring_num, uint, 0);
+module_param_array(frame_len, uint, NULL, 0);
+module_param_array(ring_len, uint, NULL, 0);
+module_param(fifo_num, uint, 0);
+module_param_array(fifo_len, uint, NULL, 0);
+module_param(rx_prio, uint, 0);
+module_param(tx_prio, uint, 0);
+module_param(latency_timer, byte, 0);
 
 /*
 *  Input Argument/s: 

-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell


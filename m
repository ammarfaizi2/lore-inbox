Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263813AbTJORuX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 13:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263821AbTJORuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 13:50:22 -0400
Received: from holomorphy.com ([66.224.33.161]:48512 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263813AbTJORuF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 13:50:05 -0400
Date: Wed, 15 Oct 2003 10:52:51 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: John Cherry <cherry@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: 2.6.0-test7-mm1 (compile stats)
Message-ID: <20031015175251.GA711@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	John Cherry <cherry@osdl.org>, Andrew Morton <akpm@osdl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-mm@kvack.org
References: <20031015013649.4aebc910.akpm@osdl.org> <1066235943.3866.19.camel@cherrytest.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1066235943.3866.19.camel@cherrytest.pdx.osdl.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 15, 2003 at 09:39:04AM -0700, John Cherry wrote:
> Compile stats posted at: http://developer.osdl.org/cherry/compile/
> This is done for all mm releases now.
> John

This ought to silence some of them. I'm not sure how the EFI people
failed to notice their constants were getting truncated...


diff -prauN mm1-2.6.0-test7-1/drivers/ide/ide-io.c mm1-2.6.0-test7-2/drivers/ide/ide-io.c
--- mm1-2.6.0-test7-1/drivers/ide/ide-io.c	2003-10-15 10:21:40.000000000 -0700
+++ mm1-2.6.0-test7-2/drivers/ide/ide-io.c	2003-10-15 10:23:25.000000000 -0700
@@ -332,7 +332,7 @@ static void ide_complete_barrier(ide_dri
 	if (bad_sectors)
 		__ide_end_request(drive, real_rq, 0, bad_sectors);
 
-	printk(KERN_ERR "%s: failed barrier write: sector=%Lx(good=%d/bad=%d)\n", drive->name, sector, good_sectors, bad_sectors);
+	printk(KERN_ERR "%s: failed barrier write: sector=%Lx(good=%d/bad=%d)\n", drive->name, (u64)sector, good_sectors, bad_sectors);
 	blk_queue_ordered(drive->queue, QUEUE_ORDERED_NONE);
 }
 
diff -prauN mm1-2.6.0-test7-1/drivers/net/eepro100.c mm1-2.6.0-test7-2/drivers/net/eepro100.c
--- mm1-2.6.0-test7-1/drivers/net/eepro100.c	2003-10-15 10:21:40.000000000 -0700
+++ mm1-2.6.0-test7-2/drivers/net/eepro100.c	2003-10-15 10:26:06.000000000 -0700
@@ -543,7 +543,9 @@ static void speedo_refill_rx_buffers(str
 static int speedo_rx(struct net_device *dev);
 static void speedo_tx_buffer_gc(struct net_device *dev);
 static irqreturn_t speedo_interrupt(int irq, void *dev_instance, struct pt_regs *regs);
+#ifdef CONFIG_NET_POLL_CONTROLLER
 static void poll_speedo (struct net_device *dev);
+#endif
 static int speedo_close(struct net_device *dev);
 static struct net_device_stats *speedo_get_stats(struct net_device *dev);
 static int speedo_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
diff -prauN mm1-2.6.0-test7-1/drivers/net/tulip/tulip_core.c mm1-2.6.0-test7-2/drivers/net/tulip/tulip_core.c
--- mm1-2.6.0-test7-1/drivers/net/tulip/tulip_core.c	2003-10-15 10:21:40.000000000 -0700
+++ mm1-2.6.0-test7-2/drivers/net/tulip/tulip_core.c	2003-10-15 10:25:41.000000000 -0700
@@ -253,7 +253,9 @@ static void tulip_down(struct net_device
 static struct net_device_stats *tulip_get_stats(struct net_device *dev);
 static int private_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
 static void set_rx_mode(struct net_device *dev);
+#ifdef CONFIG_NET_POLL_CONTROLLER
 static void poll_tulip(struct net_device *dev);
+#endif
 
 
 
diff -prauN mm1-2.6.0-test7-1/include/linux/efi.h mm1-2.6.0-test7-2/include/linux/efi.h
--- mm1-2.6.0-test7-1/include/linux/efi.h	2003-10-15 10:21:42.000000000 -0700
+++ mm1-2.6.0-test7-2/include/linux/efi.h	2003-10-15 10:33:35.000000000 -0700
@@ -79,14 +79,14 @@ typedef	struct {
 #define EFI_MAX_MEMORY_TYPE		14
 
 /* Attribute values: */
-#define EFI_MEMORY_UC		0x0000000000000001	/* uncached */
-#define EFI_MEMORY_WC		0x0000000000000002	/* write-coalescing */
-#define EFI_MEMORY_WT		0x0000000000000004	/* write-through */
-#define EFI_MEMORY_WB		0x0000000000000008	/* write-back */
-#define EFI_MEMORY_WP		0x0000000000001000	/* write-protect */
-#define EFI_MEMORY_RP		0x0000000000002000	/* read-protect */
-#define EFI_MEMORY_XP		0x0000000000004000	/* execute-protect */
-#define EFI_MEMORY_RUNTIME	0x8000000000000000	/* range requires runtime mapping */
+#define EFI_MEMORY_UC		((u64)0x0000000000000001ULL)	/* uncached */
+#define EFI_MEMORY_WC		((u64)0x0000000000000002ULL)	/* write-coalescing */
+#define EFI_MEMORY_WT		((u64)0x0000000000000004ULL)	/* write-through */
+#define EFI_MEMORY_WB		((u64)0x0000000000000008ULL)	/* write-back */
+#define EFI_MEMORY_WP		((u64)0x0000000000001000ULL)	/* write-protect */
+#define EFI_MEMORY_RP		((u64)0x0000000000002000ULL)	/* read-protect */
+#define EFI_MEMORY_XP		((u64)0x0000000000004000ULL)	/* execute-protect */
+#define EFI_MEMORY_RUNTIME	((u64)0x8000000000000000ULL)	/* range requires runtime mapping */
 #define EFI_MEMORY_DESCRIPTOR_VERSION	1
 
 #define EFI_PAGE_SHIFT		12
@@ -147,7 +147,7 @@ typedef struct {
 /*
  * EFI Runtime Services table
  */
-#define EFI_RUNTIME_SERVICES_SIGNATURE 0x5652453544e5552
+#define EFI_RUNTIME_SERVICES_SIGNATURE ((u64)0x5652453544e5552ULL)
 #define EFI_RUNTIME_SERVICES_REVISION  0x00010000
 
 typedef struct {
@@ -217,7 +217,7 @@ typedef struct {
 	unsigned long table;
 } efi_config_table_t;
 
-#define EFI_SYSTEM_TABLE_SIGNATURE 0x5453595320494249
+#define EFI_SYSTEM_TABLE_SIGNATURE ((u64)0x5453595320494249ULL)
 #define EFI_SYSTEM_TABLE_REVISION  ((1 << 16) | 00)
 
 typedef struct {

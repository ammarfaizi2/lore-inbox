Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312694AbSDONvl>; Mon, 15 Apr 2002 09:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312696AbSDONvk>; Mon, 15 Apr 2002 09:51:40 -0400
Received: from www.microgate.com ([216.30.46.105]:33547 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP
	id <S312694AbSDONvj>; Mon, 15 Apr 2002 09:51:39 -0400
Subject: [PATCH] 2.5.8 synclink.c
From: Paul Fulghum <paulkf@microgate.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3.99 
Date: 15 Apr 2002 08:49:31 -0500
Message-Id: <1018878572.1068.3.camel@diemos.microgate.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

patch against 2.5.8 to update virt_to_bus functions and
remove version depedent #ifdef statements

This is unchanged from previously submitted patch against 2.5.8-pre3

--- linux-2.5.8/drivers/char/synclink.c	Sun Apr 14 14:18:50 2002
+++ linux-2.5.8-mg/drivers/char/synclink.c	Wed Apr 10 15:43:18 2002
@@ -1,7 +1,7 @@
 /*
  * linux/drivers/char/synclink.c
  *
- * $Id: synclink.c,v 3.12 2001/07/18 19:14:21 paulkf Exp $
+ * $Id: synclink.c,v 4.2 2002/04/10 20:45:13 paulkf Exp $
  *
  * Device driver for Microgate SyncLink ISA and PCI
  * high speed multiprotocol serial adapters.
@@ -60,8 +60,6 @@
 #  define BREAKPOINT() { }
 #endif
 
-#error Please convert me to Documentation/DMA-mapping.txt
-
 #define MAX_ISA_DEVICES 10
 #define MAX_PCI_DEVICES 10
 #define MAX_TOTAL_DEVICES 20
@@ -109,12 +107,8 @@
 #endif
 
 #ifdef CONFIG_SYNCLINK_SYNCPPP
-#if LINUX_VERSION_CODE < VERSION(2,4,3) 
-#include "../net/wan/syncppp.h"
-#else
 #include <net/syncppp.h>
 #endif
-#endif
 
 #define GET_USER(error,value,addr) error = get_user(value,addr)
 #define COPY_FROM_USER(error,dest,src,size) error = copy_from_user(dest,src,size) ? -EFAULT : 0
@@ -923,7 +917,7 @@
 MODULE_PARM(txholdbufs,"1-" __MODULE_STRING(MAX_TOTAL_DEVICES) "i");
 
 static char *driver_name = "SyncLink serial driver";
-static char *driver_version = "$Revision: 3.12 $";
+static char *driver_version = "$Revision: 4.2 $";
 
 static int synclink_init_one (struct pci_dev *dev,
 				     const struct pci_device_id *ent);
@@ -3985,7 +3979,7 @@
 		if ( info->buffer_list == NULL )
 			return -ENOMEM;
 			
-		info->buffer_list_phys = virt_to_bus(info->buffer_list);
+		info->buffer_list_phys = isa_virt_to_bus(info->buffer_list);
 	}
 
 	/* We got the memory for the buffer entry lists. */
@@ -4096,7 +4090,7 @@
 				kmalloc(DMABUFFERSIZE, GFP_KERNEL | GFP_DMA);
 			if ( BufferList[i].virt_addr == NULL )
 				return -ENOMEM;
-			phys_addr = virt_to_bus(BufferList[i].virt_addr);
+			phys_addr = isa_virt_to_bus(BufferList[i].virt_addr);
 		}
 		BufferList[i].phys_addr = phys_addr;
 	}
@@ -7990,10 +7984,6 @@
 	d->get_stats = mgsl_net_stats;
 	d->tx_timeout = mgsl_sppp_tx_timeout;
 	d->watchdog_timeo = 10*HZ;
-
-#if LINUX_VERSION_CODE < VERSION(2,4,4) 
-	dev_init_buffers(d);
-#endif
 
 	if (register_netdev(d) == -1) {
 		printk(KERN_WARNING "%s: register_netdev failed.\n", d->name);





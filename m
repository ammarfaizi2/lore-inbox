Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264183AbTEGXCM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 19:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264338AbTEGXCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 19:02:12 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:45191 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264183AbTEGXB7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 19:01:59 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10523493883143@kroah.com>
Subject: Re: [PATCH] TTY changes for 2.5.69
In-Reply-To: <10523493881029@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 7 May 2003 16:16:28 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1116, 2003/05/07 15:51:59-07:00, greg@kroah.com

TTY: changes based on tty_register_device() paramater change.


 arch/mips/au1000/common/serial.c |    8 ++++----
 drivers/char/dz.c                |    4 ++--
 drivers/char/hvc_console.c       |    2 +-
 drivers/char/ip2main.c           |    4 ++--
 drivers/char/vt.c                |    2 +-
 drivers/serial/core.c            |    2 +-
 drivers/tc/zs.c                  |    4 ++--
 drivers/usb/class/bluetty.c      |    2 +-
 drivers/usb/class/cdc-acm.c      |    2 +-
 9 files changed, 15 insertions(+), 15 deletions(-)


diff -Nru a/arch/mips/au1000/common/serial.c b/arch/mips/au1000/common/serial.c
--- a/arch/mips/au1000/common/serial.c	Wed May  7 15:59:59 2003
+++ b/arch/mips/au1000/common/serial.c	Wed May  7 15:59:59 2003
@@ -2681,8 +2681,8 @@
 		       (state->flags & ASYNC_FOURPORT) ? " FourPort" : "",
 		       state->port, state->irq,
 		       uart_config[state->type].name);
-		tty_register_device(&serial_driver, state->line);
-		tty_register_device(&callout_driver, state->line);
+		tty_register_device(&serial_driver, state->line, NULL);
+		tty_register_device(&callout_driver, state->line, NULL);
 	}
 	return 0;
 }
@@ -2769,8 +2769,8 @@
 	      state->iomem_base ? "iomem" : "port",
 	      state->iomem_base ? (unsigned long)state->iomem_base :
 	      state->port, state->irq, uart_config[state->type].name);
-	tty_register_device(&serial_driver, state->line); 
-	tty_register_device(&callout_driver, state->line);
+	tty_register_device(&serial_driver, state->line, NULL); 
+	tty_register_device(&callout_driver, state->line, NULL);
 	return state->line + SERIAL_DEV_OFFSET;
 }
 
diff -Nru a/drivers/char/dz.c b/drivers/char/dz.c
--- a/drivers/char/dz.c	Wed May  7 15:59:59 2003
+++ b/drivers/char/dz.c	Wed May  7 15:59:59 2003
@@ -1426,8 +1426,8 @@
 		printk("ttyS%02d at 0x%08x (irq = %d)\n", info->line,
 		       info->port, SERIAL);
 
-		tty_register_device(&serial_driver, info->line);
-		tty_register_device(&callout_driver, info->line);
+		tty_register_device(&serial_driver, info->line, NULL);
+		tty_register_device(&callout_driver, info->line, NULL);
 	}
 
 	/* Reset the chip */
diff -Nru a/drivers/char/hvc_console.c b/drivers/char/hvc_console.c
--- a/drivers/char/hvc_console.c	Wed May  7 15:59:59 2003
+++ b/drivers/char/hvc_console.c	Wed May  7 15:59:59 2003
@@ -283,7 +283,7 @@
 	for (i = 0; i < hvc_driver.num; i++) {
 		hvc_struct[i].lock = SPIN_LOCK_UNLOCKED;
 		hvc_struct[i].index = i;
-		tty_register_device(&hvc_driver, i);
+		tty_register_device(&hvc_driver, i, NULL);
 	}
 
 	if (tty_register_driver(&hvc_driver))
diff -Nru a/drivers/char/ip2main.c b/drivers/char/ip2main.c
--- a/drivers/char/ip2main.c	Wed May  7 15:59:59 2003
+++ b/drivers/char/ip2main.c	Wed May  7 15:59:59 2003
@@ -902,10 +902,10 @@
 				    {
 				        tty_register_device(&ip2_tty_driver,
 					    j + ABS_BIGGEST_BOX *
-						    (box+i*ABS_MAX_BOXES));
+						    (box+i*ABS_MAX_BOXES), NULL);
 				            tty_register_device(&ip2_callout_driver,
 					    j + ABS_BIGGEST_BOX *
-						    (box+i*ABS_MAX_BOXES));
+						    (box+i*ABS_MAX_BOXES), NULL);
 			    	    }
 			        }
 			    }
diff -Nru a/drivers/char/vt.c b/drivers/char/vt.c
--- a/drivers/char/vt.c	Wed May  7 15:59:59 2003
+++ b/drivers/char/vt.c	Wed May  7 15:59:59 2003
@@ -2666,7 +2666,7 @@
 	int i;
 
 	for (i = 0; i < console_driver.num; i++)
-		tty_register_device (&console_driver, i);
+		tty_register_device (&console_driver, i, NULL);
 }
 
 /*
diff -Nru a/drivers/serial/core.c b/drivers/serial/core.c
--- a/drivers/serial/core.c	Wed May  7 15:59:59 2003
+++ b/drivers/serial/core.c	Wed May  7 15:59:59 2003
@@ -2242,7 +2242,7 @@
 	 * Register the port whether it's detected or not.  This allows
 	 * setserial to be used to alter this ports parameters.
 	 */
-	tty_register_device(drv->tty_driver, port->line);
+	tty_register_device(drv->tty_driver, port->line, NULL);
 
  out:
 	up(&port_sem);
diff -Nru a/drivers/tc/zs.c b/drivers/tc/zs.c
--- a/drivers/tc/zs.c	Wed May  7 15:59:59 2003
+++ b/drivers/tc/zs.c	Wed May  7 15:59:59 2003
@@ -1971,8 +1971,8 @@
 		printk("ttyS%02d at 0x%08x (irq = %d)", info->line, 
 		       info->port, info->irq);
 		printk(" is a Z85C30 SCC\n");
-		tty_register_device(&serial_driver, info->line);
-		tty_register_device(&callout_driver, info->line);
+		tty_register_device(&serial_driver, info->line, NULL);
+		tty_register_device(&callout_driver, info->line, NULL);
 
 	}
 
diff -Nru a/drivers/usb/class/bluetty.c b/drivers/usb/class/bluetty.c
--- a/drivers/usb/class/bluetty.c	Wed May  7 15:59:59 2003
+++ b/drivers/usb/class/bluetty.c	Wed May  7 15:59:59 2003
@@ -1198,7 +1198,7 @@
 		     bluetooth, endpoint->bInterval);
 
 	/* initialize the devfs nodes for this device and let the user know what bluetooths we are bound to */
-	tty_register_device (&bluetooth_tty_driver, minor);
+	tty_register_device (&bluetooth_tty_driver, minor, &intf->dev);
 	info("Bluetooth converter now attached to ttyUB%d (or usb/ttub/%d for devfs)", minor, minor);
 
 	bluetooth_table[minor] = bluetooth;
diff -Nru a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
--- a/drivers/usb/class/cdc-acm.c	Wed May  7 15:59:59 2003
+++ b/drivers/usb/class/cdc-acm.c	Wed May  7 15:59:59 2003
@@ -653,7 +653,7 @@
 		usb_driver_claim_interface(&acm_driver, acm->iface + 0, acm);
 		usb_driver_claim_interface(&acm_driver, acm->iface + 1, acm);
 
-		tty_register_device(&acm_tty_driver, minor);
+		tty_register_device(&acm_tty_driver, minor, &intf->dev);
 
 		acm_table[minor] = acm;
 		usb_set_intfdata (intf, acm);


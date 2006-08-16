Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbWHPO0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbWHPO0R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 10:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWHPO0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 10:26:17 -0400
Received: from nz-out-0102.google.com ([64.233.162.198]:49439 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751120AbWHPO0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 10:26:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=TXvIK1vsLgA23OlDyZbQvhqBpC+Ul6KujpQN0Vzh4r9EGrivKRb5OjNfJSEki+G54SC9LX35cV/WOnQbjCBXG8PBHWgPsSGT7vZTignAXXtb8h1wOLCqO3n/ey5qyLcgOqeCf7Lziw1KVi+V4St96BZeaYlUbjTtDwUPdDfyPrw=
Message-ID: <44E32ADA.2060203@gmail.com>
Date: Wed, 16 Aug 2006 09:25:30 -0500
From: Matthew Martin <lihnucks@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: trivial@kernel.org
CC: linux-kernel@vger.kernel.org, tim@cyberelk.net
Subject: [PATCH] parport: Remove space in function calls
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Martin <lihnucks@gmail.com>

This removes the space in function calls in drivers/parport/daisy.c

Signed-off-by: Matthew Martin <lihnucks@gmail.com>
---

--- vanilla-linux-2.6.18-rc4/drivers/parport/daisy.c	2006-08-09 19:55:17.000000000 -0500
+++ linux-2.6.18-rc4/drivers/parport/daisy.c	2006-08-16 09:04:37.000000000 -0500
@@ -30,7 +30,7 @@
 #undef DEBUG
 
 #ifdef DEBUG
-#define DPRINTK(stuff...) printk (stuff)
+#define DPRINTK(stuff...) printk(stuff)
 #else
 #define DPRINTK(stuff...)
 #endif
@@ -46,16 +46,16 @@ static DEFINE_SPINLOCK(topology_lock);
 static int numdevs = 0;
 
 /* Forward-declaration of lower-level functions. */
-static int mux_present (struct parport *port);
-static int num_mux_ports (struct parport *port);
-static int select_port (struct parport *port);
-static int assign_addrs (struct parport *port);
+static int mux_present(struct parport *port);
+static int num_mux_ports(struct parport *port);
+static int select_port(struct parport *port);
+static int assign_addrs(struct parport *port);
 
 /* Add a device to the discovered topology. */
-static void add_dev (int devnum, struct parport *port, int daisy)
+static void add_dev(int devnum, struct parport *port, int daisy)
 {
 	struct daisydev *newdev, **p;
-	newdev = kmalloc (sizeof (struct daisydev), GFP_KERNEL);
+	newdev = kmalloc(sizeof(struct daisydev), GFP_KERNEL);
 	if (newdev) {
 		newdev->port = port;
 		newdev->daisy = daisy;
@@ -70,9 +70,9 @@ static void add_dev (int devnum, struct 
 }
 
 /* Clone a parport (actually, make an alias). */
-static struct parport *clone_parport (struct parport *real, int muxport)
+static struct parport *clone_parport(struct parport *real, int muxport)
 {
-	struct parport *extra = parport_register_port (real->base,
+	struct parport *extra = parport_register_port(real->base,
 						       real->irq,
 						       real->dma,
 						       real->ops);
@@ -88,7 +88,7 @@ static struct parport *clone_parport (st
 
 /* Discover the IEEE1284.3 topology on a port -- muxes and daisy chains.
  * Return value is number of devices actually detected. */
-int parport_daisy_init (struct parport *port)
+int parport_daisy_init(struct parport *port)
 {
 	int detected = 0;
 	char *deviceid;
@@ -103,26 +103,26 @@ again:
 
 	/* If mux present on normal port, need to create new
 	 * parports for each extra port. */
-	if (port->muxport < 0 && mux_present (port) &&
+	if (port->muxport < 0 && mux_present(port) &&
 	    /* don't be fooled: a mux must have 2 or 4 ports. */
-	    ((num_ports = num_mux_ports (port)) == 2 || num_ports == 4)) {
+	    ((num_ports = num_mux_ports(port)) == 2 || num_ports == 4)) {
 		/* Leave original as port zero. */
 		port->muxport = 0;
-		printk (KERN_INFO
+		printk(KERN_INFO
 			"%s: 1st (default) port of %d-way multiplexor\n",
 			port->name, num_ports);
 		for (i = 1; i < num_ports; i++) {
 			/* Clone the port. */
-			struct parport *extra = clone_parport (port, i);
+			struct parport *extra = clone_parport(port, i);
 			if (!extra) {
-				if (signal_pending (current))
+				if (signal_pending(current))
 					break;
 
-				schedule ();
+				schedule();
 				continue;
 			}
 
-			printk (KERN_INFO
+			printk(KERN_INFO
 				"%s: %d%s port of %d-way multiplexor on %s\n",
 				extra->name, i + 1, th[i + 1], num_ports,
 				port->name);
@@ -135,34 +135,34 @@ again:
 	}
 
 	if (port->muxport >= 0)
-		select_port (port);
+		select_port(port);
 
-	parport_daisy_deselect_all (port);
-	detected += assign_addrs (port);
+	parport_daisy_deselect_all(port);
+	detected += assign_addrs(port);
 
 	/* Count the potential legacy device at the end. */
-	add_dev (numdevs++, port, -1);
+	add_dev(numdevs++, port, -1);
 
 	/* Find out the legacy device's IEEE 1284 device ID. */
-	deviceid = kmalloc (1024, GFP_KERNEL);
+	deviceid = kmalloc(1024, GFP_KERNEL);
 	if (deviceid) {
-		if (parport_device_id (numdevs - 1, deviceid, 1024) > 2)
+		if (parport_device_id(numdevs - 1, deviceid, 1024) > 2)
 			detected++;
 
-		kfree (deviceid);
+		kfree(deviceid);
 	}
 
 	if (!detected && !last_try) {
 		/* No devices were detected.  Perhaps they are in some
                    funny state; let's try to reset them and see if
                    they wake up. */
-		parport_daisy_fini (port);
-		parport_write_control (port, PARPORT_CONTROL_SELECT);
-		udelay (50);
-		parport_write_control (port,
+		parport_daisy_fini(port);
+		parport_write_control(port, PARPORT_CONTROL_SELECT);
+		udelay(50);
+		parport_write_control(port,
 				       PARPORT_CONTROL_SELECT |
 				       PARPORT_CONTROL_INIT);
-		udelay (50);
+		udelay(50);
 		last_try = 1;
 		goto again;
 	}
@@ -171,7 +171,7 @@ again:
 }
 
 /* Forget about devices on a physical port. */
-void parport_daisy_fini (struct parport *port)
+void parport_daisy_fini(struct parport *port)
 {
 	struct daisydev **p;
 
@@ -214,7 +214,7 @@ void parport_daisy_fini (struct parport 
  *	for parport_register_device().
  **/
 
-struct pardevice *parport_open (int devnum, const char *name,
+struct pardevice *parport_open(int devnum, const char *name,
 				int (*pf) (void *), void (*kf) (void *),
 				void (*irqf) (int, void *, struct pt_regs *),
 				int flags, void *handle)
@@ -237,7 +237,7 @@ struct pardevice *parport_open (int devn
 	port = parport_get_port(p->port);
 	spin_unlock(&topology_lock);
 
-	dev = parport_register_device (port, name, pf, kf,
+	dev = parport_register_device(port, name, pf, kf,
 				       irqf, flags, handle);
 	parport_put_port(port);
 	if (!dev)
@@ -248,13 +248,13 @@ struct pardevice *parport_open (int devn
 	/* Check that there really is a device to select. */
 	if (daisy >= 0) {
 		int selected;
-		parport_claim_or_block (dev);
+		parport_claim_or_block(dev);
 		selected = port->daisy;
-		parport_release (dev);
+		parport_release(dev);
 
 		if (selected != daisy) {
 			/* No corresponding device. */
-			parport_unregister_device (dev);
+			parport_unregister_device(dev);
 			return NULL;
 		}
 	}
@@ -270,9 +270,9 @@ struct pardevice *parport_open (int devn
  *	parport_register_device().
  **/
 
-void parport_close (struct pardevice *dev)
+void parport_close(struct pardevice *dev)
 {
-	parport_unregister_device (dev);
+	parport_unregister_device(dev);
 }
 
 /**
@@ -287,7 +287,7 @@ void parport_close (struct pardevice *de
  *	exists.
  **/
 
-int parport_device_num (int parport, int mux, int daisy)
+int parport_device_num(int parport, int mux, int daisy)
 {
 	int res = -ENXIO;
 	struct daisydev *dev;
@@ -305,16 +305,16 @@ int parport_device_num (int parport, int
 }
 
 /* Send a daisy-chain-style CPP command packet. */
-static int cpp_daisy (struct parport *port, int cmd)
+static int cpp_daisy(struct parport *port, int cmd)
 {
 	unsigned char s;
 
-	parport_data_forward (port);
-	parport_write_data (port, 0xaa); udelay (2);
-	parport_write_data (port, 0x55); udelay (2);
-	parport_write_data (port, 0x00); udelay (2);
-	parport_write_data (port, 0xff); udelay (2);
-	s = parport_read_status (port) & (PARPORT_STATUS_BUSY
+	parport_data_forward(port);
+	parport_write_data(port, 0xaa); udelay(2);
+	parport_write_data(port, 0x55); udelay(2);
+	parport_write_data(port, 0x00); udelay(2);
+	parport_write_data(port, 0xff); udelay(2);
+	s = parport_read_status(port) & (PARPORT_STATUS_BUSY
 					  | PARPORT_STATUS_PAPEROUT
 					  | PARPORT_STATUS_SELECT
 					  | PARPORT_STATUS_ERROR);
@@ -322,54 +322,54 @@ static int cpp_daisy (struct parport *po
 		  | PARPORT_STATUS_PAPEROUT
 		  | PARPORT_STATUS_SELECT
 		  | PARPORT_STATUS_ERROR)) {
-		DPRINTK (KERN_DEBUG "%s: cpp_daisy: aa5500ff(%02x)\n",
+		DPRINTK(KERN_DEBUG "%s: cpp_daisy: aa5500ff(%02x)\n",
 			 port->name, s);
 		return -ENXIO;
 	}
 
-	parport_write_data (port, 0x87); udelay (2);
-	s = parport_read_status (port) & (PARPORT_STATUS_BUSY
+	parport_write_data(port, 0x87); udelay(2);
+	s = parport_read_status(port) & (PARPORT_STATUS_BUSY
 					  | PARPORT_STATUS_PAPEROUT
 					  | PARPORT_STATUS_SELECT
 					  | PARPORT_STATUS_ERROR);
 	if (s != (PARPORT_STATUS_SELECT | PARPORT_STATUS_ERROR)) {
-		DPRINTK (KERN_DEBUG "%s: cpp_daisy: aa5500ff87(%02x)\n",
+		DPRINTK(KERN_DEBUG "%s: cpp_daisy: aa5500ff87(%02x)\n",
 			 port->name, s);
 		return -ENXIO;
 	}
 
-	parport_write_data (port, 0x78); udelay (2);
-	parport_write_data (port, cmd); udelay (2);
-	parport_frob_control (port,
+	parport_write_data(port, 0x78); udelay(2);
+	parport_write_data(port, cmd); udelay(2);
+	parport_frob_control(port,
 			      PARPORT_CONTROL_STROBE,
 			      PARPORT_CONTROL_STROBE);
-	udelay (1);
-	s = parport_read_status (port);
-	parport_frob_control (port, PARPORT_CONTROL_STROBE, 0);
-	udelay (1);
-	parport_write_data (port, 0xff); udelay (2);
+	udelay(1);
+	s = parport_read_status(port);
+	parport_frob_control(port, PARPORT_CONTROL_STROBE, 0);
+	udelay(1);
+	parport_write_data(port, 0xff); udelay(2);
 
 	return s;
 }
 
 /* Send a mux-style CPP command packet. */
-static int cpp_mux (struct parport *port, int cmd)
+static int cpp_mux(struct parport *port, int cmd)
 {
 	unsigned char s;
 	int rc;
 
-	parport_data_forward (port);
-	parport_write_data (port, 0xaa); udelay (2);
-	parport_write_data (port, 0x55); udelay (2);
-	parport_write_data (port, 0xf0); udelay (2);
-	parport_write_data (port, 0x0f); udelay (2);
-	parport_write_data (port, 0x52); udelay (2);
-	parport_write_data (port, 0xad); udelay (2);
-	parport_write_data (port, cmd); udelay (2);
+	parport_data_forward(port);
+	parport_write_data(port, 0xaa); udelay(2);
+	parport_write_data(port, 0x55); udelay(2);
+	parport_write_data(port, 0xf0); udelay(2);
+	parport_write_data(port, 0x0f); udelay(2);
+	parport_write_data(port, 0x52); udelay(2);
+	parport_write_data(port, 0xad); udelay(2);
+	parport_write_data(port, cmd); udelay(2);
 
-	s = parport_read_status (port);
+	s = parport_read_status(port);
 	if (!(s & PARPORT_STATUS_ACK)) {
-		DPRINTK (KERN_DEBUG "%s: cpp_mux: aa55f00f52ad%02x(%02x)\n",
+		DPRINTK(KERN_DEBUG "%s: cpp_mux: aa55f00f52ad%02x(%02x)\n",
 			 port->name, cmd, s);
 		return -EIO;
 	}
@@ -382,12 +382,12 @@ static int cpp_mux (struct parport *port
 	return rc;
 }
 
-void parport_daisy_deselect_all (struct parport *port)
+void parport_daisy_deselect_all(struct parport *port)
 {
-	cpp_daisy (port, 0x30);
+	cpp_daisy(port, 0x30);
 }
 
-int parport_daisy_select (struct parport *port, int daisy, int mode)
+int parport_daisy_select(struct parport *port, int daisy, int mode)
 {
 	switch (mode)
 	{
@@ -395,14 +395,14 @@ int parport_daisy_select (struct parport
 		case IEEE1284_MODE_EPP:
 		case IEEE1284_MODE_EPPSL:
 		case IEEE1284_MODE_EPPSWE:
-			return !(cpp_daisy (port, 0x20 + daisy) &
+			return !(cpp_daisy(port, 0x20 + daisy) &
 				 PARPORT_STATUS_ERROR);
 
 		// For these modes we should switch to ECP mode:
 		case IEEE1284_MODE_ECP:
 		case IEEE1284_MODE_ECPRLE:
 		case IEEE1284_MODE_ECPSWE: 
-			return !(cpp_daisy (port, 0xd0 + daisy) &
+			return !(cpp_daisy(port, 0xd0 + daisy) &
 				 PARPORT_STATUS_ERROR);
 
 		// Nothing was told for BECP in Daisy chain specification.
@@ -413,28 +413,28 @@ int parport_daisy_select (struct parport
 		case IEEE1284_MODE_BYTE:
 		case IEEE1284_MODE_COMPAT:
 		default:
-			return !(cpp_daisy (port, 0xe0 + daisy) &
+			return !(cpp_daisy(port, 0xe0 + daisy) &
 				 PARPORT_STATUS_ERROR);
 	}
 }
 
-static int mux_present (struct parport *port)
+static int mux_present(struct parport *port)
 {
-	return cpp_mux (port, 0x51) == 3;
+	return cpp_mux(port, 0x51) == 3;
 }
 
-static int num_mux_ports (struct parport *port)
+static int num_mux_ports(struct parport *port)
 {
-	return cpp_mux (port, 0x58);
+	return cpp_mux(port, 0x58);
 }
 
-static int select_port (struct parport *port)
+static int select_port(struct parport *port)
 {
 	int muxport = port->muxport;
-	return cpp_mux (port, 0x60 + muxport) == muxport;
+	return cpp_mux(port, 0x60 + muxport) == muxport;
 }
 
-static int assign_addrs (struct parport *port)
+static int assign_addrs(struct parport *port)
 {
 	unsigned char s;
 	unsigned char daisy;
@@ -442,12 +442,12 @@ static int assign_addrs (struct parport 
 	int detected;
 	char *deviceid;
 
-	parport_data_forward (port);
-	parport_write_data (port, 0xaa); udelay (2);
-	parport_write_data (port, 0x55); udelay (2);
-	parport_write_data (port, 0x00); udelay (2);
-	parport_write_data (port, 0xff); udelay (2);
-	s = parport_read_status (port) & (PARPORT_STATUS_BUSY
+	parport_data_forward(port);
+	parport_write_data(port, 0xaa); udelay(2);
+	parport_write_data(port, 0x55); udelay(2);
+	parport_write_data(port, 0x00); udelay(2);
+	parport_write_data(port, 0xff); udelay(2);
+	s = parport_read_status(port) & (PARPORT_STATUS_BUSY
 					  | PARPORT_STATUS_PAPEROUT
 					  | PARPORT_STATUS_SELECT
 					  | PARPORT_STATUS_ERROR);
@@ -455,40 +455,40 @@ static int assign_addrs (struct parport 
 		  | PARPORT_STATUS_PAPEROUT
 		  | PARPORT_STATUS_SELECT
 		  | PARPORT_STATUS_ERROR)) {
-		DPRINTK (KERN_DEBUG "%s: assign_addrs: aa5500ff(%02x)\n",
+		DPRINTK(KERN_DEBUG "%s: assign_addrs: aa5500ff(%02x)\n",
 			 port->name, s);
 		return 0;
 	}
 
-	parport_write_data (port, 0x87); udelay (2);
-	s = parport_read_status (port) & (PARPORT_STATUS_BUSY
+	parport_write_data(port, 0x87); udelay(2);
+	s = parport_read_status(port) & (PARPORT_STATUS_BUSY
 					  | PARPORT_STATUS_PAPEROUT
 					  | PARPORT_STATUS_SELECT
 					  | PARPORT_STATUS_ERROR);
 	if (s != (PARPORT_STATUS_SELECT | PARPORT_STATUS_ERROR)) {
-		DPRINTK (KERN_DEBUG "%s: assign_addrs: aa5500ff87(%02x)\n",
+		DPRINTK(KERN_DEBUG "%s: assign_addrs: aa5500ff87(%02x)\n",
 			 port->name, s);
 		return 0;
 	}
 
-	parport_write_data (port, 0x78); udelay (2);
-	s = parport_read_status (port);
+	parport_write_data(port, 0x78); udelay(2);
+	s = parport_read_status(port);
 
 	for (daisy = 0;
 	     (s & (PARPORT_STATUS_PAPEROUT|PARPORT_STATUS_SELECT))
 		     == (PARPORT_STATUS_PAPEROUT|PARPORT_STATUS_SELECT)
 		     && daisy < 4;
 	     ++daisy) {
-		parport_write_data (port, daisy);
-		udelay (2);
-		parport_frob_control (port,
+		parport_write_data(port, daisy);
+		udelay(2);
+		parport_frob_control(port,
 				      PARPORT_CONTROL_STROBE,
 				      PARPORT_CONTROL_STROBE);
-		udelay (1);
-		parport_frob_control (port, PARPORT_CONTROL_STROBE, 0);
-		udelay (1);
+		udelay(1);
+		parport_frob_control(port, PARPORT_CONTROL_STROBE, 0);
+		udelay(1);
 
-		add_dev (numdevs++, port, daisy);
+		add_dev(numdevs++, port, daisy);
 
 		/* See if this device thought it was the last in the
 		 * chain. */
@@ -499,21 +499,21 @@ static int assign_addrs (struct parport 
 		   last_dev from next device or if last_dev does not
 		   work status lines from some non-daisy chain
 		   device. */
-		s = parport_read_status (port);
+		s = parport_read_status(port);
 	}
 
-	parport_write_data (port, 0xff); udelay (2);
+	parport_write_data(port, 0xff); udelay(2);
 	detected = numdevs - thisdev;
-	DPRINTK (KERN_DEBUG "%s: Found %d daisy-chained devices\n", port->name,
+	DPRINTK(KERN_DEBUG "%s: Found %d daisy-chained devices\n", port->name,
 		 detected);
 
 	/* Ask the new devices to introduce themselves. */
-	deviceid = kmalloc (1024, GFP_KERNEL);
+	deviceid = kmalloc(1024, GFP_KERNEL);
 	if (!deviceid) return 0;
 
 	for (daisy = 0; thisdev < numdevs; thisdev++, daisy++)
-		parport_device_id (thisdev, deviceid, 1024);
+		parport_device_id(thisdev, deviceid, 1024);
 
-	kfree (deviceid);
+	kfree(deviceid);
 	return detected;
 }



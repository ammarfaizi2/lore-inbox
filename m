Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbUCWARu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 19:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbUCWARu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 19:17:50 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:28386 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S261673AbUCWARY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 19:17:24 -0500
Date: Tue, 23 Mar 2004 11:17:07 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] PPC64 iSeries kernel messages cleanup
Message-Id: <20040323111707.65ab4d9d.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__23_Mar_2004_11_17_07_+1100_Ev9mWiKifsv+ZcC3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__23_Mar_2004_11_17_07_+1100_Ev9mWiKifsv+ZcC3
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Andrew, Linus,

This patch just cleans up and makes more consistent the messages
produced by some of the iSeries virtual device drivers.  It also
make them less verbose.

Please apply.  Patch applies to 2.6.5-rc2-bk2

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN ppc64-linux-2.5/arch/ppc64/kernel/viopath.c ppc64-linux-2.5.msg/arch/ppc64/kernel/viopath.c
--- ppc64-linux-2.5/arch/ppc64/kernel/viopath.c	2004-03-17 14:12:38.000000000 +1100
+++ ppc64-linux-2.5.msg/arch/ppc64/kernel/viopath.c	2004-03-19 18:10:24.000000000 +1100
@@ -105,6 +105,9 @@
  */
 static vio_event_handler_t *vio_handler[VIO_MAX_SUBTYPES];
 
+#define VIOPATH_KERN_WARN	KERN_WARNING "viopath: "
+#define VIOPATH_KERN_INFO	KERN_INFO "viopath: "
+
 static unsigned char e2a(unsigned char x)
 {
 	switch (x) {
@@ -209,7 +212,7 @@
 			((u64)handle) << 32, PAGE_SIZE, 0, 0);
 
 	if (hvrc != HvLpEvent_Rc_Good)
-		printk("viopath hv error on op %d\n", (int)hvrc);
+		printk(VIOPATH_KERN_WARN "hv error on op %d\n", (int)hvrc);
 
 	down(&Semaphore);
 
@@ -318,7 +321,7 @@
 	if (hvrc == HvLpEvent_Rc_Good)
 		viopathStatus[remoteLp].isActive = 1;
 	else {
-		printk(KERN_WARNING_VIO "could not connect to partition %d\n",
+		printk(VIOPATH_KERN_WARN "could not connect to partition %d\n",
 				remoteLp);
 		viopathStatus[remoteLp].isActive = 0;
 	}
@@ -355,11 +358,11 @@
 	remoteLp = event->xTargetLp;
 	if ((event->xSourceInstanceId != viopathStatus[remoteLp].mSourceInst) ||
 	    (event->xTargetInstanceId != viopathStatus[remoteLp].mTargetInst)) {
-		printk(KERN_WARNING_VIO "ignoring ack....mismatched instances\n");
+		printk(VIOPATH_KERN_WARN "ignoring ack....mismatched instances\n");
 		return;
 	}
 
-	printk(KERN_WARNING_VIO "partition %d ended\n", remoteLp);
+	printk(VIOPATH_KERN_WARN "partition %d ended\n", remoteLp);
 
 	viopathStatus[remoteLp].isActive = 0;
 
@@ -403,7 +406,7 @@
 	if (!event)
 		return;
 	if (event->xFlags.xFunction == HvLpEvent_Function_Int) {
-		printk(KERN_WARNING_VIO
+		printk(VIOPATH_KERN_WARN
 		       "unexpected config request from partition %d",
 		       event->xSourceLp);
 
@@ -461,7 +464,7 @@
 		if (viopathStatus[remoteLp].isActive
 		    && (event->xSourceInstanceId !=
 			viopathStatus[remoteLp].mTargetInst)) {
-			printk(KERN_WARNING_VIO
+			printk(VIOPATH_KERN_WARN
 			       "message from invalid partition. "
 			       "int msg rcvd, source inst (%d) doesnt match (%d)\n",
 			       viopathStatus[remoteLp].mTargetInst,
@@ -472,7 +475,7 @@
 		if (viopathStatus[remoteLp].isActive
 		    && (event->xTargetInstanceId !=
 			viopathStatus[remoteLp].mSourceInst)) {
-			printk(KERN_WARNING_VIO
+			printk(VIOPATH_KERN_WARN
 			       "message from invalid partition. "
 			       "int msg rcvd, target inst (%d) doesnt match (%d)\n",
 			       viopathStatus[remoteLp].mSourceInst,
@@ -483,7 +486,7 @@
 		remoteLp = event->xTargetLp;
 		if (event->xSourceInstanceId !=
 		    viopathStatus[remoteLp].mSourceInst) {
-			printk(KERN_WARNING_VIO
+			printk(VIOPATH_KERN_WARN
 			       "message from invalid partition. "
 			       "ack msg rcvd, source inst (%d) doesnt match (%d)\n",
 			       viopathStatus[remoteLp].mSourceInst,
@@ -493,7 +496,7 @@
 
 		if (event->xTargetInstanceId !=
 		    viopathStatus[remoteLp].mTargetInst) {
-			printk(KERN_WARNING_VIO
+			printk(VIOPATH_KERN_WARN
 			       "message from invalid partition. "
 			       "viopath: ack msg rcvd, target inst (%d) doesnt match (%d)\n",
 			       viopathStatus[remoteLp].mTargetInst,
@@ -503,7 +506,7 @@
 	}
 
 	if (vio_handler[subtype] == NULL) {
-		printk(KERN_WARNING_VIO
+		printk(VIOPATH_KERN_WARN
 		       "unexpected virtual io event subtype %d from partition %d\n",
 		       event->xSubtype, remoteLp);
 		/* No handler.  Ack if necessary */
@@ -608,10 +611,10 @@
 		HvLpEvent_registerHandler(HvLpEvent_Type_VirtualIo,
 					  &vio_handleEvent);
 		sendMonMsg(remoteLp);
-		printk(KERN_INFO_VIO
-		       "Opening connection to partition %d, setting sinst %d, tinst %d\n",
-		       remoteLp, viopathStatus[remoteLp].mSourceInst,
-		       viopathStatus[remoteLp].mTargetInst);
+		printk(VIOPATH_KERN_INFO "opening connection to partition %d, "
+				"setting sinst %d, tinst %d\n",
+				remoteLp, viopathStatus[remoteLp].mSourceInst,
+				viopathStatus[remoteLp].mTargetInst);
 	}
 
 	spin_unlock_irqrestore(&statuslock, flags);
@@ -662,7 +665,7 @@
 		numOpen += viopathStatus[remoteLp].users[i];
 
 	if ((viopathStatus[remoteLp].isOpen) && (numOpen == 0)) {
-		printk(KERN_INFO_VIO "Closing connection to partition %d",
+		printk(VIOPATH_KERN_INFO "closing connection to partition %d",
 				remoteLp);
 
 		HvCallEvent_closeLpEventPath(remoteLp,
@@ -696,23 +699,21 @@
 {
 	subtype = subtype >> VIOMAJOR_SUBTYPE_SHIFT;
 	if ((subtype < 0) || (subtype >= VIO_MAX_SUBTYPES)) {
-		printk(KERN_WARNING_VIO
-		       "unexpected subtype %d freeing event buffer\n",
-		       subtype);
+		printk(VIOPATH_KERN_WARN
+		       "unexpected subtype %d freeing event buffer\n", subtype);
 		return;
 	}
 
 	if (atomic_read(&event_buffer_available[subtype]) != 0) {
-		printk(KERN_WARNING_VIO
+		printk(VIOPATH_KERN_WARN
 		       "freeing unallocated event buffer, subtype %d\n",
 		       subtype);
 		return;
 	}
 
 	if (buffer != &event_buffer[subtype * 256]) {
-		printk(KERN_WARNING_VIO
-		       "freeing invalid event buffer, subtype %d\n",
-		       subtype);
+		printk(VIOPATH_KERN_WARN
+		       "freeing invalid event buffer, subtype %d\n", subtype);
 	}
 
 	atomic_set(&event_buffer_available[subtype], 1);
diff -ruN ppc64-linux-2.5/drivers/char/viocons.c ppc64-linux-2.5.msg/drivers/char/viocons.c
--- ppc64-linux-2.5/drivers/char/viocons.c	2004-03-13 15:05:15.000000000 +1100
+++ ppc64-linux-2.5.msg/drivers/char/viocons.c	2004-03-19 18:10:24.000000000 +1100
@@ -9,7 +9,7 @@
  *           Colin Devilbiss <devilbis@us.ibm.com>
  *           Stephen Rothwell <sfr@au1.ibm.com>
  *
- * (C) Copyright 2000, 2001, 2002, 2003 IBM Corporation
+ * (C) Copyright 2000, 2001, 2002, 2003, 2004 IBM Corporation
  *
  * This program is free software;  you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
@@ -59,6 +59,9 @@
 #define VTTY_PORTS 10
 #define VIOTTY_SERIAL_START 65
 
+#define VIOCONS_KERN_WARN	KERN_WARNING "viocons: "
+#define VIOCONS_KERN_INFO	KERN_INFO "viocons: "
+
 static spinlock_t consolelock = SPIN_LOCK_UNLOCKED;
 static spinlock_t consoleloglock = SPIN_LOCK_UNLOCKED;
 
@@ -189,10 +192,10 @@
 static inline int viotty_paranoia_check(struct port_info *pi,
 					char *name, const char *routine)
 {
-	static const char *bad_pi_addr = KERN_WARNING_VIO
-		"Warning: bad address for port_info struct (%s) in %s\n";
-	static const char *badmagic = KERN_WARNING_VIO
-		"Warning: bad magic number for port_info struct (%s) in %s\n";
+	static const char *bad_pi_addr = VIOCONS_KERN_WARN
+		"warning: bad address for port_info struct (%s) in %s\n";
+	static const char *badmagic = VIOCONS_KERN_WARN
+		"warning: bad magic number for port_info struct (%s) in %s\n";
 
 	if ((pi < &port_info[0]) || (viochar_port(pi) > VTTY_PORTS)) {
 		printk(bad_pi_addr, name, routine);
@@ -395,8 +398,8 @@
 			vio_free_event_buffer(viomajorsubtype_chario, viochar);
 			spin_unlock_irqrestore(&consolelock, flags);
 
-			printk(KERN_WARNING_VIO
-			       "console error sending event! return code %d\n",
+			printk(VIOCONS_KERN_WARN
+			       "error sending event! return code %d\n",
 			       (int)hvrc);
 			return;
 		}
@@ -692,8 +695,8 @@
 	/* If some other TTY is already connected here, reject the open */
 	if ((pi->tty) && (pi->tty != tty)) {
 		spin_unlock_irqrestore(&consolelock, flags);
-		printk(KERN_WARNING_VIO
-		       "console attempt to open device twice from different ttys\n");
+		printk(VIOCONS_KERN_WARN
+		       "attempt to open device twice from different ttys\n");
 		return -EBUSY;
 	}
 	tty->driver_data = pi;
@@ -964,23 +967,22 @@
 
 		spin_unlock_irqrestore(&consolelock, flags);
 		if (event->xRc != HvLpEvent_Rc_Good)
-			printk(KERN_WARNING_VIO
-			       "viocons: event->xRc != HvLpEvent_Rc_Good, event->xRc == (%d).\n",
+			printk(VIOCONS_KERN_WARN
+			       "handle_open_event: event->xRc == (%d).\n",
 			       event->xRc);
 
 		if (event->xCorrelationToken != 0) {
 			atomic_t *aptr= (atomic_t *)event->xCorrelationToken;
 			atomic_set(aptr, 1);
 		} else
-			printk(KERN_WARNING_VIO
-			       "viocons: wierd...got open ack without atomic\n");
+			printk(VIOCONS_KERN_WARN
+			       "wierd...got open ack without atomic\n");
 		return;
 	}
 
 	/* This had better require an ack, otherwise complain */
 	if (event->xFlags.xAckInd != HvLpEvent_AckInd_DoAck) {
-		printk(KERN_WARNING_VIO
-		       "console: viocharopen without ack bit!\n");
+		printk(VIOCONS_KERN_WARN "viocharopen without ack bit!\n");
 		return;
 	}
 
@@ -1019,11 +1021,10 @@
 	spin_unlock_irqrestore(&consolelock, flags);
 
 	if (reject == 1)
-		printk(KERN_WARNING_VIO
-			"viocons: console open rejected : bad virtual tty.\n");
+		printk(VIOCONS_KERN_WARN "open rejected: bad virtual tty.\n");
 	else if (reject == 2)
-		printk(KERN_WARNING_VIO
-			"viocons: console open rejected : console in exclusive use by another partition.\n");
+		printk(VIOCONS_KERN_WARN
+			"open rejected: console in exclusive use by another partition.\n");
 
 	/* Return the acknowledgement */
 	HvCallEvent_ackLpEvent(event);
@@ -1050,7 +1051,8 @@
 
 	if (event->xFlags.xFunction == HvLpEvent_Function_Int) {
 		if (port >= VTTY_PORTS) {
-			printk(KERN_WARNING_VIO "viocons: close message from invalid virtual device.\n");
+			printk(VIOCONS_KERN_WARN
+					"close message from invalid virtual device.\n");
 			return;
 		}
 
@@ -1062,11 +1064,10 @@
 			port_info[port].lp = HvLpIndexInvalid;
 
 		spin_unlock_irqrestore(&consolelock, flags);
-		printk(KERN_INFO_VIO
-		       "console close from %d\n", event->xSourceLp);
+		printk(VIOCONS_KERN_INFO "close from %d\n", event->xSourceLp);
 	} else
-		printk(KERN_WARNING_VIO
-		       "console got unexpected close acknowlegement\n");
+		printk(VIOCONS_KERN_WARN
+				"got unexpected close acknowlegement\n");
 }
 
 /*
@@ -1079,12 +1080,11 @@
 	HvCall_writeLogBuffer(cevent->data, cevent->len);
 
 	if (cevent->data[0] == 0x01)
-		printk(KERN_INFO_VIO
-		       "console window resized to %d: %d: %d: %d\n",
+		printk(VIOCONS_KERN_INFO "window resized to %d: %d: %d: %d\n",
 		       cevent->data[1], cevent->data[2],
 		       cevent->data[3], cevent->data[4]);
 	else
-		printk(KERN_WARNING_VIO "console unknown config event\n");
+		printk(VIOCONS_KERN_WARN "unknown config event\n");
 }
 
 /*
@@ -1100,8 +1100,8 @@
 	u8 port = cevent->virtual_device;
 
 	if (port >= VTTY_PORTS) {
-		printk(KERN_WARNING_VIO
-		       "console data on invalid virtual device %d\n", port);
+		printk(VIOCONS_KERN_WARN "data on invalid virtual device %d\n",
+				port);
 		return;
 	}
 
@@ -1130,13 +1130,14 @@
 	tty = pi->tty;
 	if (tty == NULL) {
 		spin_unlock_irqrestore(&consolelock, flags);
-		printk(KERN_WARNING_VIO "no tty for virtual device %d\n", port);
+		printk(VIOCONS_KERN_WARN "no tty for virtual device %d\n",
+				port);
 		return;
 	}
 
 	if (tty->magic != TTY_MAGIC) {
 		spin_unlock_irqrestore(&consolelock, flags);
-		printk(KERN_WARNING_VIO "tty bad magic\n");
+		printk(VIOCONS_KERN_WARN "tty bad magic\n");
 		return;
 	}
 
@@ -1186,8 +1187,7 @@
 		 * have room for because it would fail without indication.
 		 */
 		if ((tty->flip.count + 1) > TTY_FLIPBUF_SIZE) {
-			printk(KERN_WARNING_VIO
-					"console input buffer overflow!\n");
+			printk(VIOCONS_KERN_WARN "input buffer overflow!\n");
 			break;
 		}
 		tty_insert_flip_char(tty, cevent->data[index], TTY_NORMAL);
@@ -1209,8 +1209,7 @@
 	u8 port = cevent->virtual_device;
 
 	if (port >= VTTY_PORTS) {
-		printk(KERN_WARNING_VIO
-		       "viocons: data on invalid virtual device\n");
+		printk(VIOCONS_KERN_WARN "data on invalid virtual device\n");
 		return;
 	}
 
@@ -1299,14 +1298,11 @@
 	atomic_t wait_flag;
 	int rc;
 
-	/* Now open to the primary LP */
-	printk(KERN_INFO_VIO "console open path to primary\n");
 	/* +2 for fudge */
 	rc = viopath_open(HvLpConfig_getPrimaryLpIndex(),
 			viomajorsubtype_chario, VIOCHAR_WINDOW + 2);
 	if (rc)
-		printk(KERN_WARNING_VIO "console error opening to primary %d\n",
-				rc);
+		printk(VIOCONS_KERN_WARN "error opening to primary %d\n", rc);
 
 	if (viopath_hostLp == HvLpIndexInvalid)
 		vio_set_hostlp();
@@ -1317,30 +1313,28 @@
 	 */
 	if ((viopath_hostLp != HvLpIndexInvalid) &&
 	    (viopath_hostLp != HvLpConfig_getPrimaryLpIndex())) {
-		printk(KERN_INFO_VIO "console open path to hosting (%d)\n",
+		printk(VIOCONS_KERN_INFO "open path to hosting (%d)\n",
 				viopath_hostLp);
 		rc = viopath_open(viopath_hostLp, viomajorsubtype_chario,
 				VIOCHAR_WINDOW + 2);	/* +2 for fudge */
 		if (rc)
-			printk(KERN_WARNING_VIO
-				"console error opening to partition %d: %d\n",
+			printk(VIOCONS_KERN_WARN
+				"error opening to partition %d: %d\n",
 				viopath_hostLp, rc);
 	}
 
 	if (vio_setHandler(viomajorsubtype_chario, vioHandleCharEvent) < 0)
-		printk(KERN_WARNING_VIO
-				"Error seting handler for console events!\n");
-
-	printk(KERN_INFO_VIO "console major number is %d\n", TTY_MAJOR);
+		printk(VIOCONS_KERN_WARN
+				"error seting handler for console events!\n");
 
-	/* First, try to open the console to the hosting lp.
+	/*
+	 * First, try to open the console to the hosting lp.
 	 * Wait on a semaphore for the response.
 	 */
 	atomic_set(&wait_flag, 0);
 	if ((viopath_isactive(viopath_hostLp)) &&
 	    (send_open(viopath_hostLp, (void *)&wait_flag) == 0)) {
-		printk(KERN_INFO_VIO
-			"opening console to hosting partition %d\n",
+		printk(VIOCONS_KERN_INFO "hosting partition %d\n",
 			viopath_hostLp);
 		while (atomic_read(&wait_flag) == 0)
 			mb();
@@ -1354,7 +1348,7 @@
 	    (viopath_isactive(HvLpConfig_getPrimaryLpIndex())) &&
 	    (send_open(HvLpConfig_getPrimaryLpIndex(), (void *)&wait_flag)
 	     == 0)) {
-		printk(KERN_INFO_VIO "opening console to primary partition\n");
+		printk(VIOCONS_KERN_INFO "opening console to primary partition\n");
 		while (atomic_read(&wait_flag) == 0)
 			mb();
 	}
@@ -1388,13 +1382,13 @@
 	tty_set_operations(viottyS_driver, &serial_ops);
 
 	if (tty_register_driver(viotty_driver)) {
-		printk(KERN_WARNING_VIO "Couldn't register console driver\n");
+		printk(VIOCONS_KERN_WARN "couldn't register console driver\n");
 		put_tty_driver(viotty_driver);
 		viotty_driver = NULL;
 	}
 
 	if (tty_register_driver(viottyS_driver)) {
-		printk(KERN_WARNING_VIO "Couldn't register console S driver\n");
+		printk(VIOCONS_KERN_WARN "couldn't register console S driver\n");
 		put_tty_driver(viottyS_driver);
 		viottyS_driver = NULL;
 	}
@@ -1411,7 +1405,7 @@
 {
 	int i;
 
-	printk(KERN_INFO_VIO "registering console\n");
+	printk(VIOCONS_KERN_INFO "registering console\n");
 	for (i = 0; i < VTTY_PORTS; i++) {
 		port_info[i].lp = HvLpIndexInvalid;
 		port_info[i].magic = VIOTTY_MAGIC;
diff -ruN ppc64-linux-2.5/drivers/char/viotape.c ppc64-linux-2.5.msg/drivers/char/viotape.c
--- ppc64-linux-2.5/drivers/char/viotape.c	2004-03-18 19:12:18.000000000 +1100
+++ ppc64-linux-2.5.msg/drivers/char/viotape.c	2004-03-19 18:10:24.000000000 +1100
@@ -913,8 +913,6 @@
 	char tapename[32];
 	int i;
 
-	printk(VIOTAPE_KERN_INFO "driver version " VIOTAPE_VERSION "\n");
-
 	op_struct_list = NULL;
 	if ((ret = add_op_structs(VIOTAPE_MAXREQ)) < 0) {
 		printk(VIOTAPE_KERN_WARN "couldn't allocate op structs\n");
@@ -932,8 +930,6 @@
 		}
 	}
 
-	printk(VIOTAPE_KERN_INFO "init - open path to hosting (%d)\n",
-			viopath_hostLp);
 	ret = viopath_open(viopath_hostLp, viomajorsubtype_tape,
 			VIOTAPE_MAXREQ + 2);
 	if (ret) {
@@ -943,6 +939,9 @@
 		goto clear_op;
 	}
 
+	printk(VIOTAPE_KERN_INFO "vers " VIOTAPE_VERSION
+			", hosting partition %d\n", viopath_hostLp);
+
 	vio_setHandler(viomajorsubtype_tape, vioHandleTapeEvent);
 
 	ret = register_chrdev(VIOTAPE_MAJOR, "viotape", &viotap_fops);
diff -ruN ppc64-linux-2.5/include/asm-ppc64/iSeries/vio.h ppc64-linux-2.5.msg/include/asm-ppc64/iSeries/vio.h
--- ppc64-linux-2.5/include/asm-ppc64/iSeries/vio.h	2004-03-08 12:04:44.000000000 +1100
+++ ppc64-linux-2.5.msg/include/asm-ppc64/iSeries/vio.h	2004-03-19 18:10:25.000000000 +1100
@@ -70,11 +70,6 @@
 extern HvLpIndex viopath_hostLp;
 extern HvLpIndex viopath_ourLp;
 
-#define VIO_MESSAGE "iSeries virtual I/O: "
-#define KERN_DEBUG_VIO KERN_DEBUG VIO_MESSAGE
-#define KERN_INFO_VIO KERN_INFO VIO_MESSAGE
-#define KERN_WARNING_VIO KERN_WARNING VIO_MESSAGE
-
 #define VIOCHAR_MAX_DATA 200
 
 #define VIOMAJOR_SUBTYPE_MASK 0xff00
@@ -84,11 +79,11 @@
 #define VIOVERSION            0x0101
 
 /*
-This is the general structure for VIO errors; each module should have a table
-of them, and each table should be terminated by an entry of { 0, 0, NULL }.
-Then, to find a specific error message, a module should pass its local table
-and the return code.
-*/
+ * This is the general structure for VIO errors; each module should have
+ * a table of them, and each table should be terminated by an entry of
+ * { 0, 0, NULL }.  Then, to find a specific error message, a module
+ * should pass its local table and the return code.
+ */
 struct vio_error_entry {
 	u16 rc;
 	int errno;

--Signature=_Tue__23_Mar_2004_11_17_07_+1100_Ev9mWiKifsv+ZcC3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAX4IDFG47PeJeR58RAokcAKCf30aLF/95A3N8GjpkifosPE+trgCgw3gE
ibFXls6kqTmFeAItMfDWunI=
=V/Wv
-----END PGP SIGNATURE-----

--Signature=_Tue__23_Mar_2004_11_17_07_+1100_Ev9mWiKifsv+ZcC3--

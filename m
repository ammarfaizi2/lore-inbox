Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269255AbRGaLNz>; Tue, 31 Jul 2001 07:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269256AbRGaLNq>; Tue, 31 Jul 2001 07:13:46 -0400
Received: from pop.gmx.net ([194.221.183.20]:41718 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S269255AbRGaLNg>;
	Tue, 31 Jul 2001 07:13:36 -0400
X-Sieve: cmu-sieve 2.0
Content-Type: Multipart/Mixed;
  charset="iso-8859-1";
  boundary="------------Boundary-00=_BF4CTT4WBY30QX12DPTT"
From: Andreas Bauer <akbauer@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/sound/esssolo1.c glitch?!
Date: Tue, 31 Jul 2001 13:11:35 +0200
X-Mailer: KMail [version 1.2]
Cc: t.sailer@alumni.ethz.ch
MIME-Version: 1.0
Reply-To: baueran@in.tum.de
Message-Id: <01073113113508.01137@funnelweb>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


--------------Boundary-00=_BF4CTT4WBY30QX12DPTT
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hello Thomas, (and kernel list)

   When I tried to compile 2.4.7 today with support for my ESS Techn. ES 1988 
Allegro-1 sound card, the linker came up with a few errors concerning 
undefined function references in sounddrivers.o

   Therefore I modified your file drivers/sound/esssolo1.c slightly in order 
to resolve these reference problems. Please find my modifications as 
attachment to this e-mail. It's only a few lines and I hope you as well as 
others consider them a useful contribution anyway.

   I'd be grateful to hear some feedback on this.

   - Andreas
--------------Boundary-00=_BF4CTT4WBY30QX12DPTT
Content-Type: text/x-c;
  charset="iso-8859-1";
  name="esssolo_patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="esssolo_patch"

--- esssolo1.ORIGINAL	Sat Jul 28 16:16:47 2001
+++ esssolo1.c	Sat Jul 28 16:20:24 2001
@@ -82,6 +82,9 @@
  *    22.05.2001   0.19  more cleanups, changed PM to PCI 2.4 style, got rid
  *                       of global list of devices, using pci device data.
  *                       Marcus Meissner <mm@caldera.de>
+ *    28.07.2001   0.20  Added definitions for external functions
+ *                       gameport_register_port, gameport_unregister_port
+ *                       Andreas Bauer <baueran@in.tum.de>
  */
 
 /*****************************************************************************/
@@ -106,7 +109,21 @@
 #include <linux/wrapper.h>
 #include <asm/uaccess.h>
 #include <asm/hardirq.h>
+
+#if defined(CONFIG_INPUT_ANALOG) || defined(CONFIG_INPUT_ANALOG_MODULE)
 #include <linux/gameport.h>
+#else
+struct gameport {
+	int io;
+	int size;
+};
+ 
+extern inline void gameport_register_port(struct gameport *gameport) {
+}
+ 
+extern inline void gameport_unregister_port(struct gameport *gameport) {
+}
+#endif
 
 #include "dm.h"
 

--------------Boundary-00=_BF4CTT4WBY30QX12DPTT--

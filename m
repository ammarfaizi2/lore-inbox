Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265726AbTFNUc6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 16:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265730AbTFNUcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 16:32:15 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:24810 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265726AbTFNUaM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 16:30:12 -0400
Date: Sat, 14 Jun 2003 22:43:58 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] input: Fix i8042 interrupts on I2000 ia64 machines  [9/13]
Message-ID: <20030614224358.H25997@ucw.cz>
References: <20030614223513.A25948@ucw.cz> <20030614223629.A25997@ucw.cz> <20030614223708.B25997@ucw.cz> <20030614223934.C25997@ucw.cz> <20030614224022.D25997@ucw.cz> <20030614224052.E25997@ucw.cz> <20030614224149.F25997@ucw.cz> <20030614224253.G25997@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030614224253.G25997@ucw.cz>; from vojtech@suse.cz on Sat, Jun 14, 2003 at 10:42:53PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1215.104.26, 2003-06-09 14:54:00+02:00, peter@chubb.wattle.id.au
  input: The appended fix is needed on I2000 machines, to map the
  legacy ISA interrupt onto the actual interrupt provided.  Otherwise
  the mouse and keyboard won't work.  Patch against 2.5.70.


 i8042-io.h |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

===================================================================

diff -Nru a/drivers/input/serio/i8042-io.h b/drivers/input/serio/i8042-io.h
--- a/drivers/input/serio/i8042-io.h	Sat Jun 14 22:23:45 2003
+++ b/drivers/input/serio/i8042-io.h	Sat Jun 14 22:23:45 2003
@@ -20,11 +20,14 @@
  */
 
 #ifdef __alpha__
-#define I8042_KBD_IRQ	1
-#define I8042_AUX_IRQ	(RTC_PORT(0) == 0x170 ? 9 : 12)	/* Jensen is special */
+# define I8042_KBD_IRQ	1
+# define I8042_AUX_IRQ	(RTC_PORT(0) == 0x170 ? 9 : 12)	/* Jensen is special */
+#elif defined(__ia64__)
+# define I8042_KBD_IRQ isa_irq_to_vector(1)
+# define I8042_AUX_IRQ isa_irq_to_vector(12)
 #else
-#define I8042_KBD_IRQ	1
-#define I8042_AUX_IRQ	12
+# define I8042_KBD_IRQ	1
+# define I8042_AUX_IRQ	12
 #endif
 
 /*

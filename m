Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129359AbRDGShD>; Sat, 7 Apr 2001 14:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129164AbRDGSgx>; Sat, 7 Apr 2001 14:36:53 -0400
Received: from [194.213.32.137] ([194.213.32.137]:3332 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129292AbRDGSgr>;
	Sat, 7 Apr 2001 14:36:47 -0400
Message-ID: <20010405000215.A599@bug.ucw.cz>
Date: Thu, 5 Apr 2001 00:02:15 +0200
From: Pavel Machek <pavel@suse.cz>
To: andrew.grover@intel.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Let init know user wants to shutdown
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Init should get to know that user pressed power button (so it can do
shutdown and poweroff). Plus, it is nice to let user know that we can
read such event. [I hunted bug for few hours, thinking that kernel
does not get the event at all].

Here's patch to do that. Please apply,
								Pavel

diff -urb -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinu?* -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak clean/drivers/acpi/events/evevent.c linux/drivers/acpi/events/evevent.c
--- clean/drivers/acpi/events/evevent.c	Sun Apr  1 00:22:57 2001
+++ linux/drivers/acpi/events/evevent.c	Wed Apr  4 01:08:11 2001
@@ -30,6 +30,8 @@
 #include "acnamesp.h"
 #include "accommon.h"
 
+#include <linux/signal.h>
+
 #define _COMPONENT          EVENT_HANDLING
 	 MODULE_NAME         ("evevent")
 
@@ -197,14 +172,18 @@
 	if ((status_register & ACPI_STATUS_POWER_BUTTON) &&
 		(enable_register & ACPI_ENABLE_POWER_BUTTON))
 	{
+		printk ("acpi: Power button pressed!\n");
+		kill_proc (1, SIGTERM, 1);
 		int_status |= acpi_ev_fixed_event_dispatch (ACPI_EVENT_POWER_BUTTON);
 	}
 
+
 	/* sleep button event */
 
 	if ((status_register & ACPI_STATUS_SLEEP_BUTTON) &&
 		(enable_register & ACPI_ENABLE_SLEEP_BUTTON))
 	{
+		printk("acpi: Sleep button pressed!\n");
 		int_status |= acpi_ev_fixed_event_dispatch (ACPI_EVENT_SLEEP_BUTTON);
 	}
 

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org

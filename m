Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267569AbUBSVIt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 16:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267386AbUBSVIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 16:08:49 -0500
Received: from witte.sonytel.be ([80.88.33.193]:20174 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S267317AbUBSVIi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 16:08:38 -0500
Date: Thu, 19 Feb 2004 22:08:29 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Corey Minyard <minyard@wf-rch.cirr.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] IPMI warnings
Message-ID: <Pine.GSO.4.58.0402192202370.13856@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Corey,

When compiling the IPMI drivers on m68k, I needed a few more includes:
  - <asm/irq.h> (for disable_irq_nosync() and enable_irq())
  - <linux/types.h> (for size_t)
  - <asm/system.h> (for printk())

--- linux-2.6.3/drivers/char/ipmi/ipmi_kcs_intf.c	2003-08-24 09:49:00.000000000 +0200
+++ linux-m68k-2.6.3/drivers/char/ipmi/ipmi_kcs_intf.c	2004-02-15 14:48:15.000000000 +0100
@@ -55,6 +55,7 @@
 #include <linux/rcupdate.h>
 #include <linux/ipmi_smi.h>
 #include <asm/io.h>
+#include <asm/irq.h>
 #include "ipmi_kcs_sm.h"
 #include <linux/init.h>

--- linux-2.6.3/drivers/char/ipmi/ipmi_kcs_sm.c	2003-04-08 10:05:05.000000000 +0200
+++ linux-m68k-2.6.3/drivers/char/ipmi/ipmi_kcs_sm.c	2004-02-19 17:30:59.000000000 +0100
@@ -37,8 +37,11 @@
  * that document.
  */

+#include <linux/types.h>
+
 #include <asm/io.h>
 #include <asm/string.h>		/* Gets rid of memcpy warning */
+#include <asm/system.h>

 #include "ipmi_kcs_sm.h"


Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

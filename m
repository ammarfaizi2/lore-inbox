Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbTE1VOY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 17:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbTE1VOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 17:14:24 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:57242 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S261151AbTE1VOX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 17:14:23 -0400
Date: Wed, 28 May 2003 23:27:25 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>,
       dahinds@users.sourceforge.net
Subject: Fix suspend with pccardd running
Message-ID: <20030528212724.GA695@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This fixes suspend when pccards are used... Please apply,

							Pavel

--- /usr/src/tmp/linux/drivers/pcmcia/cs.c	2003-05-27 13:43:10.000000000 +0200
+++ /usr/src/linux/drivers/pcmcia/cs.c	2003-05-28 23:09:47.000000000 +0200
@@ -48,6 +48,7 @@
 #include <linux/pm.h>
 #include <linux/pci.h>
 #include <linux/device.h>
+#include <linux/suspend.h>
 #include <asm/system.h>
 #include <asm/irq.h>
 
@@ -783,6 +784,9 @@
 		}
 
 		schedule();
+		if (current->flags & PF_FREEZE)
+			refrigerator(PF_IOTHREAD);
+
 		if (!skt->thread)
 			break;
 	}

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]

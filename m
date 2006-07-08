Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030253AbWGHTYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030253AbWGHTYU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 15:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030236AbWGHTYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 15:24:19 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:14533 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030245AbWGHTYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 15:24:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=RKGH6jjvOfdQmKaHMhtm9p4EnhrNHBfUc1BOKoyRcmv/IeCfHAiFd9MZIVmCGEKdlZIqeRHU4PwruVcCC6WQ3g2W9o0o6kVLko1qSYFnCSNj8GL4B+qBvjSd2rTYetOMmCgL2XMnkxxTVS9lPOu/j1cfpY3F/LBg8FyjE8GGD6U=
Date: Sat, 8 Jul 2006 21:24:31 +0200
From: Luca Tettamanti <kronos.it@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] Add missing '\n' to printk in ACPI code
Message-ID: <20060708192431.GA23511@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I found out that a printk() in ACPI code is missing the newline; the
next kernel message is then appended on the same line (and priority is
not stripped), eg:

Device `[FAN0]' is not power manageable<6>ACPI: Fan [FAN0] (on)

This trivial patch (against 2.6.18-rc1) fixes it.

Signed-Off-By: Luca Tettamanti <kronos.it@gmail.com>

--- a/drivers/acpi/bus.c	2006-07-08 15:12:32.855837715 +0200
+++ b/drivers/acpi/bus.c	2006-07-08 15:12:46.848712215 +0200
@@ -192,7 +192,7 @@
 	/* Make sure this is a valid target state */
 
 	if (!device->flags.power_manageable) {
-		printk(KERN_DEBUG "Device `[%s]' is not power manageable",
+		printk(KERN_DEBUG "Device `[%s]' is not power manageable\n",
 				device->kobj.name);
 		return -ENODEV;
 	}



Luca
-- 
Home: http://kronoz.cjb.net
Il piu` bel momento dell'amore e` quando ci si illude che duri per 
sempre; il piu` brutto, quando ci si accorge che dura da troppo.

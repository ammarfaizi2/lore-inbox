Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270162AbUJUD27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270162AbUJUD27 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 23:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270454AbUJUD2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 23:28:06 -0400
Received: from fmr05.intel.com ([134.134.136.6]:59365 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S270527AbUJUDIZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 23:08:25 -0400
Subject: [PATCH 5/5]8250_pnp fix
From: Li Shaohua <shaohua.li@intel.com>
To: ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Cc: Len Brown <len.brown@intel.com>, Adam Belay <ambx1@neo.rr.com>,
       Matthieu <castet.matthieu@free.fr>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>
Content-Type: multipart/mixed; boundary="=-VicswwPBdwvbN1Rvosxi"
Message-Id: <1098327571.6132.228.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 21 Oct 2004 11:00:08 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-VicswwPBdwvbN1Rvosxi
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,
This is a small fix found when debugging the 8250 driver in IA64.

Thanks,
Shaohua

Signed-off-by: Li Shaohua <shaohua.li@intel.com>

--- 2.6/drivers/serial/8250_pnp.c.stg4	2004-09-28 11:27:42.371840736
+0800
+++ 2.6/drivers/serial/8250_pnp.c	2004-09-28 11:28:14.036027048 +0800
@@ -407,7 +407,7 @@ serial_pnp_probe(struct pnp_dev * dev, c
 	serial_req.irq = pnp_irq(dev,0);
 	serial_req.port = pnp_port_start(dev, 0);
 	if (HIGH_BITS_OFFSET)
-		serial_req.port = pnp_port_start(dev, 0) >> HIGH_BITS_OFFSET;
+		serial_req.port_high = pnp_port_start(dev, 0) >> HIGH_BITS_OFFSET;
 #ifdef SERIAL_DEBUG_PNP
 	printk("Setup PNP port: port %x, irq %d, type %d\n",
 	       serial_req.port, serial_req.irq, serial_req.io_type);


--=-VicswwPBdwvbN1Rvosxi
Content-Disposition: attachment; filename=8250.patch
Content-Type: text/x-patch; name=8250.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- 2.6/drivers/serial/8250_pnp.c.stg4	2004-09-28 11:27:42.371840736 +0800
+++ 2.6/drivers/serial/8250_pnp.c	2004-09-28 11:28:14.036027048 +0800
@@ -407,7 +407,7 @@ serial_pnp_probe(struct pnp_dev * dev, c
 	serial_req.irq = pnp_irq(dev,0);
 	serial_req.port = pnp_port_start(dev, 0);
 	if (HIGH_BITS_OFFSET)
-		serial_req.port = pnp_port_start(dev, 0) >> HIGH_BITS_OFFSET;
+		serial_req.port_high = pnp_port_start(dev, 0) >> HIGH_BITS_OFFSET;
 #ifdef SERIAL_DEBUG_PNP
 	printk("Setup PNP port: port %x, irq %d, type %d\n",
 	       serial_req.port, serial_req.irq, serial_req.io_type);

--=-VicswwPBdwvbN1Rvosxi--


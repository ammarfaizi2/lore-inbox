Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265175AbTLZMuX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 07:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265176AbTLZMuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 07:50:23 -0500
Received: from lde849.emirates.net.ae ([217.165.121.87]:23044 "EHLO athena")
	by vger.kernel.org with ESMTP id S265175AbTLZMuW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 07:50:22 -0500
Date: Fri, 26 Dec 2003 16:51:53 +0400 (GST)
From: Amit Gurdasani <amitg@alumni.cmu.edu>
X-X-Sender: amitg@athena
To: linux-kernel@vger.kernel.org
cc: amitg@alumni.cmu.edu
Subject: EISA ID for PnP modem and resource allocation
Message-ID: <Pine.LNX.4.56.0312261610200.1798@athena>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a PROLiNK 1456VH internal Rockwell-based ISA PnP K56flex fax modem
whose EISA ID seems not to be known to 8250_pnp.c. The ID is AEI0250 as
reported in /sys/devices/pnp1/01:01/01:01.00/id and adding this into the
pnp_dev_table[] allows the device to be found and enabled properly by the
8250 serial driver.

A query: I'm using the serial IRQ autodetection and sharing support. In
2.4.23, the serial driver was able to get the first serial port (ttyS0) and
this modem (ttyS2) to share IRQ 4. Now this is not happening, and each port
(and modem) is claiming a unique IRQ. Am I doing anything wrong?

The reason I ask is that I also have a jumpered SB16 on IRQ 5, and loading
the 8250 driver before the snd_sb16 driver results in the SB16's IRQ being
allocated for the modem, which prevents the SB16 driver from loading.
Loading the SB16 driver first results in resource starvation for the modem,
and the 8250 driver is only able to set up the onboard serial ports ttyS0
and ttyS1.

In the meantime, I'm using the isapnptools to set up the modem with IRQ 4
before loading either driver. The result is that the SB16 driver gets IRQ 5
as needed, and ttyS0 is set up with IRQ 0 (is this OK?), but I'd really like
to use the kernel ISA PnP support.

(Kernel 2.4.23's kernel ISA PnP support and serial driver would
automatically assign IRQ 4 to both ttyS0 and the modem [ttyS2].)

Please cc me in any reply, since I'm only subscribed to the daily digest on
lists.us.dell.com.

Amit Gurdasani

--- linux-2.6.0/drivers/serial/8250_pnp.c.orig	2003-12-26 16:39:01.000000000 +0400
+++ linux-2.6.0/drivers/serial/8250_pnp.c	2003-12-26 16:46:26.000000000 +0400
@@ -42,6 +42,8 @@
 	{	"ADC0001",		0	},
 	/* SXPro 288 External Data Fax Modem Plug & Play */
 	{	"ADC0002",		0	},
+	/* PROLiNK 1456VH ISA PnP K56flex Fax Modem */
+	{	"AEI0250",		0	},
 	/* Actiontec ISA PNP 56K X2 Fax Modem */
 	{	"AEI1240",		0	},
 	/* Rockwell 56K ACF II Fax+Data+Voice Modem */

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131588AbRDXVDt>; Tue, 24 Apr 2001 17:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132496AbRDXVDj>; Tue, 24 Apr 2001 17:03:39 -0400
Received: from [209.250.53.82] ([209.250.53.82]:9988 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S131588AbRDXVD1>; Tue, 24 Apr 2001 17:03:27 -0400
Date: Tue, 24 Apr 2001 16:03:11 -0500
From: Steven Walter <srwalter@yahoo.com>
To: linux-kernel@vger.kernel.org
Cc: jgarzik@mandrakesoft.com, tytso@mit.edu
Subject: [PATCH] properly detect ActionTec modem of PCI_CLASS_COMMUNICATION_OTHER
Message-ID: <20010424160310.A338@hapablap.dyn.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Uptime: 3:56pm  up 0 min,  1 user,  load average: 1.85, 0.49, 0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows the serial driver to properly detect and set up the
ActionTec PCI modem.  This modem has a PCI class of COMMUNICATION_OTHER,
which is why this modem is not otherwise detected.

Any suggestions on the patch are welcome.  Thanks
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell

--- clean-2.4.3/drivers/char/serial.c	Fri Mar 30 23:15:33 2001
+++ linux/drivers/char/serial.c	Tue Apr 24 15:40:50 2001
@@ -4706,6 +4728,9 @@
 
 
 static struct pci_device_id serial_pci_tbl[] __devinitdata = {
+       { PCI_VENDOR_ID_ATT, PCI_DEVICE_ID_ATT_VENUS_MODEM,
+         PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_COMMUNICATION_OTHER << 8,
+         0xffff00, },
        { PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
 	 PCI_CLASS_COMMUNICATION_SERIAL << 8, 0xffff00, },
        { 0, }

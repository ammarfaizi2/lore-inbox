Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132892AbRDXWUQ>; Tue, 24 Apr 2001 18:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132922AbRDXWT6>; Tue, 24 Apr 2001 18:19:58 -0400
Received: from [209.250.58.48] ([209.250.58.48]:11012 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S132892AbRDXWTn>; Tue, 24 Apr 2001 18:19:43 -0400
Date: Tue, 24 Apr 2001 17:19:04 -0500
From: Steven Walter <srwalter@yahoo.com>
To: Brian Gerst <bgerst@didntduck.org>
Cc: jgarzik@mandrakesoft.com, tytso@mit.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] properly detect ActionTec modem of PCI_CLASS_COMMUNICATION_OTHER
Message-ID: <20010424171904.A404@hapablap.dyn.dhs.org>
In-Reply-To: <20010424160310.A338@hapablap.dyn.dhs.org> <3AE5EDAC.AF06F124@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AE5EDAC.AF06F124@didntduck.org>; from bgerst@didntduck.org on Tue, Apr 24, 2001 at 05:18:36PM -0400
X-Uptime: 4:54pm  up 1 min,  1 user,  load average: 1.80, 0.71, 0.26
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2001 at 05:18:36PM -0400, Brian Gerst wrote:
> Steven Walter wrote:
> > 
> > This patch allows the serial driver to properly detect and set up the
> > ActionTec PCI modem.  This modem has a PCI class of COMMUNICATION_OTHER,
> > which is why this modem is not otherwise detected.
> > 
> > Any suggestions on the patch are welcome.  Thanks
> 
> A small suggestion:  Vendor/device id are sufficient to identify the
> device.  You can change PCI_CLASS_COMMUNICATION_OTHER << 8 to 0.

Excellent suggestion.  Follows is the amended patch.  Compiled and
tested to work.  BTW: patch is against 2.4.3.
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell

--- clean-2.4.3/drivers/char/serial.c	Fri Mar 30 23:15:33 2001
+++ linux/drivers/char/serial.c	Tue Apr 24 16:32:02 2001
@@ -4706,6 +4728,8 @@
 
 
 static struct pci_device_id serial_pci_tbl[] __devinitdata = {
+       { PCI_VENDOR_ID_ATT, PCI_DEVICE_ID_ATT_VENUS_MODEM,
+         PCI_ANY_ID, PCI_ANY_ID, },
        { PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
 	 PCI_CLASS_COMMUNICATION_SERIAL << 8, 0xffff00, },
        { 0, }

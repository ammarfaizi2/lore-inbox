Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266895AbUHCVlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266895AbUHCVlZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 17:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266890AbUHCVlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 17:41:00 -0400
Received: from albireo.ucw.cz ([81.27.203.89]:21380 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S266887AbUHCVjU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 17:39:20 -0400
Date: Tue, 3 Aug 2004 23:39:21 +0200
From: Martin Mares <mj@ucw.cz>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] add PCI ROMs to sysfs
Message-ID: <20040803213921.GA4585@ucw.cz>
References: <20040803213121.GA4410@ucw.cz> <20040803213624.46232.qmail@web14930.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040803213624.46232.qmail@web14930.mail.yahoo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> lspci -b would be great but it doesn't seem to have implemented dumping
> the ROM location. It dumps everything else.

Ah well, I see the problem -- it doesn't display disabled ROMs.

The following quick hack should cure it:

--- orig/lib/generic.c
+++ mod/lib/generic.c
@@ -160,7 +160,9 @@
       if (reg)
 	{
 	  u32 a = pci_read_long(d, reg);
+#if 0
 	  if (a & PCI_ROM_ADDRESS_ENABLE)
+#endif
 	    d->rom_base_addr = a;
 	}
     }




				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
A student who changes the course of history is probably taking an exam.

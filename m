Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267751AbUIOXRA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267751AbUIOXRA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 19:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267725AbUIOXNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 19:13:19 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:60042 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S267767AbUIOXLd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 19:11:33 -0400
Date: Thu, 16 Sep 2004 01:09:36 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Hans-Frieder Vogt <hfvogt@arcor.de>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, netdev@oss.sgi.com
Subject: Re: 2.6.9-rc1-bk11+ and 2.6.9-rc1-mm3,4 r8169: freeze during boot (FIX included)
Message-ID: <20040915230936.GA24467@electric-eye.fr.zoreil.com>
References: <200409130035.50823.hfvogt@arcor.de> <20040913220209.GA13175@electric-eye.fr.zoreil.com> <200409140131.11927.hfvogt@arcor.de> <200409160040.03532.hfvogt@arcor.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
In-Reply-To: <200409160040.03532.hfvogt@arcor.de>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hans-Frieder Vogt <hfvogt@arcor.de> :
[...]
[...]
> Of course x86-64 has the address-space that enables >4GB RAM, and x86-64 
> always supports DAC (as stated in include/asm-x86_64/pci.h), but I have 
> currently only 1GB RAM, so, strictly speaking, DAC is not really necessary. 

Worse than that: r8169 in 2.6.9-rc[1/2] does not advertise its ability to
DMA to high memory. 

> Strange enough, the latest Realtek driver 2.2 does not even support DAC (only 
> the lower 32 bit of the DMA-Addresses are written to the registers).
> Could it be that the Realtek driver does not support DAC for a good reason?
> 
> Anyway, I will continue searching for the problem...

Can you simply try the attached patch with the network cable unplugged ?

It will not fix your issue but if the result & 0x08 != 0, you can probably
stop your testing for now as it will mean "known issue".

--
Ueimor

--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="r8169-xx0.patch"

 drivers/net/r8169.c |    3 +++
 1 files changed, 3 insertions(+)

diff -puN drivers/net/r8169.c~r8169-xx0 drivers/net/r8169.c
--- linux-2.6.9-rc1/drivers/net/r8169.c~r8169-xx0	2004-09-15 23:57:46.000000000 +0200
+++ linux-2.6.9-rc1-romieu/drivers/net/r8169.c	2004-09-16 00:59:26.000000000 +0200
@@ -1533,6 +1533,9 @@ rtl8169_hw_start(struct net_device *dev)
 	/* Enable all known interrupts by setting the interrupt mask. */
 	RTL_W16(IntrMask, rtl8169_intr_mask);
 
+	printk(KERN_INFO PFX
+		"%s: Config2 = 0x%02x\n", dev->name, RTL_R8(Config2));
+
 	netif_start_queue(dev);
 }
 

_

--X1bOJ3K7DJ5YkBrT--

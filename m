Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261876AbVBDRLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbVBDRLt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 12:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266043AbVBDRLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 12:11:48 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:59269 "EHLO vana")
	by vger.kernel.org with ESMTP id S265965AbVBDRLl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 12:11:41 -0500
Date: Fri, 4 Feb 2005 18:11:40 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: maxer <maxer@xmission.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SysKonnect sk98lin Gigabit lan missing in action from 2.6.10 on
Message-ID: <20050204171140.GD1889@vana.vc.cvut.cz>
References: <42038994.20401@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42038994.20401@xmission.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2005 at 07:41:24AM -0700, maxer wrote:
> What is the status of sk98lin? Do we have to wait until Syskonnect gets 
> their act together
> and write a new driver for 2.6.10?
> 
> Their latest is Oct 2004 and not at all compatible with 2.6.10 and beyond.

What is problem with driver which is in the kernel?  It works flawlessly for
me, on ia32 and x86-64.  Only thing I had to do is patch below so hotplug
code knows that sk98lin driver can handle some PCI hardware...

Linux ppc 2.6.11-rc3-c2048-64 #1 SMP Fri Feb 4 00:48:12 CET 2005 x86_64 GNU/Linux

0000:00:0a.0 Ethernet controller: Marvell Technology Group Ltd. Yukon Gigabit Ethernet 10/100/1000Base-T Adapter (rev 13)

						Petr Vandrovec


diff -urdN linux/drivers/net/sk98lin/skge.c linux/drivers/net/sk98lin/skge.c
--- linux/drivers/net/sk98lin/skge.c	2005-01-29 17:31:14.000000000 +0100
+++ linux/drivers/net/sk98lin/skge.c	2005-01-30 00:11:49.000000000 +0100
@@ -5151,6 +5151,7 @@
 	{ PCI_VENDOR_ID_LINKSYS, 0x1064, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ 0, }
 };
+MODULE_DEVICE_TABLE (pci, skge_pci_tbl);
 
 static struct pci_driver skge_driver = {
 	.name		= "skge",

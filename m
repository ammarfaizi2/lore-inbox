Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267363AbUI0WFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267363AbUI0WFT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 18:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267364AbUI0WFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 18:05:19 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1801 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S267363AbUI0WFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 18:05:04 -0400
Date: Mon, 27 Sep 2004 23:04:59 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Dax Kelson <dax@gurulabs.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: thinkpad issue --No PCMCIA hotplug activity when onboard nic (e1000) down
Message-ID: <20040927230458.F26680@flint.arm.linux.org.uk>
Mail-Followup-To: Dax Kelson <dax@gurulabs.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <1096317629.4075.65.camel@mentorng.gurulabs.com> <20040927215304.E26680@flint.arm.linux.org.uk> <1096319165.4075.78.camel@mentorng.gurulabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1096319165.4075.78.camel@mentorng.gurulabs.com>; from dax@gurulabs.com on Mon, Sep 27, 2004 at 03:06:05PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2004 at 03:06:05PM -0600, Dax Kelson wrote:
> On Mon, 2004-09-27 at 14:53, Russell King wrote:
> > On Mon, Sep 27, 2004 at 02:40:29PM -0600, Dax Kelson wrote:
> > > Myself and a co-worker have two ThinkPads bought a few months apart. The
> > > two model numbers are:
> > > 
> > > 2373-KUU -- T42p 14" LCD
> > > 2373-CXU -- T42 15" LCD
> > > 
> > > Both have the following onboard NIC and cardbus controller
> > > 02:01.0 Ethernet controller: Intel Corp. 82540EP Gigabit Ethernet Controller (Mobile) (rev 03)
> > > 02:00.0 CardBus bridge: Texas Instruments PCI4520 PC card Cardbus Controller (rev 01)
> > > 02:00.1 CardBus bridge: Texas Instruments PCI4520 PC card Cardbus Controller (rev 01)
> > 
> > Can you also provide the output of lspci -n for the above two
> > cardbus bridges please?
> 
> Sure..
> 
> # lspci -n | grep 02:00
> 02:00.0 Class 0607: 104c:ac46 (rev 01)
> 02:00.1 Class 0607: 104c:ac46 (rev 01)

Can you try this patch please?  Thanks.

===== drivers/pcmcia/yenta_socket.c 1.59 vs edited =====
--- 1.59/drivers/pcmcia/yenta_socket.c	2004-08-22 15:39:15 +01:00
+++ edited/drivers/pcmcia/yenta_socket.c	2004-09-27 23:03:57 +01:00
@@ -1091,6 +1091,7 @@
 	CB_ID(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_4410, TI12XX),
 	CB_ID(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_4450, TI12XX),
 	CB_ID(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_4451, TI12XX),
+	CB_ID(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_4520, TI12XX),
 
 	CB_ID(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_1250, TI1250),
 	CB_ID(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_1410, TI1250),
===== include/linux/pci_ids.h 1.176 vs edited =====
--- 1.176/include/linux/pci_ids.h	2004-08-28 19:46:04 +01:00
+++ edited/include/linux/pci_ids.h	2004-09-27 23:03:54 +01:00
@@ -734,6 +734,7 @@
 #define PCI_DEVICE_ID_TI_1251B		0xac1f
 #define PCI_DEVICE_ID_TI_4410		0xac41
 #define PCI_DEVICE_ID_TI_4451		0xac42
+#define PCI_DEVICE_ID_TI_4520		0xac46
 #define PCI_DEVICE_ID_TI_1410		0xac50
 #define PCI_DEVICE_ID_TI_1420		0xac51
 #define PCI_DEVICE_ID_TI_1451A		0xac52


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core

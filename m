Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288173AbSA1NGd>; Mon, 28 Jan 2002 08:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288174AbSA1NGZ>; Mon, 28 Jan 2002 08:06:25 -0500
Received: from mailrelay1.inwind.it ([212.141.54.101]:15090 "EHLO
	mailrelay1.inwind.it") by vger.kernel.org with ESMTP
	id <S288173AbSA1NGR>; Mon, 28 Jan 2002 08:06:17 -0500
Date: Mon, 28 Jan 2002 14:06:19 +0100
From: Gianluca Anzolin <g.anzolin@inwind.it>
To: linux-kernel@vger.kernel.org
Cc: g.anzolin@inwind.it
Subject: [PATCH] remove a wrong release_region in eexpress.c
Message-ID: <20020128130619.GA652@fourier.home.intranet>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I was trying the eexpress.c driver for my Intel EtherExpress 16 NIC
(isa) and I got some errors when I unloaded the module (kernel
2.4.18-pre7).

The problem was that it was trying to release an already released i/o
region. I'm attaching a patch to remove that release_region.

I have also a question: I'm reading Rubini's Linux Device Drivers (2nd
edition) and he writes that irq and regions should be registered when
the device is open (and not in the hw-probe function). Why network
drivers should register the resources they use only on open and not on
probe (like other drivers do) ? 

I don't know if this is related but I had a problem few months ago when 
the ISDN card (a pci one) tried to share the same IRQ of the Network 
Card (isa). The result was the nic didn't work (the NIC was a 3c509b 
ISA PNP card) and I had to explicitly change the nic irq via a kernel parameter 
on boot. Now I wonder if this could have happened if the driver had 
registered its irq on probe and not on open (i.e. after that the hisax
module was loaded).

Greeting, 

	Gianluca Anzolin

--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="eexpress.patch"

--- eexpress.c.old	Mon Jan 28 13:47:44 2002
+++ eexpress.c	Mon Jan 28 13:48:19 2002
@@ -1674,7 +1674,6 @@
 			unregister_netdev(dev);
 			kfree(dev->priv);
 			dev->priv = NULL;
-			release_region(dev->base_addr, EEXP_IO_EXTENT);
 		}
 	}
 }

--tKW2IUtsqtDRztdT--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264550AbTKNQz4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 11:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264551AbTKNQz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 11:55:56 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:64396 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264550AbTKNQzx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 11:55:53 -0500
X-AuthUser: davidel@xmailserver.org
Date: Fri, 14 Nov 2003 08:55:52 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Roland Lezuo <roland.lezuo@chello.at>
cc: Martin Diehl <lists@mdiehl.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23-rc1: SiS pirq: IDE/ACPI/DAQ mapping not implemented: (97)
In-Reply-To: <200311141745.11770.roland.lezuo@chello.at>
Message-ID: <Pine.LNX.4.44.0311140849140.1827-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Nov 2003, Roland Lezuo wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> > Roland, could you send the output from "lspci -vxxx -d:8" please for
> > verification?
> 00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
>         Flags: bus master, medium devsel, latency 0
> 00: 39 10 08 00 0f 00 00 02 00 00 01 06 00 00 80 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 40: 9a 0b 0c 05 0b 22 31 09 10 00 00 00 11 20 04 01
> 50: 11 28 02 01 62 00 63 00 9c 2e 12 00 36 06 00 00
> 60: 80 80 80 09 40 c1 0c 10 80 80 00 02 d0 00 00 00
> 70: 00 00 00 00 00 50 00 fc 00 00 00 00 06 00 01 00
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> I am willed to test any patch or even write one (with some help and tips ;)

Use the patch below and send the dmesg ...


- Davide




--- a/arch/i386/kernel/pci-i386.h	2003-08-31 05:21:57.000000000 -0700
+++ b/arch/i386/kernel/pci-i386.mod.h	2003-11-14 08:50:35.000000000 -0800
@@ -6,7 +6,7 @@
 
 #undef DEBUG
 
-#ifdef DEBUG
+#ifndef DEBUG
 #define DBG(x...) printk(x)
 #else
 #define DBG(x...)
--- a/arch/i386/kernel/pci-irq.c	2003-08-31 06:51:32.000000000 -0700
+++ b/arch/i386/kernel/pci-irq.mod.c	2003-11-14 08:52:12.000000000 -0800
@@ -679,14 +679,14 @@
 		r->name = "SIS96x";
 		r->get = pirq_sis96x_get;
 		r->set = pirq_sis96x_set;
-		DBG("PCI: Detecting SiS router at %02x:%02x : SiS096x detected\n",
-		    rt->rtr_bus, rt->rtr_devfn);
+		DBG("PCI: Detecting SiS router at %02x:%02x (devid=%x): SiS096x detected\n",
+		    rt->rtr_bus, rt->rtr_devfn, devid);
 	} else {
 		r->name = "SIS5595";
 		r->get = pirq_sis5595_get;
 		r->set = pirq_sis5595_set;
-		DBG("PCI: Detecting SiS router at %02x:%02x : SiS5595 detected\n",
-		    rt->rtr_bus, rt->rtr_devfn);
+		DBG("PCI: Detecting SiS router at %02x:%02x (devid=%x): SiS5595 detected\n",
+		    rt->rtr_bus, rt->rtr_devfn, devid);
 	}
 	return 1;
 }


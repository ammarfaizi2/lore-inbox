Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262224AbTKNI6p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 03:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbTKNI6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 03:58:45 -0500
Received: from pc7.prs.nunet.net ([199.249.167.77]:57616 "HELO
	patternassociates.com") by vger.kernel.org with SMTP
	id S262224AbTKNI6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 03:58:44 -0500
Date: 14 Nov 2003 08:58:41 -0000
Message-ID: <20031114085841.28270.qmail@patternassociates.com>
From: rico-linux-kernel@patternassociates.com
To: linux-kernel@vger.kernel.org
Subject: Re: serverworks usb under 2.4.22
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From:	Ingo Oeser <ioe-lkml@rameria.de>
>Date:	Fri, 14 Nov 2003 08:51:00 +0100
>...
>I for one need to pass "noapic" on the kernel command line. Otherwise
>the IRQ routing is broken, I can't get the USB IRQ and the kernel complains.
>a lot about a broken APIC IRQ routing.
>
>My board is an ASUS CUR-CLS. The chipset there is "ServerWorks LE".

Ingo,

My ServerWorks HE chipset is a close cousin.  The common BIOS was written
by Intergraph, and marketed by Phoenix.  It somehow fails to communicate
its decisions about IRQ routing to Linux.  One may get lucky by moving
hardware around but, with the following patch, you are guaranteed use
of the chipset USB while still enjoying the IO-APIC.  Patch has been
necessary from 2.4.0 through 2.4.17 and, by the sounds of it, to current
2.4 versions.

You must edit the patch to use the correct IRQ for your hardware config
(11 in my case).  To determine the IRQ, access USB hardware while
monitoring interrupt counts in /proc/stat

--------start of patch--------------------------------------------------
*** usb-ohci.c.orig	Mon Dec 31 11:35:13 2001
--- usb-ohci.c	Mon Dec 31 12:10:39 2001
***************
*** 2581,2601 ****
--- 2581,2605 ----
  
  	mem_base = ioremap_nocache (mem_resource, mem_len);
  	if (!mem_base) {
  		err("Error mapping OHCI memory");
  		return -EFAULT;
  	}
  
  	/* controller writes into our memory */
  	pci_set_master (dev);
  
+ #if 0
  	return hc_found_ohci (dev, dev->irq, mem_base, id);
+ #else
+ 	return hc_found_ohci (dev,       11, mem_base, id);
+ #endif
  } 
  
  /*-------------------------------------------------------------------------*/
  
  /* may be called from interrupt context [interface spec] */
  /* may be called without controller present */
  /* may be called with controller, bus, and devices active */
  
  static void __devexit
  ohci_pci_remove (struct pci_dev *dev)
--------end of patch--------------------------------------------------

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263713AbUDGPoU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 11:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263718AbUDGPoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 11:44:20 -0400
Received: from 80-218-57-148.dclient.hispeed.ch ([80.218.57.148]:47109 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S263713AbUDGPoD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 11:44:03 -0400
From: Daniel Ritz <daniel.ritz@gmx.ch>
Reply-To: daniel.ritz@gmx.ch
To: Kitt Tientanopajai <kitt@gear.kku.ac.th>
Subject: Re: 2.6.5 yenta_socket irq 10: nobody cared!
Date: Wed, 7 Apr 2004 17:41:47 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <200404060227.58325.daniel.ritz@gmx.ch> <20040406093510.33c937e3.kitt@gear.kku.ac.th>
In-Reply-To: <20040406093510.33c937e3.kitt@gear.kku.ac.th>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404071741.47624.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 April 2004 04:35, Kitt Tientanopajai wrote:
> Hi, 
> 
> > this is a known problem with the acer travelmate 361. it reports IRQ 11 for
> > the O2Micro cardbus bridge when it is in reality IRQ 10.
> > 
> > see:
> > 	http://www.naos.co.nz/hardware/laptop/acer-361evi/x94.html#AEN138
> > and
> > 	http://sourceforge.net/tracker/index.php?func=detail&aid=533863&group_id=2405&atid=102405
> 
> Thanks for info. I'll try that.
> 
> > please give a full dmesg and a lspci -vvvn.
> > are you using ACPI?
> 
> My boot param is "acpi=on pci=noacpi", below is output from dmesg and lspci. 
> 
> 
> kitt
> 
> --
> 
> $ dmesg

looks like you need a little workaround in the interuput routing code...please
apply the attached patch, send dmesg output plus output of dmidecode
( http://www.nongnu.org/demidecode/ ).


on the other side it could be that the o2micro bridge is wrongly programmed.
what looks a bit weired is that both functions of the o2micro show Pin A
routed to IRQ 11. this could be wrong. i'm reading the spec now.


do you happen to have the redmond OS on this machine? it would be nice to see
which interrupt windoze assignes to the o2micro bridge.

and one more question: any change in the interrupt assignment if you use full ACPI?


--- 1.36/arch/i386/pci/irq.c	Fri Feb 27 06:48:13 2004
+++ edited/arch/i386/pci/irq.c	Wed Apr  7 13:57:44 2004
@@ -542,8 +542,6 @@
 	r->name = "SIS";
 	r->get = pirq_sis_get;
 	r->set = pirq_sis_set;
-	DBG("PCI: Detecting SiS router at %02x:%02x\n",
-	    rt->rtr_bus, rt->rtr_devfn);
 	return 1;
 }
 
--- 1.17/arch/i386/pci/pci.h	Mon Mar  1 07:20:00 2004
+++ edited/arch/i386/pci/pci.h	Wed Apr  7 13:56:51 2004
@@ -4,7 +4,7 @@
  *	(c) 1999 Martin Mares <mj@ucw.cz>
  */
 
-#undef DEBUG
+#define DEBUG
 
 #ifdef DEBUG
 #define DBG(x...) printk(x)


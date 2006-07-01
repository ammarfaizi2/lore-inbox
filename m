Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932560AbWGAPCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932560AbWGAPCj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 11:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932601AbWGAPCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 11:02:03 -0400
Received: from www.osadl.org ([213.239.205.134]:15525 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751905AbWGAO5m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 10:57:42 -0400
Message-Id: <20060701145228.369889000@cruncher.tec.linutronix.de>
References: <20060701145211.856500000@cruncher.tec.linutronix.de>
Date: Sat, 01 Jul 2006 14:55:12 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Miller <davem@davemloft.net>
Subject: [RFC][patch 44/44] Documentation: Use the new IRQF_ constansts
Content-Disposition: inline; filename=irqflags-Documentation.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

 Documentation/DocBook/videobook.tmpl                         |    2 +-
 Documentation/pci.txt                                        |    2 +-
 Documentation/scsi/tmscsim.txt                               |    2 +-
 Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl |    6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

Index: linux-2.6.git/Documentation/pci.txt
===================================================================
--- linux-2.6.git.orig/Documentation/pci.txt	2006-07-01 16:51:06.000000000 +0200
+++ linux-2.6.git/Documentation/pci.txt	2006-07-01 16:51:52.000000000 +0200
@@ -225,7 +225,7 @@ Generic flavors of pci_request_region() 
 Use these for address resources that are not described by "normal" PCI
 interfaces (e.g. BAR).
 
-   All interrupt handlers should be registered with SA_SHIRQ and use the devid
+   All interrupt handlers should be registered with IRQF_SHARED and use the devid
 to map IRQs to devices (remember that all PCI interrupts are shared).
 
 
Index: linux-2.6.git/Documentation/DocBook/videobook.tmpl
===================================================================
--- linux-2.6.git.orig/Documentation/DocBook/videobook.tmpl	2006-07-01 16:51:06.000000000 +0200
+++ linux-2.6.git/Documentation/DocBook/videobook.tmpl	2006-07-01 16:51:52.000000000 +0200
@@ -976,7 +976,7 @@ static int camera_close(struct video_dev
   <title>Interrupt Handling</title>
   <para>
         Our example handler is for an ISA bus device. If it was PCI you would be
-        able to share the interrupt and would have set SA_SHIRQ to indicate a 
+        able to share the interrupt and would have set IRQF_SHARED to indicate a 
         shared IRQ. We pass the device pointer as the interrupt routine argument. We
         don't need to since we only support one card but doing this will make it
         easier to upgrade the driver for multiple devices in the future.
Index: linux-2.6.git/Documentation/scsi/tmscsim.txt
===================================================================
--- linux-2.6.git.orig/Documentation/scsi/tmscsim.txt	2006-07-01 16:51:06.000000000 +0200
+++ linux-2.6.git/Documentation/scsi/tmscsim.txt	2006-07-01 16:51:52.000000000 +0200
@@ -109,7 +109,7 @@ than the 33.33 MHz being in the PCI spec
 
 If you want to share the IRQ with another device and the driver refuses to
 do so, you might succeed with changing the DC390_IRQ type in tmscsim.c to 
-SA_SHIRQ | SA_INTERRUPT.
+IRQF_SHARED | IRQF_DISABLED.
 
 
 3.Features
Index: linux-2.6.git/Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl
===================================================================
--- linux-2.6.git.orig/Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl	2006-07-01 16:51:06.000000000 +0200
+++ linux-2.6.git/Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl	2006-07-01 16:51:52.000000000 +0200
@@ -1149,7 +1149,7 @@
           }
           chip->port = pci_resource_start(pci, 0);
           if (request_irq(pci->irq, snd_mychip_interrupt,
-                          SA_INTERRUPT|SA_SHIRQ, "My Chip", chip)) {
+                          IRQF_DISABLED|IRQF_SHARED, "My Chip", chip)) {
                   printk(KERN_ERR "cannot grab irq %d\n", pci->irq);
                   snd_mychip_free(chip);
                   return -EBUSY;
@@ -1323,7 +1323,7 @@
           <programlisting>
 <![CDATA[
   if (request_irq(pci->irq, snd_mychip_interrupt,
-                  SA_INTERRUPT|SA_SHIRQ, "My Chip", chip)) {
+                  IRQF_DISABLED|IRQF_SHARED, "My Chip", chip)) {
           printk(KERN_ERR "cannot grab irq %d\n", pci->irq);
           snd_mychip_free(chip);
           return -EBUSY;
@@ -1342,7 +1342,7 @@
 
       <para>
       On the PCI bus, the interrupts can be shared. Thus,
-      <constant>SA_SHIRQ</constant> is given as the interrupt flag of
+      <constant>IRQF_SHARED</constant> is given as the interrupt flag of
       <function>request_irq()</function>. 
       </para>
 

--


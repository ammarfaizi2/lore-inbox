Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317386AbSGITqv>; Tue, 9 Jul 2002 15:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317388AbSGITqu>; Tue, 9 Jul 2002 15:46:50 -0400
Received: from 200-221-69-194.dsl-sp.uol.com.br ([200.221.69.194]:13442 "HELO
	servidor.dmnss.eti.br") by vger.kernel.org with SMTP
	id <S317386AbSGITqt>; Tue, 9 Jul 2002 15:46:49 -0400
Message-ID: <3D2B3D5D.6070804@dmnss.eti.br>
Date: Tue, 09 Jul 2002 16:45:33 -0300
From: "David Marques Neves (DMNss)" <dmnss@dmnss.eti.br>
Reply-To: dmnss@dmnss.eti.br
Organization: DMN Software Support
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.0) Gecko/20020530
X-Accept-Language: pt-br, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Error in IRQ routing on Intel 82820 USB module.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Error in IRQ routing on Intel 82820 USB module.

This error was found comparing the IRQ assigned to USB device at boot 
and at lspci, and causes the USB to stop of work.

The kernel in question is 2.4.18, but i also test in 2.4.18-5mdk.

i find this path, and how was not made by me, i "pass the ball" ...
Please send credits to him...

Page:
http://www.pm.waw.pl/~jslupski/vaio/usbproblem.html

Path:
http://www.pm.waw.pl/~jslupski/vaio/files/vaioUSB.patch

--- pci-irq.orginal.c	Mon Jan  7 14:59:31 2002
+++ pci-irq.c	Mon Jan  7 15:02:18 2002
@@ -588,7 +588,8 @@
  		irq = pirq & 0xf;
  		DBG(" -> hardcoded IRQ %d\n", irq);
  		msg = "Hardcoded";
- 
} else if (r->get && (irq = r->get(pirq_router_dev, dev, pirq))) {
+ 
} else if (r->get && (irq=r->get(pirq_router_dev, dev, pirq))
+ 
						&& !(dev->vendor==0x8086 && dev->device==0x2442)) {
  		DBG(" -> got IRQ %d\n", irq);
  		msg = "Found";
  	} else if (newirq && r->set && (dev->class >> 8) != 
PCI_CLASS_DISPLAY_VGA) {


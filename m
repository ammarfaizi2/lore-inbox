Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279547AbRKDLCW>; Sun, 4 Nov 2001 06:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279899AbRKDLCL>; Sun, 4 Nov 2001 06:02:11 -0500
Received: from colorfullife.com ([216.156.138.34]:5902 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S279547AbRKDLCB>;
	Sun, 4 Nov 2001 06:02:01 -0500
Message-ID: <3BE5201F.78A6B811@colorfullife.com>
Date: Sun, 04 Nov 2001 12:01:51 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.14-pre7 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Tom Winkler <tiger@tserver.2y.net>, linux-kernel@vger.kernel.org
Subject: Vaio IRQ routing / USB problem
Content-Type: multipart/mixed;
 boundary="------------70AD756B1123F3F01D1F807B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------70AD756B1123F3F01D1F807B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

It seems that the PCI subsystem notices that all irq sources
share irq 9 and reroutes interrupts.
But after rerouting the interrupts it notices that something
is wrong and aborts the irq change, without undoing the
rerouting.

Thus the usb controller waits on irq 9, and doesn't receive
the interrupts.
If you play sound, you effectively poll the irq handler of
the USB controller, and then you can use your mouse.

Could you apply the attached patch, reboot and post the dmesg
output? And append cat /proc/interrupts.

--
	Manfred
--------------70AD756B1123F3F01D1F807B
Content-Type: text/plain; charset=us-ascii;
 name="patch-DBG"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-DBG"

--- 2.4/arch/i386/kernel/pci-irq.c	Sat Nov  3 19:51:08 2001
+++ build-2.4/arch/i386/kernel/pci-irq.c	Sun Nov  4 11:57:00 2001
@@ -48,6 +48,8 @@
  *  Search 0xf0000 -- 0xfffff for the PCI IRQ Routing Table.
  */
 
+#undef DBG
+#define DBG	printk
 static struct irq_routing_table * __init pirq_find_routing_table(void)
 {
 	u8 *addr;

--------------70AD756B1123F3F01D1F807B--


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318170AbSHEF2j>; Mon, 5 Aug 2002 01:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318173AbSHEF2j>; Mon, 5 Aug 2002 01:28:39 -0400
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:40462
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP
	id <S318170AbSHEF2i>; Mon, 5 Aug 2002 01:28:38 -0400
Subject: fix for pci_enable_device in 2.4.19ac3
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 04 Aug 2002 22:32:13 -0700
Message-Id: <1028525533.1922.5.camel@ixodes.goop.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found my tulip driver was complaining about not being able to enable
the device.  Turns out this was the problem: 

==== //depot/linux/2.4ac/drivers/pci/pci.c#3 - /home/jeremy/p4/linux/2.4ac/drivers/pci/pci.c ====
@@ -389,7 +389,7 @@
 int
 pci_enable_device(struct pci_dev *dev)
 {
-	pci_enable_device_bars(dev, 0x3F);
+	return pci_enable_device_bars(dev, 0x3F);
 }
 
 /**

I guess nobody else checks their error returns (or it just happened to
always return 0).

	J

[ sorry about the resend; forgot to turn off HTML ]


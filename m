Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263371AbTC2BTI>; Fri, 28 Mar 2003 20:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263372AbTC2BTI>; Fri, 28 Mar 2003 20:19:08 -0500
Received: from smtp06.iddeo.es ([62.81.186.16]:57042 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id <S263371AbTC2BTG>;
	Fri, 28 Mar 2003 20:19:06 -0500
Date: Sat, 29 Mar 2003 02:30:22 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, vortex@scyld.com
Subject: Bad PCI IDs-Names table in 3c59x.c
Message-ID: <20030329013022.GA2711@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi al...

I have a 3c980-TX (at least that is what is printed in the card), that
is recognized as this by the kernel pci subsystem:

werewolf:/usr/src/linux/drivers/net# cat /proc/pci
...
  Bus  0, device  18, function  0:
    Ethernet controller: 3Com Corporation 3c980-TX 10/100baseTX NIC [Python-T] (rev 120).
..

by lspci:
00:12.0 Ethernet controller: 3Com Corporation 3c980-TX 10/100baseTX NIC [Python-T] (rev 78)
        Subsystem: 3Com Corporation: Unknown device 1000

but not by 3c59x.c (version 1.1.8-ac):
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
00:12.0: 3Com PCI 3c982 Dual Port Server Cyclone at 0xec00. Vers LK1.1.18-ac

Possible patch below, if I have not a bad understanding of drivers/pci/pci.ids.

Two questions remaining:
- rev 120 vs. rev 78 ???
- Unknown device 1000 ?? (that's userspace, so I understand it does not matter
  in this list...)

TIA

--- linux/drivers/net/3c59x.c.orig	2003-03-29 01:50:24.000000000 +0100
+++ linux/drivers/net/3c59x.c	2003-03-29 02:11:00.000000000 +0100
@@ -432,6 +432,8 @@
 	CH_3C905C2,
 	CH_3C980,
 	CH_3C9805,
+	CH_3C982A,
+	CH_3C982B,
 
 	CH_3CSOHO100_TX,
 	CH_3C555,
@@ -505,7 +507,11 @@
 	 PCI_USES_IO|PCI_USES_MASTER, IS_TORNADO|HAS_NWAY|HAS_HWCKSM, 128, },
 	{"3c980 Cyclone",
 	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_HWCKSM, 128, },
-	{"3c982 Dual Port Server Cyclone",
+	{"3c980 Python-T",
+	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_HWCKSM, 128, },
+	{"3c982 Hydra Dual Port A",
+	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_HWCKSM, 128, },
+	{"3c982 Hydra Dual Port B",
 	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_HWCKSM, 128, },
 
 	{"3cSOHO100-TX Hurricane",
@@ -572,6 +578,8 @@
 	{ 0x10B7, 0x9201, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C905C2 },
 	{ 0x10B7, 0x9800, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C980 },
 	{ 0x10B7, 0x9805, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C9805 },
+	{ 0x10B7, 0x1201, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C982A },
+	{ 0x10B7, 0x1202, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C982B },
 
 	{ 0x10B7, 0x7646, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3CSOHO100_TX },
 	{ 0x10B7, 0x5055, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C555 },

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Bamboo) for i586
Linux 2.4.21-pre6-jam1 (gcc 3.2.2 (Mandrake Linux 9.1 3.2.2-3mdk))

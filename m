Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281005AbRKTJzy>; Tue, 20 Nov 2001 04:55:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281010AbRKTJzo>; Tue, 20 Nov 2001 04:55:44 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:7840 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S281005AbRKTJze>; Tue, 20 Nov 2001 04:55:34 -0500
Date: Tue, 20 Nov 2001 12:01:42 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] one liner to adhere to MP1.4 specifications
Message-ID: <Pine.LNX.4.33.0111201151550.28443-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diffed against 2.4.15-pre6, changes the MP flointing pointer
struct scanning from the whole 4k of the EBDA to only the first k as
specified in the MP1.4 spec sheets.

Regards,
	Zwane Mwaikambo


diff -urb linux-2.4.15-pre6-orig/arch/i386/kernel/mpparse.c linux-2.4.15-pre6-zm/arch/i386/kernel/mpparse.c
--- linux-2.4.15-pre6-orig/arch/i386/kernel/mpparse.c	Sun Nov 18 15:18:05 2001
+++ linux-2.4.15-pre6-zm/arch/i386/kernel/mpparse.c	Tue Nov 20 11:46:20 2001
@@ -803,7 +803,7 @@

 	address = *(unsigned short *)phys_to_virt(0x40E);
 	address <<= 4;
-	smp_scan_config(address, 0x1000);
+	smp_scan_config(address, 0x400);
 	if (smp_found_config)
 		printk(KERN_WARNING "WARNING: MP table in the EBDA can be UNSAFE, contact linux-smp@vger.kernel.org if you experience SMP problems!\n");
 }


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266718AbTBLC6T>; Tue, 11 Feb 2003 21:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266637AbTBLC4c>; Tue, 11 Feb 2003 21:56:32 -0500
Received: from covert.black-ring.iadfw.net ([209.196.123.142]:13577 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id <S266298AbTBLCz4>; Tue, 11 Feb 2003 21:55:56 -0500
Date: Tue, 11 Feb 2003 21:01:25 -0600
From: Art Haas <ahaas@airmail.net>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] C99 initiailzers for kernel/resource.c
Message-ID: <20030212030125.GH914@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This patch converts the file to use C99 initializers to remove warnings
if '-W' is used and aid readability.

Art Haas

===== kernel/resource.c 1.8 vs edited =====
--- 1.8/kernel/resource.c	Sun Dec 29 12:53:07 2002
+++ edited/kernel/resource.c	Tue Feb 11 09:39:58 2003
@@ -15,8 +15,19 @@
 #include <linux/spinlock.h>
 #include <asm/io.h>
 
-struct resource ioport_resource = { "PCI IO", 0x0000, IO_SPACE_LIMIT, IORESOURCE_IO };
-struct resource iomem_resource = { "PCI mem", 0x00000000, 0xffffffff, IORESOURCE_MEM };
+struct resource ioport_resource = {
+	.name	= "PCI IO",
+	.start	= 0x0000,
+	.end	= IO_SPACE_LIMIT,
+	.flags	= IORESOURCE_IO
+};
+
+struct resource iomem_resource = {
+	.name	= "PCI mem",
+	.start	= 0x00000000,
+	.end	= 0xffffffff,
+	.flags	= IORESOURCE_MEM
+};
 
 static rwlock_t resource_lock = RW_LOCK_UNLOCKED;
 
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759

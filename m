Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265134AbSL0QJg>; Fri, 27 Dec 2002 11:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265132AbSL0QI6>; Fri, 27 Dec 2002 11:08:58 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:13501 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S265099AbSL0QIT>;
	Fri, 27 Dec 2002 11:08:19 -0500
Date: Fri, 27 Dec 2002 17:16:35 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200212271616.RAA03356@harpo.it.uu.se>
To: rusty@rustcorp.com.au
Subject: two 2.5 modules bugs
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. With kernel 2.5.53 and module-init-tools-0.9.6, "modprobe tulip"
   fails and goes into an infinite CPU-consuming loop. The problem
   appears to be related to the dependency from tulip to crc32. If I
   manually modprobe crc32 before modprobe tulip, it works. If crc32
   isn't loaded, modprobe tulip first loads crc32 and then loops.

   module-init-tools-0.9.5 did not have this problem.

2. The implementation of old-style MODULE_PARMs with type "1-16s"
   is broken. Instead of splicing the parameter at the commas and
   storing pointers to the substrings in consecutive array elements,
   the whole string is stored in the array instead.

   Consider parport_pc.c, which contains (simplified):

   static const char *irq[16];
   MODULE_PARM(irq, "1-16s");

   "modprobe parport_pc irq=007" should store a pointer to "007" in
   irq[0], but instead (unsigned int)irq[0] == 0x00373030, the ASCII
   representation of "007" in little-endian. (Kernel 2.5.53 on x86,
   with module-init-tools-0.9.[56].)

/Mikael

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129178AbQKMXPB>; Mon, 13 Nov 2000 18:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129737AbQKMXOw>; Mon, 13 Nov 2000 18:14:52 -0500
Received: from [209.249.10.20] ([209.249.10.20]:2182 "EHLO freya.yggdrasil.com")
	by vger.kernel.org with ESMTP id <S129178AbQKMXOk>;
	Mon, 13 Nov 2000 18:14:40 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 13 Nov 2000 14:44:34 -0800
Message-Id: <200011132244.OAA03269@baldur.yggdrasil.com>
To: bkz@linux-ide.org
Subject: Patch(?): linux-2.4.0-test11-pre4/drivers/sound/yss225.c compile failure
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




	linux-2.4.0-test11-pre4/drivers/sound/yss225.c uses __initdata
but does not include <linux/init.h>, so it could not compile.  I have
attached below.

	Note that I am a bit uncertain about the correctness of
the __initdata prefix here in the first place.  Is yss225 a PCI
device?  If so, a kernel that supports PCI hot plugging should
be prepared to support the possibility of a hot pluggable yss225
card being inserted after the module has already been initialized.
Even if no CardBus or CompactPCI version of yss225 hardware exists
yet, it will require less maintenance for PCI drivers to be prepared
for this possibility from the outset (besides, is it possible to have a
hot pluggable PCI bridge card that bridges to a regular PCI bus?).

	So, if yss225 is a PCI device, the declaration should use
__devinitdata.  On the other hand, if it is ISA only, then __initdata
should be correct.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--- linux-2.4.0-test11-pre4/drivers/sound/yss225.c	Mon Nov 13 13:36:50 2000
+++ linux/drivers/sound/yss225.c	Mon Nov 13 09:11:02 2000
@@ -1,3 +1,4 @@
+#include <linux/init.h>
 unsigned char page_zero[] __initdata = {
 0x01, 0x7c, 0x00, 0x1e, 0x00, 0x00, 0x00, 0x00, 0x00, 0xf5, 0x00,
 0x11, 0x00, 0x20, 0x00, 0x32, 0x00, 0x40, 0x00, 0x13, 0x00, 0x00,
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

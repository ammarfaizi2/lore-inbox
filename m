Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262505AbVG2IKD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262505AbVG2IKD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 04:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262506AbVG2IKD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 04:10:03 -0400
Received: from posti6.jyu.fi ([130.234.4.43]:64729 "EHLO posti6.jyu.fi")
	by vger.kernel.org with ESMTP id S262505AbVG2IJ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 04:09:59 -0400
Date: Fri, 29 Jul 2005 11:09:44 +0300 (EEST)
From: Tero Roponen <teanropo@cc.jyu.fi>
To: Andrew Morton <akpm@osdl.org>
cc: Jon Smirl <jonsmirl@gmail.com>, ink@jurassic.park.msu.ru, gregkh@suse.de,
       linux-kernel@vger.kernel.org
Subject: 2.6.14-rc4: dma_timer_expiry [was 2.6.13-rc2 hangs at boot]
In-Reply-To: <20050728233408.550939d4.akpm@osdl.org>
Message-ID: <Pine.GSO.4.58.0507291105480.12940@tukki.cc.jyu.fi>
References: <Pine.GSO.4.58.0507061638380.13297@tukki.cc.jyu.fi>
 <9e47339105070618273dfb6ff8@mail.gmail.com> <20050728233408.550939d4.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Checked: by miltrassassin
	at posti6.jyu.fi; Fri, 29 Jul 2005 11:09:46 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just tested 2.6.13-rc4. At boot it prints:
"dma_timer_expiry: dma status == 0x61" many times.
That's the same problem as in 2.6.13-rc2.

If I apply the following patch, everything seems to be fine.
I'm not sure if this is the right thing to do, but it works for me.

-
Tero Roponen


--- 2.6.13-rc2/drivers/pci/setup-bus.c	Thu Jul  7 01:32:43 2005
+++ linux/drivers/pci/setup-bus.c	Fri Jul  8 10:25:20 2005
@@ -40,8 +40,8 @@
  * FIXME: IO should be max 256 bytes.  However, since we may
  * have a P2P bridge below a cardbus bridge, we need 4K.
  */
-#define CARDBUS_IO_SIZE		(4096)
-#define CARDBUS_MEM_SIZE	(32*1024*1024)
+#define CARDBUS_IO_SIZE		(256)
+#define CARDBUS_MEM_SIZE	(32*1024*1024)

 static void __devinit
 pbus_assign_resources_sorted(struct pci_bus *bus)


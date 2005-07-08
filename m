Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262640AbVGHG3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262640AbVGHG3Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 02:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262637AbVGHG3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 02:29:24 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:36248 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S262640AbVGHG27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 02:28:59 -0400
Date: Fri, 8 Jul 2005 10:28:52 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Tero Roponen <teanropo@cc.jyu.fi>
Cc: Jon Smirl <jonsmirl@gmail.com>, gregkh@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc2 hangs at boot
Message-ID: <20050708102852.B612@den.park.msu.ru>
References: <Pine.GSO.4.58.0507061638380.13297@tukki.cc.jyu.fi> <9e47339105070618273dfb6ff8@mail.gmail.com> <20050707135928.A3314@jurassic.park.msu.ru> <Pine.GSO.4.58.0507071324560.26776@tukki.cc.jyu.fi> <20050707163140.A4006@jurassic.park.msu.ru> <Pine.GSO.4.58.0507071546560.29406@tukki.cc.jyu.fi> <20050707174158.A4318@jurassic.park.msu.ru> <Pine.GSO.4.58.0507071709170.697@tukki.cc.jyu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.58.0507071709170.697@tukki.cc.jyu.fi>; from teanropo@cc.jyu.fi on Thu, Jul 07, 2005 at 05:13:49PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2005 at 05:13:49PM +0300, Tero Roponen wrote:
> I applied your original patch (the no-op one) and the
> end=0 patch. With those applied I could boot into login
> prompt.

Puzzling. None of these patches should affect your setup.
And you still have DMA timeouts...

> Attached are lspci -vv and dmesg outputs from
> 2.6.12 and 2.6.13-rc2 kernels.

The only difference is that under 2.6.13-rc2 the cardbus ranges
are a lot bigger. With the patch here your PCI setup should be
identical to 2.6.12. I don't think this fixes DMA problem,
but just to be sure...

Ivan.

--- 2.6.13-rc2/drivers/pci/setup-bus.c	Thu Jul  7 01:32:43 2005
+++ linux/drivers/pci/setup-bus.c	Fri Jul  8 10:25:20 2005
@@ -40,8 +40,8 @@
  * FIXME: IO should be max 256 bytes.  However, since we may
  * have a P2P bridge below a cardbus bridge, we need 4K.
  */
-#define CARDBUS_IO_SIZE		(4096)
-#define CARDBUS_MEM_SIZE	(32*1024*1024)
+#define CARDBUS_IO_SIZE		(256)
+#define CARDBUS_MEM_SIZE	(4*1024*1024)
 
 static void __devinit
 pbus_assign_resources_sorted(struct pci_bus *bus)

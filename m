Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315168AbSFAJDO>; Sat, 1 Jun 2002 05:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315424AbSFAJDN>; Sat, 1 Jun 2002 05:03:13 -0400
Received: from maile.telia.com ([194.22.190.16]:21188 "EHLO maile.telia.com")
	by vger.kernel.org with ESMTP id <S315168AbSFAJDM>;
	Sat, 1 Jun 2002 05:03:12 -0400
To: Alessandro Suardi <alessandro.suardi@oracle.com>
Cc: linux-kernel@vger.kernel.org, mochel@geena.pdx.osdl.net
Subject: Re: 2.5.19 OOPS in pcmcia setup code
In-Reply-To: <3CF6843C.6090101@oracle.com>
From: Peter Osterlund <petero2@telia.com>
Date: 01 Jun 2002 11:03:02 +0200
Message-ID: <m2bsavpe0p.fsf@ppro.localdomain>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alessandro Suardi <alessandro.suardi@oracle.com> writes:

> decoded oops follows, 100% reproducable.
> 
> Dell Latitude CPxJ750GT, PIII-750, Xircom RBEM56G100-TX,
>   kernel compiled with GCC 3.1. NB, 2.5.18 compiled with
>   GCC 3.1 works fine.
> 
> I tried recompiling with RH7.3 GCC but I still get an oops
>   on boot - I can't decode it since it scrolls maybe a dozen
>   screenfuls before stopping, so here's the GCC 3.1 one:

My laptop also oopses on boot, but this patch makes things work again:

--- drivers/pci/hotplug.c.old	Sat Jun  1 10:53:53 2002
+++ drivers/pci/hotplug.c	Sat Jun  1 10:52:05 2002
@@ -61,7 +61,7 @@
 	struct list_head *ln;
 
 	for(ln=pci_bus_type.drivers.next; ln != &pci_bus_type.drivers; ln=ln->next) {
-		struct pci_driver *drv = list_entry(ln, struct pci_driver, node);
+		struct pci_driver *drv = list_entry(ln, struct pci_driver, driver.bus_list);
 		if (drv->remove && pci_announce_device(drv, dev))
 			break;
 	}

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340

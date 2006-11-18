Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756087AbWKRAMA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756087AbWKRAMA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 19:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753553AbWKRALl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 19:11:41 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:51974 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1756070AbWKRAGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 19:06:30 -0500
Date: Sat, 18 Nov 2006 01:06:29 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Alan Cox <alan@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [2.6 patch] mark pci_find_device() as __deprecated
Message-ID: <20061118000629.GW31879@stusta.de>
References: <20061114014125.dd315fff.akpm@osdl.org> <20061117142145.GX31879@stusta.de> <20061117143236.GA23210@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061117143236.GA23210@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2006 at 09:32:36AM -0500, Alan Cox wrote:
> On Fri, Nov 17, 2006 at 03:21:45PM +0100, Adrian Bunk wrote:
> > This patch removes the no longer used pci_find_device_reverse().
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> Acked-by: Alan Cox <alan@redhat.com>
> 
> Soon we should deprecate pci_find_device as well

So let's mark it as __deprecated now, which also has the side effect 
that noone can later whine that removing it might break some shiny 
external modules.

Oh, and if anything starts complaining "But this adds some warnings to 
my kernel build!", he should either first fix the 200 kB (sic) of 
warnings I'm getting in 2.6.19-rc5-mm2 starting at MODPOST or go to hell.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc5-mm2/include/linux/pci.h.old	2006-11-18 01:03:27.000000000 +0100
+++ linux-2.6.19-rc5-mm2/include/linux/pci.h	2006-11-18 01:05:46.000000000 +0100
@@ -441,7 +441,7 @@
 
 /* Generic PCI functions exported to card drivers */
 
-struct pci_dev *pci_find_device (unsigned int vendor, unsigned int device, const struct pci_dev *from);
+struct pci_dev __deprecated *pci_find_device (unsigned int vendor, unsigned int device, const struct pci_dev *from);
 struct pci_dev *pci_find_slot (unsigned int bus, unsigned int devfn);
 int pci_find_capability (struct pci_dev *dev, int cap);
 int pci_find_next_capability (struct pci_dev *dev, u8 pos, int cap);

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262455AbUCaUhQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 15:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbUCaUhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 15:37:16 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:24012 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262455AbUCaUhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 15:37:13 -0500
Date: Wed, 31 Mar 2004 22:37:04 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [2.6 patch] fix ALSA au88x0 compilation
Message-ID: <20040331203704.GQ6551@fs.tum.de>
References: <Pine.LNX.4.58.0403311458260.27373@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403311458260.27373@pnote.perex-int.cz>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2004 at 03:02:19PM +0200, Jaroslav Kysela wrote:
>...
> <perex@suse.cz> (04/03/30 1.1720)
>    ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
>    au88x0 driver
>    Cleanups - removed duplicate PCI IDs
>...


They weren't exactly duplicated, resulting in the following compile 
error:


<--  snip  -->

...
  CC [M]  sound/pci/au88x0/au8810.o
sound/pci/au88x0/au8810.c:4: `PCI_DEVICE_ID_AUREAL_ADVANTAGE' undeclared 
here (not in a function)
sound/pci/au88x0/au8810.c:4: initializer element is not constant
sound/pci/au88x0/au8810.c:4: (near initialization for 
`snd_vortex_ids[0].device')
In file included from sound/pci/au88x0/au8810.c:9:
sound/pci/au88x0/au88x0_core.c: In function `vortex_connect_default':
sound/pci/au88x0/au88x0_core.c:2059: `PCI_DEVICE_ID_AUREAL_VORTEX' 
undeclared (first use in this function)
sound/pci/au88x0/au88x0_core.c:2059: (Each undeclared identifier is 
reported only once
sound/pci/au88x0/au88x0_core.c:2059: for each function it appears in.)
sound/pci/au88x0/au88x0_core.c:2059: `PCI_DEVICE_ID_AUREAL_VORTEX2' 
undeclared (first use in this function)
sound/pci/au88x0/au88x0_core.c:2059: `PCI_DEVICE_ID_AUREAL_ADVANTAGE' 
undeclared (first use in this function)
make[3]: *** [sound/pci/au88x0/au8810.o] Error 1

<--  snip  -->


The following patch fixes this problem:


--- linux-2.6.5-rc3-modular/include/linux/pci_ids.h.old	2004-03-31 22:00:54.000000000 +0200
+++ linux-2.6.5-rc3-modular/include/linux/pci_ids.h	2004-03-31 22:01:26.000000000 +0200
@@ -1634,8 +1634,9 @@
 #define PCI_SUBDEVICE_ID_CHASE_PCIRAS8		0xF010
 
 #define PCI_VENDOR_ID_AUREAL		0x12eb
-#define PCI_DEVICE_ID_AUREAL_VORTEX_1	0x0001
-#define PCI_DEVICE_ID_AUREAL_VORTEX_2	0x0002
+#define PCI_DEVICE_ID_AUREAL_VORTEX	0x0001
+#define PCI_DEVICE_ID_AUREAL_VORTEX2	0x0002
+#define PCI_DEVICE_ID_AUREAL_ADVANTAGE	0x0003
 
 #define PCI_VENDOR_ID_ELECTRONICDESIGNGMBH 0x12f8
 #define PCI_DEVICE_ID_LML_33R10		0x8a02



Please apply
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


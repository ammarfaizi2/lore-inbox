Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266810AbSKWJRO>; Sat, 23 Nov 2002 04:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266944AbSKWJRN>; Sat, 23 Nov 2002 04:17:13 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:11974 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S266810AbSKWJRN>; Sat, 23 Nov 2002 04:17:13 -0500
Date: Sat, 23 Nov 2002 10:24:18 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Loic Jaquemet <jal@les3stagiaires.freeserve.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.49 - bttv module not compiling
Message-ID: <20021123092417.GA14886@fs.tum.de>
References: <20021123041250.10af38e3.jal@les3stagiaires.freeserve.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20021123041250.10af38e3.jal@les3stagiaires.freeserve.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 23, 2002 at 04:12:50AM +0000, Loic Jaquemet wrote:

>...
> struct pci_dev has no name member ? line 2993.
> 
>         struct pci_dev *dev = NULL;
> 	[...]
>                 printk(KERN_INFO "bttv: Host bridge is %s\n",dev->name);
> 
> 
>   gcc -Wp,-MD,drivers/media/video/.bttv-cards.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6 -Iarch/i386/mach-generic -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=bttv_cards -DKBUILD_MODNAME=bttv   -c -o drivers/media/video/bttv-cards.o drivers/media/video/bttv-cards.c
>...
> drivers/media/video/bttv-cards.c:2993: structure n'a pas de membre nommé « name »
> make[3]: *** [drivers/media/video/bttv-cards.o] Erreur 1
> make[2]: *** [drivers/media/video] Erreur 2
> make[1]: *** [drivers/media] Erreur 2
> make: *** [drivers] Erreur 2
>...

Petr Vandrovec <vandrove@vc.cvut.cz> sent the following patch to fix
this compile error:


diff -urdN linux/drivers/media/video/bttv-cards.c linux/drivers/media/video/bttv-cards.c
--- linux/drivers/media/video/bttv-cards.c	2002-11-18 13:50:42.000000000 +0000
+++ linux/drivers/media/video/bttv-cards.c	2002-11-18 13:55:51.000000000 +0000
@@ -2990,7 +2990,7 @@
 
 	/* print which chipset we have */
 	while ((dev = pci_find_class(PCI_CLASS_BRIDGE_HOST << 8,dev)))
-		printk(KERN_INFO "bttv: Host bridge is %s\n",dev->name);
+		printk(KERN_INFO "bttv: Host bridge is %s\n",dev->dev.name);
 
 	/* print warnings about any quirks found */
 	if (triton1)


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbTEKIlf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 04:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbTEKIle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 04:41:34 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:22508 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261179AbTEKIld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 04:41:33 -0400
Date: Sun, 11 May 2003 10:54:11 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [patch] 2.5.69-dj1: tlan.c doesn't compile
Message-ID: <20030511085411.GZ1107@fs.tum.de>
References: <20030510145653.GA26216@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030510145653.GA26216@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<--  snip  -->

...
  gcc -Wp,-MD,drivers/net/.tlan.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=k6 
-Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    
-DKBUILD_BASENAME=tlan -DKBUILD_MODNAME=tlan -c -o drivers/net/tlan.o 
drivers/net/tlan.c
drivers/net/tlan.c:1539:21: warning: extra tokens at end of #ifdef directive
drivers/net/tlan.c:1540:2: #error "Not 64bit clean"
make[2]: *** [drivers/net/tlan.o] Error 1

<--  snip  -->


This is a bug only present in -dj, the fix is simple:


--- linux-2.5.69-dj1/drivers/net/tlan.c.old	2003-05-11 10:45:40.000000000 +0200
+++ linux-2.5.69-dj1/drivers/net/tlan.c	2003-05-11 10:47:19.000000000 +0200
@@ -1536,7 +1536,7 @@
 				t = (void *) skb_put( new_skb, TLAN_MAX_FRAME_SIZE );
 				head_list->buffer[0].address = pci_map_single(priv->pciDev, new_skb->data, TLAN_MAX_FRAME_SIZE, PCI_DMA_FROMDEVICE);
 				head_list->buffer[8].address = (u32) t;
-#ifdef BITS_PER_LONG==64
+#if BITS_PER_LONG == 64
 #error "Not 64bit clean"
 #endif				
 				head_list->buffer[9].address = (u32) new_skb;


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


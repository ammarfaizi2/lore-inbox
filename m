Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264223AbTEXIdF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 04:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264226AbTEXIdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 04:33:05 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:52477 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264223AbTEXIdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 04:33:03 -0400
Date: Sat, 24 May 2003 10:46:06 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, jt@hpl.hp.com
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [2.4 patch] fix wavelan_cs compile warning
Message-ID: <20030524084605.GD1824@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I saw the following compile warning in 2.4.21-rc3:

<--  snip  -->

...
make[3]: Entering directory `/home/bunk/linux/kernel-2.4/linux-2.4.21-rc3-modular/drivers/net/pcmcia'
...
gcc -D__KERNEL__ 
-I/home/bunk/linux/kernel-2.4/linux-2.4.21-rc3-modular/include 
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6 -DMODULE -DMODVERSIONS 
-include /home/bunk/linux/kernel-2.4/linux-2.4.21-rc3-modular/include/linux/modversions.h  
-nostdinc -iwithprefix include -DKBUILD_BASENAME=wavelan_cs  -c -o 
wavelan_cs.o wavelan_cs.c
In file included from wavelan_cs.c:67:
wavelan_cs.h:492:33: warning: extra tokens at end of #undef directive
...

<--  snip  -->


The fix is trivial:


--- linux-2.4.21-rc3-modular/drivers/net/pcmcia/wavelan_cs.h.old	2003-05-24 10:38:32.000000000 +0200
+++ linux-2.4.21-rc3-modular/drivers/net/pcmcia/wavelan_cs.h	2003-05-24 10:38:53.000000000 +0200
@@ -489,7 +489,7 @@
 #undef DEBUG_RX_INFO		/* Header of the transmitted packet */
 #undef DEBUG_RX_FAIL		/* Normal failure conditions */
 #define DEBUG_RX_ERROR		/* Unexpected conditions */
-#undef DEBUG_PACKET_DUMP	32	/* Dump packet on the screen */
+#undef DEBUG_PACKET_DUMP	/* Dump packet on the screen */
 #undef DEBUG_IOCTL_TRACE	/* Misc call by Linux */
 #undef DEBUG_IOCTL_INFO		/* Various debug info */
 #define DEBUG_IOCTL_ERROR	/* What's going wrong */


I've tested the compilation with 2.4.21-rc3.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


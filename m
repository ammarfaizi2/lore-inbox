Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263962AbTCUUBf>; Fri, 21 Mar 2003 15:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263957AbTCUUAn>; Fri, 21 Mar 2003 15:00:43 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:40415 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S263956AbTCUT7Q>; Fri, 21 Mar 2003 14:59:16 -0500
Date: Fri, 21 Mar 2003 21:10:12 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: pwaechtler@mac.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.5 patch] fix sound/oss/ics2101.c compilation
Message-ID: <20030321201012.GO6940@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

it seems your "oss sound cli cleanup" patch that was included into 2.5 
some months ago has caused the following problem:

The final linking of the kernel fails with the following error:

<--  snip  -->

...
sound/built-in.o(.text+0x2dc86): In function `write_mix':
: undefined reference to `lock'
sound/built-in.o(.text+0x2dc91): In function `write_mix':
: undefined reference to `lock'
sound/built-in.o(.text+0x2dcaa): In function `write_mix':
: undefined reference to `lock'
sound/built-in.o(.text+0x2dcb3): In function `write_mix':
: undefined reference to `lock'
sound/built-in.o(.text+0x2dcc7): In function `write_mix':
: undefined reference to `lock'
sound/built-in.o(.text+0x2dcd1): more undefined references to `lock' 
follow
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


The following patch fixes the problem for me, please check whether it's 
correct:

--- linux-2.5.65-full/sound/oss/ics2101.c.old	2003-03-21 19:13:23.000000000 +0100
+++ linux-2.5.65-full/sound/oss/ics2101.c	2003-03-21 19:13:53.000000000 +0100
@@ -29,7 +29,7 @@
 
 extern int     *gus_osp;
 extern int      gus_base;
-extern spinlock_t lock;
+spinlock_t      lock = SPIN_LOCK_UNLOCKED;
 static int      volumes[ICS_MIXDEVS];
 static int      left_fix[ICS_MIXDEVS] =
 {1, 1, 1, 2, 1, 2};



TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


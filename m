Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267377AbTBKSGU>; Tue, 11 Feb 2003 13:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267452AbTBKSGU>; Tue, 11 Feb 2003 13:06:20 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:62718 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267377AbTBKSGT>; Tue, 11 Feb 2003 13:06:19 -0500
Date: Tue, 11 Feb 2003 19:16:00 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: James Bottomley <james.bottomley@steeleye.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.5.60: sim710.c doesn't compile
Message-ID: <20030211181600.GP17128@fs.tum.de>
References: <Pine.LNX.4.44.0302101103570.1348-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302101103570.1348-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2003 at 11:08:28AM -0800, Linus Torvalds wrote:
>...
> Summary of changes from v2.5.59 to v2.5.60
> ============================================
>...
> James Bottomley <james.bottomley@steeleye.com>:
>...
>   o [SCSI] Migrate sim710 to 53c700 chip driver
>...

This change broke the compilation of sim710.c:

<--  snip  -->

...
  gcc -Wp,-MD,drivers/scsi/.sim710.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=k6 
-Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    
-DKBUILD_BASENAME=sim710 -DKBUILD_MODNAME=sim710 -c -o 
drivers/scsi/sim710.o drivers/scsi/sim710.c
drivers/scsi/sim710.c:329: `sim710_device_remove' undeclared here (not in a function)
drivers/scsi/sim710.c:329: initializer element is not constant
drivers/scsi/sim710.c:329: (near initialization for `sim710_eisa_driver.driver.remove')
drivers/scsi/sim710.c:330: initializer element is not constant
drivers/scsi/sim710.c:330: (near initialization for `sim710_eisa_driver.driver')
make[2]: *** [drivers/scsi/sim710.o] Error 1

<--  snip  -->

This is the only occurence of sim710_device_remove in the whole kernel 
tree.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


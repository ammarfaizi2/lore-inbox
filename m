Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312582AbSEHJdn>; Wed, 8 May 2002 05:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312590AbSEHJdn>; Wed, 8 May 2002 05:33:43 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:3100 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S312582AbSEHJdl>; Wed, 8 May 2002 05:33:41 -0400
Date: Wed, 8 May 2002 11:34:28 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Pozsar Balazs <pozsy@uhulinux.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Eyal Lebedinsky <eyal@eyal.emu.id.au>
Subject: Re: 2.4.19pre8aa2
Message-ID: <20020508113428.D31998@dualathlon.random>
In-Reply-To: <20020504165440.C1260@dualathlon.random> <Pine.GSO.4.30.0205080424500.4222-200000@balu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2002 at 04:27:23AM +0200, Pozsar Balazs wrote:
> On Sat, 4 May 2002, Andrea Arcangeli wrote:
> 
> > This basically fixes a few compile problems (most of them noticed by
> > Eyal incidentally in CC) with some driver that I don't use myself and it
> > cleanups some other bit like with vmalloc_to_page. Nothing important
> > here if aa1 just compiled for you.
> 
> Unfortunately I still have a compile problem.
> With CONFIG_BLK_DEV_UMEM=m I get this:
> 
> make -C block modules
> make[2]: Entering directory `/home/pozsy/DEV/kernel/compile/2.4.19-pre8-aa2/drivers/block'
> gcc -D__KERNEL__ -I/home/pozsy/DEV/kernel/compile/2.4.19-pre8-aa2/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i586 -DMODULE -DMODVERSIONS -include /home/pozsy/DEV/kernel/compile/2.4.19-pre8-aa2/include/linux/modversions.h  -nostdinc -I /usr/lib/gcc-lib/i386-pc-linux-gnu/2.95.3/include -DKBUILD_BASENAME=umem  -c -o umem.o umem.c
> umem.c:955: warning: `set_bh_page' redefined
> /home/pozsy/DEV/kernel/compile/2.4.19-pre8-aa2/include/linux/modules/buffer.ver:8: warning: this is the location of the previous definition
> umem.c:136: field `tasklet' has incomplete type
> umem.c: In function `mm_start_io':
> umem.c:343: warning: right shift count >= width of type
> umem.c: In function `mm_unplug_device':
> umem.c:386: warning: implicit declaration of function `local_bh_disable'
> umem.c:388: warning: implicit declaration of function `local_bh_enable'
> umem.c: In function `mm_interrupt':
> umem.c:646: warning: implicit declaration of function `tasklet_schedule'
> umem.c: In function `mm_pci_probe':
> umem.c:1178: warning: implicit declaration of function `tasklet_init_Ra5808bbf'
> umem.c: In function `mm_pci_remove':
> umem.c:1313: warning: implicit declaration of function `tasklet_kill_R79ad224b'
> make[2]: *** [umem.o] Error 1
> make[2]: Leaving directory `/home/pozsy/DEV/kernel/compile/2.4.19-pre8-aa2/drivers/block'
> make[1]: *** [_modsubdir_block] Error 2
> make[1]: Leaving directory `/home/pozsy/DEV/kernel/compile/2.4.19-pre8-aa2/drivers'
> make: *** [_mod_drivers] Error 2

--- 2.4.19pre8aa3/drivers/block/umem.c.~1~	Fri May  3 02:12:07 2002
+++ 2.4.19pre8aa3/drivers/block/umem.c	Wed May  8 11:32:44 2002
@@ -42,6 +42,7 @@
 #include <linux/smp_lock.h>
 #include <linux/timer.h>
 #include <linux/pci.h>
+#include <linux/interrupt.h>
 
 #include <linux/fcntl.h>        /* O_ACCMODE */
 #include <linux/hdreg.h>  /* HDIO_GETGEO */

Andrea

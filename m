Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261842AbSLAOdm>; Sun, 1 Dec 2002 09:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261847AbSLAOdm>; Sun, 1 Dec 2002 09:33:42 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:14828 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261842AbSLAOdl>; Sun, 1 Dec 2002 09:33:41 -0500
Date: Sun, 1 Dec 2002 15:41:02 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Linus Torvalds <torvalds@transmeta.com>,
       Doug Ledford <dledford@aladin.rdu.redhat.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.50
Message-ID: <20021201144102.GF29084@fs.tum.de>
References: <Pine.LNX.4.44.0211271456160.18214-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211271456160.18214-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2002 at 03:07:38PM -0800, Linus Torvalds wrote:

>...
> Summary of changes from v2.5.49 to v2.5.50
> ============================================
>...
> Doug Ledford <dledford@aladin.rdu.redhat.com>:
>...
>   o Convert from host->host_queue to host->my_devices list usage Add in
>     usage of new same_target_siblings list Add
>     scsi_release_commandblocks() call to scsi_free_sdev() Make all scsi
>     device freeing use scsi_free_sdev()
>...

The change to eata_pio_proc.c contains a typo:

<--  snip  -->

...
  gcc -Wp,-MD,drivers/scsi/.eata_pio.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=k6 -Iarch/i386/mach-generic 
-nostdinc -iwithprefix include    -DKBUILD_BASENAME=eata_pio 
-DKBUILD_MODNAME=eata_pio 
  -c -o drivers/scsi/eata_pio.o drivers/scsi/eata_pio.c
In file included from drivers/scsi/eata_pio.c:94:
drivers/scsi/eata_pio_proc.c:88: macro `list_for_each_entry' used with only 2 args
In file included from drivers/scsi/eata_pio.c:94:
drivers/scsi/eata_pio_proc.c: In function `eata_pio_proc_info':
drivers/scsi/eata_pio_proc.c:88: parse error before `)'
...
make[2]: *** [drivers/scsi/eata_pio.o] Error 1

<--  snip  -->


The fix is simple:


--- linux-2.5.50/drivers/scsi/eata_pio_proc.c.old	2002-12-01 15:32:22.000000000 +0100
+++ linux-2.5.50/drivers/scsi/eata_pio_proc.c	2002-12-01 15:32:50.000000000 +0100
@@ -85,7 +85,7 @@
     len += size; 
     pos = begin + len;
     
-    list_for_each_entry(scd, &HBA_ptr->my_devices; siblings) {
+    list_for_each_entry(scd, &HBA_ptr->my_devices, siblings) {
 	    proc_print_scsidevice(scd, buffer, &size, len);
 	    len += size; 
 	    pos = begin + len;


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbTIFUO2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 16:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbTIFUO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 16:14:28 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:60151 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261756AbTIFUO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 16:14:26 -0400
Date: Sat, 6 Sep 2003 22:14:18 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>, jsimmons@infradead.org,
       "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6: spurious recompiles
Message-ID: <20030906201417.GI14436@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When doing a "make" inside an already compiled kernel source there 
shouldn't be anything rebuilt. I've identified three places where this 
isn't the case in recent 2.6 kernels:

1. ikconfig
  CC      kernel/configs.o
even when the .config wasn't changed

2. pnmtologo
The following happens again once, but not when doing a third "make":
  ./scripts/pnmtologo -t mono -n logo_linux_mono -o drivers/video/logo/logo_linux_mono.c drivers/video/logo/logo_linux_mono.pbm
  CC      drivers/video/logo/logo_linux_mono.o
  ./scripts/pnmtologo -t vga16 -n logo_linux_vga16 -o drivers/video/logo/logo_linux_vga16.c drivers/video/logo/logo_linux_vga16.ppm
  CC      drivers/video/logo/logo_linux_vga16.o
  ./scripts/pnmtologo -t clut224 -n logo_linux_clut224 -o drivers/video/logo/logo_linux_clut224.c drivers/video/logo/logo_linux_clut224.ppm
  CC      drivers/video/logo/logo_linux_clut224.o
  LD      drivers/video/logo/built-in.o
  LD      drivers/video/built-in.o

3. aic7xxx
  drivers/scsi/aic7xxx/aicasm/aicasm -Idrivers/scsi/aic7xxx -r 
  drivers/scsi/aic7xxx/aic79xx_reg.h \
                      -p drivers/scsi/aic7xxx/aic79xx_reg_print.c -i 
  aic79xx_osm.h -o drivers/scsi/aic7xxx/aic79xx_seq.h \
                      drivers/scsi/aic7xxx/aic79xx.seq
  drivers/scsi/aic7xxx/aicasm/aicasm: 785 instructions used
  CC      drivers/scsi/aic7xxx/aic79xx_core.o
  CC      drivers/scsi/aic7xxx/aic79xx_pci.o
  CC      drivers/scsi/aic7xxx/aic79xx_reg_print.o
  CC      drivers/scsi/aic7xxx/aic79xx_osm.o
  CC      drivers/scsi/aic7xxx/aic79xx_proc.o
  CC      drivers/scsi/aic7xxx/aic79xx_osm_pci.o
  drivers/scsi/aic7xxx/aicasm/aicasm -Idrivers/scsi/aic7xxx -r 
  drivers/scsi/aic7xxx/aic7xxx_reg.h \
                      -p drivers/scsi/aic7xxx/aic7xxx_reg_print.c -i 
  aic7xxx_osm.h -o drivers/scsi/aic7xxx/aic7xxx_seq.h \
                      drivers/scsi/aic7xxx/aic7xxx.seq
  drivers/scsi/aic7xxx/aicasm/aicasm: 879 instructions used
  CC      drivers/scsi/aic7xxx/aic7xxx_core.o
  CC      drivers/scsi/aic7xxx/aic7xxx_93cx6.o
  CC      drivers/scsi/aic7xxx/aic7770.o
  CC      drivers/scsi/aic7xxx/aic7xxx_pci.o
  CC      drivers/scsi/aic7xxx/aic7xxx_reg_print.o
  CC      drivers/scsi/aic7xxx/aic7xxx_osm.o
  CC      drivers/scsi/aic7xxx/aic7xxx_proc.o
  CC      drivers/scsi/aic7xxx/aic7770_osm.o
  CC      drivers/scsi/aic7xxx/aic7xxx_osm_pci.o
  LD      drivers/scsi/aic7xxx/aic7xxx.o
  LD      drivers/scsi/aic7xxx/aic79xx.o
  LD      drivers/scsi/aic7xxx/built-in.o


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265039AbTBAXOu>; Sat, 1 Feb 2003 18:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265051AbTBAXOu>; Sat, 1 Feb 2003 18:14:50 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:34529 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S265039AbTBAXOt>; Sat, 1 Feb 2003 18:14:49 -0500
Date: Sun, 2 Feb 2003 00:24:10 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre4
Message-ID: <20030201232410.GE6915@fs.tum.de>
References: <Pine.LNX.4.53L.0301290143350.27119@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53L.0301290143350.27119@freak.distro.conectiva>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the following compile error in 2.4.21-pre4:

<--  snip  -->

...
ld -m elf_i386  -r -o idedriver-raid.o ataraid.o pdcraid.o hptraid.o 
silraid.o
silraid.o(.text+0x31c): In function `partition_map_normal':
: multiple definition of `partition_map_normal'
pdcraid.o(.text+0x31c): first defined here
make[4]: *** [idedriver-raid.o] Error 1
make[4]: Leaving directory 
`/home/bunk/linux/kernel-2.4/linux-2.4.20-full/drivers/ide/raid'

<--  snip  -->

The following patch (stolen from -ac) fixes it:

--- linux.21pre4/drivers/ide/raid/silraid.c	2003-01-29 17:07:45.000000000 +0000
+++ linux.21pre4-ac1/drivers/ide/raid/silraid.c	2003-01-09 19:43:30.000000000 +0000
@@ -157,7 +157,7 @@
 }
 
 
-unsigned long partition_map_normal(unsigned long block, unsigned long partition_off, unsigned long partition_size, int stride)
+static unsigned long partition_map_normal(unsigned long block, unsigned long partition_off, unsigned long partition_size, int stride)
 {
 	return block + partition_off;
 }


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


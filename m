Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265960AbTAIMFy>; Thu, 9 Jan 2003 07:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266271AbTAIMFy>; Thu, 9 Jan 2003 07:05:54 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:37834 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S265960AbTAIMFx>; Thu, 9 Jan 2003 07:05:53 -0500
Date: Thu, 9 Jan 2003 13:14:32 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Alan Cox <alan@redhat.com>, Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21pre3-ac2
Message-ID: <20030109121431.GQ6626@fs.tum.de>
References: <200301090139.h091d9G26412@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301090139.h091d9G26412@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2003 at 08:39:09PM -0500, Alan Cox wrote:
>...
> Linux 2.4.21pre3-ac1
>...
> +	IDE Raid support for AMI/SI 'Medley' IDE Raid	(Arjan van de Ven)
>...

This causes a compile error if both pdcraid.o and silraid.o are compiled 
statically into the kernel:

<--  snip  -->

...
gcc -D__KERNEL__ -I/home/bunk/linux/kernel-2.4/linux-2.4.20-ac/include 
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6  -I../ 
-nostdinc -iwithprefix include -DKBUILD_BASENAME=pdcraid  -c -o 
pdcraid.o pdcraid.c
...
gcc -D__KERNEL__ -I/home/bunk/linux/kernel-2.4/linux-2.4.20-ac/include 
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6  -I../ 
-nostdinc -iwithprefix include -DKBUILD_BASENAME=silraid  -c -o 
silraid.o silraid.c
rm -f idedriver-raid.o
ld -m elf_i386  -r -o idedriver-raid.o ataraid.o pdcraid.o hptraid.o 
silraid.o
silraid.o(.text+0x31c): In function `partition_map_normal':
: multiple definition of `partition_map_normal'
pdcraid.o(.text+0x31c): first defined here
make[4]: *** [idedriver-raid.o] Error 1
make[4]: Leaving directory 
`/home/bunk/linux/kernel-2.4/linux-2.4.20-ac/drivers/ide/raid'

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


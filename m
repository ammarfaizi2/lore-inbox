Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135217AbRDVESA>; Sun, 22 Apr 2001 00:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135221AbRDVERv>; Sun, 22 Apr 2001 00:17:51 -0400
Received: from leng.mclure.org ([64.81.48.142]:7172 "EHLO
	leng.internal.mclure.org") by vger.kernel.org with ESMTP
	id <S135217AbRDVERd>; Sun, 22 Apr 2001 00:17:33 -0400
Date: Sat, 21 Apr 2001 21:17:22 -0700
From: Manuel McLure <manuel@mclure.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.3-ac12
Message-ID: <20010421211722.C976@ulthar.internal.mclure.org>
In-Reply-To: <E14rA0N-0004sv-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <E14rA0N-0004sv-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, Apr 21, 2001 at 19:53:38 -0700
X-Mailer: Balsa 1.1.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2001.04.21 19:53 Alan Cox wrote:
> 
> 	ftp://ftp.kernel.org/pub/linux/kernel/people/alan/2.4/
> 
> 		Intermediate diffs are available from
> 
> 			http://www.bzimage.org
> 
> 2.4.3-ac12
> o	Further semaphore fixes				(David
Howells)

Something's wrong with this - it won't build with RH 7.1 kgcc
(egcs-2.91.66):

ld -m elf_i386 -T /usr/src/linux-2.4.3-ac12/arch/i386/vmlinux.lds -e stext
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
init/version.o \
	--start-group \
	arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o
fs/fs.o ipc/ipc.o \
	drivers/block/block.o drivers/char/char.o drivers/misc/misc.o
drivers/net/net.o drivers/media/media.o  drivers/char/drm/drm.o
drivers/net/fc/fc.o drivers/net/appletalk/appletalk.o
drivers/net/tokenring/tr.o drivers/net/wan/wan.o drivers/atm/atm.o
drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o
drivers/pci/driver.o drivers/pnp/pnp.o drivers/video/video.o
drivers/acpi/acpi.o arch/i386/math-emu/math.o \
	net/network.o \
	/usr/src/linux-2.4.3-ac12/arch/i386/lib/lib.a
/usr/src/linux-2.4.3-ac12/lib/lib.a /usr/src/linux-2.4.3-ac12/arch/i386/lib/lib.a
\
	--end-group \
	-o vmlinux
/usr/src/linux-2.4.3-ac12/lib/lib.a(rwsem.o): In function
`rwsem_down_read_failed':
rwsem.o(.text+0x73): undefined reference to `__builtin_expect'
/usr/src/linux-2.4.3-ac12/lib/lib.a(rwsem.o): In function
`rwsem_down_write_failed':
rwsem.o(.text+0x1d3): undefined reference to `__builtin_expect'
/usr/src/linux-2.4.3-ac12/lib/lib.a(rwsem.o): In function
`rwsem_up_read_wake':
rwsem.o(.text+0x2ed): undefined reference to `__builtin_expect'
/usr/src/linux-2.4.3-ac12/lib/lib.a(rwsem.o): In function
`rwsem_up_write_wake':rwsem.o(.text+0x3c6): undefined reference to
`__builtin_expect'
make: *** [vmlinux] Error 1
Sat Apr 21 20:35:37 PDT 2001

ac12 builds OK with the standard RH 7.1 gcc (2.96), ac11 built fine with
both the standard gcc and kgcc.

-- 
Manuel A. McLure KE6TAW | ...for in Ulthar, according to an ancient
<manuel@mclure.org>     | and significant law, no man may kill a cat.
<http://www.mclure.org> |             -- H.P. Lovecraft


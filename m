Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314343AbSEBLG1>; Thu, 2 May 2002 07:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314351AbSEBLG0>; Thu, 2 May 2002 07:06:26 -0400
Received: from pieck.student.uva.nl ([146.50.96.22]:58040 "EHLO
	pieck.student.uva.nl") by vger.kernel.org with ESMTP
	id <S314343AbSEBLGZ>; Thu, 2 May 2002 07:06:25 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rudmer van Dijk <rudmer@legolas.dynup.net>
Reply-To: rudmer@legolas.dynup.net
To: Dave Jones <davej@suse.de>
Subject: Re: Linux 2.5.12-dj1
Date: Thu, 2 May 2002 13:06:07 +0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020501203612.GA4167@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020502110625Z314343-22651+21496@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 May 2002 22:36, Dave Jones wrote:
> Back up to date against Linus. Lots of resyncing going on, still
> quite a lot left to go too.
>
Got this link error:

ld -m elf_i386 -T /usr/src/kernel/linux-2.5.12-dj1/arch/i386/vmlinux.lds -e 
stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o 
init/version.o init/do_mounts.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o 
fs/fs.o ipc/ipc.o \
        /usr/src/kernel/linux-2.5.12-dj1/arch/i386/lib/lib.a 
/usr/src/kernel/linux-2.5.12-dj1/lib/lib.o 
/usr/src/kernel/linux-2.5.12-dj1/arch/i386/lib/lib.a \
         drivers/base/base.o drivers/char/char.o drivers/block/block.o 
drivers/misc/misc.o drivers/net/net.o drivers/media/media.o 
drivers/char/agp/agp.o drivers/char/drm/drm.o drivers/ide/idedriver.o 
drivers/cdrom/driver.o sound/sound.o drivers/pci/driver.o 
drivers/video/video.o drivers/input/inputdrv.o drivers/input/serio/seriodrv.o 
\
        net/network.o \
        --end-group \
        -o vmlinux
drivers/block/block.o: In function `ramdisk_updatepage':
drivers/block/block.o(.text+0x3740): undefined reference to 
`mark_buffer_uptodate'
make: *** [vmlinux] Error 1

Grepping through the sources listed only one occurance of 
mark_buffer_uptodate:
# find . -type f | xargs grep -w mark_buffer_uptodate
./drivers/block/rd.c:                           mark_buffer_uptodate(tmp, 1);
Binary file ./drivers/block/rd.o matches
Binary file ./drivers/block/block.o matches

mark_buffer_uptodate was introduced in -2.5.12-dj1

	Rudmer

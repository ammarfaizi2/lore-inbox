Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282126AbRKWLel>; Fri, 23 Nov 2001 06:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282125AbRKWLeb>; Fri, 23 Nov 2001 06:34:31 -0500
Received: from [213.235.52.110] ([213.235.52.110]:20864 "EHLO
	chaos2.streamgroup.co.uk") by vger.kernel.org with ESMTP
	id <S282126AbRKWLeV>; Fri, 23 Nov 2001 06:34:21 -0500
Date: Fri, 23 Nov 2001 11:34:08 +0000 (GMT)
From: Alex Buell <alex.buell@tahallah.demon.co.uk>
X-X-Sender: <ab@chaos2.streamgroup.co.uk>
To: matthieu foillard <matthieu@taktile.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.15 compile problem on PPC
In-Reply-To: <20011123120950.A27067@boo.taktile.com>
Message-ID: <Pine.LNX.4.33.0111231131530.1398-100000@chaos2.streamgroup.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Nov 2001, matthieu foillard wrote:

>
> make[2]: Leaving directory `/usr/src/linux/arch/ppc/xmon'
> ld -T arch/ppc/vmlinux.lds -Ttext 0xc0000000 -Bstatic arch/ppc/kernel/head.o init/main.o init/version.o \
>   --start-group \
>   arch/ppc/kernel/kernel.o arch/ppc/mm/mm.o arch/ppc/lib/lib.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o arch/ppc/xmon/x.o \
>   drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/ide/idedriver.o drivers/cdrom/driver.o drivers/sound/sounddrivers.o drivers/pci/driver.o drivers/pcmcia/pcmcia.o drivers/net/wireless/wireless_net.o drivers/macintosh/macintosh.o drivers/video/video.o drivers/usb/usbdrv.o drivers/input/inputdrv.o \
>   net/network.o \
>   /usr/src/linux/lib/lib.a \
>   --end-group \
>   -o vmlinux
>   kernel/kernel.o: In function `show_task':
>   kernel/kernel.o(.text+0x17e0): undefined reference to `show_trace_task'
>   kernel/kernel.o(.text+0x17e0): relocation truncated to fit: R_PPC_REL24 show_trace_task
>   make[1]: *** [vmlinux] Erreur 1

I'm seeing this on sparc as well. This is because show_trace_task() is
called from kernel/sched.c, and is only implemented in i386/kernel/. This
means that other architectures that don't implement it will break. The
sparc tree is equally broken too.

-- 
(missing signature and missing his address book coz he forgot to copy them
over from his old box to the new 1GHz laptop.. what a twat, eh?)


Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312791AbSDXW5c>; Wed, 24 Apr 2002 18:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312797AbSDXW5b>; Wed, 24 Apr 2002 18:57:31 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:49390 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S312791AbSDXW5b>; Wed, 24 Apr 2002 18:57:31 -0400
Date: Thu, 25 Apr 2002 00:53:53 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Marc-Christian Petersen <mcp@linux-systeme.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.10 compile/link problem
In-Reply-To: <200204250019.46082.mcp@linux-systeme.de>
Message-ID: <Pine.NEB.4.44.0204250052380.6539-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Apr 2002, Marc-Christian Petersen wrote:

> Hi there,
>
> ld -m elf_i386 -T /usr/src/linux-2.5.10/arch/i386/vmlinux.lds -e stext
> arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
> init/version.o init/do_mounts.o \
>         --start-group \
>         arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o
> fs/fs.o ipc/ipc.o \
>         /usr/src/linux-2.5.10/arch/i386/lib/lib.a
> /usr/src/linux-2.5.10/lib/lib.a /usr/src/linux-2.5.10/arch/i386/lib/lib.a \
>          drivers/acpi/acpi.o drivers/base/base.o drivers/char/char.o
> drivers/block/block.o drivers/misc/misc.o drivers/net/net.o
> drivers/media/media.o drivers/char/drm/drm.o drivers/ide/idedriver.o
> drivers/cdrom/driver.o sound/sound.o drivers/pci/driver.o drivers/pnp/pnp.o
> drivers/video/video.o drivers/md/mddev.o \
>         net/network.o \
>         --end-group \
>         -o vmlinux
> drivers/net/net.o: In function `e100_diag_config_loopback':
> drivers/net/net.o(.text+0x5adf): undefined reference to `e100_phy_reset'
> make: *** [vmlinux] Error 1
>
> With EtherExpress Pro 100 original Becker driver.

No, this problem comes from the Alternate Intel driver for the
EtherExpressPro/100. A patch to get it compile (already posted on this
list) is:

--- drivers/net/e100/e100_phy.c.old	Wed Apr 24 23:45:52 2002
+++ drivers/net/e100/e100_phy.c	Wed Apr 24 23:46:08 2002
@@ -873,7 +873,7 @@
 	e100_set_fc(bdp);
 }

-void __devexit
+void
 e100_phy_reset(struct e100_private *bdp)
 {
 	u16 ctrl_reg;

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131349AbRC3KeJ>; Fri, 30 Mar 2001 05:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131344AbRC3KeA>; Fri, 30 Mar 2001 05:34:00 -0500
Received: from apollo.nbase.co.il ([194.90.137.2]:2568 "EHLO
	apollo.nbase.co.il") by vger.kernel.org with ESMTP
	id <S131345AbRC3Kdu>; Fri, 30 Mar 2001 05:33:50 -0500
Message-ID: <3AC461DE.65B4049@nbase.co.il>
Date: Fri, 30 Mar 2001 12:37:18 +0200
From: Eran Mann <eran@nbase.co.il>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Linus Torvalds <torvalds@transmeta.com>,
   Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Subject: [patch] 2.4.3 fails to link when IPX compiled in
Content-Type: text/plain; charset=x-user-defined
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
When compiling linux-2.4.3 with IPX built in one gets:
ld -m elf_i386 -T /mdk/src/linux-2.4.3/arch/i386/vmlinux.lds -e stext
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
init/version.o \
	--start-group \
	arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o
fs/fs.o ipc/ipc.o \
	drivers/block/block.o drivers/char/char.o drivers/misc/misc.o
drivers/net/net.o drivers/media/media.o  drivers/char/agp/agp.o
drivers/char/drm/drm.o drivers/ide/idedriver.o drivers/scsi/scsidrv.o
drivers/cdrom/driver.o drivers/sound/sounddrivers.o drivers/pci/driver.o
drivers/pnp/pnp.o drivers/video/video.o \
	net/network.o \
	/mdk/src/linux-2.4.3/arch/i386/lib/lib.a /mdk/src/linux-2.4.3/lib/lib.a
/mdk/src/linux-2.4.3/arch/i386/lib/lib.a \
	--end-group \
	-o vmlinux
net/network.o(.data+0x2ee4): undefined reference to
`sysctl_ipx_pprop_broadcasting'
make: *** [vmlinux] Error 1

The patchlet below seems to solve it.
================================================================
--- linux-2.4.3.orig/net/ipx/af_ipx.c	Fri Mar 30 11:54:55 2001
+++ linux/net/ipx/af_ipx.c	Fri Mar 30 12:29:23 2001
@@ -123,7 +123,7 @@
 static unsigned char ipxcfg_max_hops = 16;
 static char ipxcfg_auto_select_primary;
 static char ipxcfg_auto_create_interfaces;
-static int sysctl_ipx_pprop_broadcasting = 1;
+int sysctl_ipx_pprop_broadcasting = 1;
 
 /* Global Variables */
 static struct datalink_proto *p8022_datalink;

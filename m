Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280992AbRKTIX6>; Tue, 20 Nov 2001 03:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280996AbRKTIXs>; Tue, 20 Nov 2001 03:23:48 -0500
Received: from mail.parkairsystems.no ([193.216.79.10]:24326 "HELO
	server4.normarc") by vger.kernel.org with SMTP id <S280992AbRKTIXm>;
	Tue, 20 Nov 2001 03:23:42 -0500
Message-ID: <766E81E1DE3AD411BAD400508B6B830B09DD46@mailserver.parkairsystems.net>
From: Terje Dalen <t.dalen@no.parkairsystems.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: PROBLEM:  Kernel link problem (block.o)
Date: Tue, 20 Nov 2001 09:19:49 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

I have upgraded the kernel from 2.4.8 to 2.4.14 due freezing problems
with 2.4.8 (I think there must have been a deadlock with the memory/swap
handling. It only worked for 10 minutes to 6 hours). 

My link problem started when I recompiled the kernel with

CONFIG_BLK_DEV_LOOP = y

and get the following problem:

ld -m elf_i386 -T /usr/src/linux-2.4.14/arch/i386/vmlinux.lds -e stext
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
init/version.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o
fs/fs.o ipc/ipc.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o
drivers/net/net.o drivers/media/media.o drivers/char/drm/drm.o
drivers/net/fc/fc.o drivers/net/appletalk/appletalk.o
drivers/net/tokenring/tr.o drivers/net/wan/wan.o drivers/atm/atm.o
drivers/ide/idedriver.o drivers/cdrom/driver.o drivers/pci/driver.o
drivers/net/wireless/wireless_net.o drivers/pnp/pnp.o drivers/video/video.o
drivers/net/hamradio/hamradio.o drivers/md/mddev.o \
        net/network.o \
        /usr/src/linux-2.4.14/arch/i386/lib/lib.a
/usr/src/linux-2.4.14/lib/lib.a /usr/src/linux-2.4.14/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
drivers/block/block.o: In function `lo_send':
drivers/block/block.o(.text+0xb2e9): undefined reference to
`deactivate_page'
drivers/block/block.o(.text+0xb325): undefined reference to
`deactivate_page'


I can see from in the changelog that the swap.h have been changed and the 
deactivate_page function has been removed. I guess someone forgot to update
the loop.c file. Is there a patch available for the correction of loop.c?

When I compiled the kernel as a module I was able to install and run the
kernel
and actually my system have been stable for the last 14 hours.

Best regards
Terje




Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281004AbRKTJwd>; Tue, 20 Nov 2001 04:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281006AbRKTJwX>; Tue, 20 Nov 2001 04:52:23 -0500
Received: from [212.169.100.200] ([212.169.100.200]:56050 "EHLO
	sexything.nextframe.net") by vger.kernel.org with ESMTP
	id <S281005AbRKTJwQ>; Tue, 20 Nov 2001 04:52:16 -0500
Date: Tue, 20 Nov 2001 10:57:55 +0100
From: Morten Helgesen <admin@nextframe.net>
To: Terje Dalen <t.dalen@no.parkairsystems.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM:  Kernel link problem (block.o)
Message-ID: <20011120105755.V8184@sexything>
Reply-To: admin@nextframe.net
In-Reply-To: <766E81E1DE3AD411BAD400508B6B830B09DD46@mailserver.parkairsystems.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <766E81E1DE3AD411BAD400508B6B830B09DD46@mailserver.parkairsystems.net>
User-Agent: Mutt/1.3.22.1i
X-Editor: VIM - Vi IMproved 6.0
X-Keyboard: PFU Happy Hacking Keyboard
X-Operating-System: Slackware Linux (of course)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey, Terje!

Just remove the two references to deactivate_page. 

== Morten

On Tue, Nov 20, 2001 at 09:19:49AM +0100, Terje Dalen wrote:
> Hi, 
> 
> I have upgraded the kernel from 2.4.8 to 2.4.14 due freezing problems
> with 2.4.8 (I think there must have been a deadlock with the memory/swap
> handling. It only worked for 10 minutes to 6 hours). 
> 
> My link problem started when I recompiled the kernel with
> 
> CONFIG_BLK_DEV_LOOP = y
> 
> and get the following problem:
> 
> ld -m elf_i386 -T /usr/src/linux-2.4.14/arch/i386/vmlinux.lds -e stext
> arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
> init/version.o \
>         --start-group \
>         arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o
> fs/fs.o ipc/ipc.o \
>          drivers/char/char.o drivers/block/block.o drivers/misc/misc.o
> drivers/net/net.o drivers/media/media.o drivers/char/drm/drm.o
> drivers/net/fc/fc.o drivers/net/appletalk/appletalk.o
> drivers/net/tokenring/tr.o drivers/net/wan/wan.o drivers/atm/atm.o
> drivers/ide/idedriver.o drivers/cdrom/driver.o drivers/pci/driver.o
> drivers/net/wireless/wireless_net.o drivers/pnp/pnp.o drivers/video/video.o
> drivers/net/hamradio/hamradio.o drivers/md/mddev.o \
>         net/network.o \
>         /usr/src/linux-2.4.14/arch/i386/lib/lib.a
> /usr/src/linux-2.4.14/lib/lib.a /usr/src/linux-2.4.14/arch/i386/lib/lib.a \
>         --end-group \
>         -o vmlinux
> drivers/block/block.o: In function `lo_send':
> drivers/block/block.o(.text+0xb2e9): undefined reference to
> `deactivate_page'
> drivers/block/block.o(.text+0xb325): undefined reference to
> `deactivate_page'
> 
> 
> I can see from in the changelog that the swap.h have been changed and the 
> deactivate_page function has been removed. I guess someone forgot to update
> the loop.c file. Is there a patch available for the correction of loop.c?
> 
> When I compiled the kernel as a module I was able to install and run the
> kernel
> and actually my system have been stable for the last 14 hours.
> 
> Best regards
> Terje
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
mvh
Morten Helgesen 
UNIX System Administrator & C Developer 
Nextframe AS
admin@nextframe.net / 93445641
http://www.nextframe.net

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265211AbTBFAXT>; Wed, 5 Feb 2003 19:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265222AbTBFAXT>; Wed, 5 Feb 2003 19:23:19 -0500
Received: from packet.digeo.com ([12.110.80.53]:30376 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265211AbTBFAXS>;
	Wed, 5 Feb 2003 19:23:18 -0500
Date: Wed, 5 Feb 2003 16:32:43 -0800
From: Andrew Morton <akpm@digeo.com>
To: scott-kernel@thomasons.org
Cc: linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai-germaschewski@uiowa.edu>
Subject: Re: soundcard bug in 2.5.59-mm8
Message-Id: <20030205163243.3b63e810.akpm@digeo.com>
In-Reply-To: <200302051819.27136.scott-kernel@thomasons.org>
References: <200302051819.27136.scott-kernel@thomasons.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Feb 2003 00:32:48.0144 (UTC) FILETIME=[46253100:01C2CD77]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

scott thomason <scott-kernel@thomasons.org> wrote:
>
> There's an error in the link process when trying to use the 
> ES1968 driver. I haven't ever tried it on previous kernels, but 
> when this one blew, I checked it against vanilla 2.5.59, and it 
> finished fine there. Output and config options below. Let me 
> know if you need more.
> ---scott
> 
> make -f scripts/Makefile.build obj=arch/i386/lib
> echo '  Generating build number'
>   Generating build number
> . ./scripts/mkversion > .tmp_version
> mv -f .tmp_version .version
> make -f scripts/Makefile.build obj=init
>   Generating include/linux/compile.h (updated)
>   gcc -Wp,-MD,init/.version.o.d -D__KERNEL__ -Iinclude -Wall 
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
> -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon 
> -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc 
> -iwithprefix include    -DKBUILD_BASENAME=version 
> -DKBUILD_MODNAME=version -c -o init/version.o init/version.c
>    ld -m elf_i386  -r -o init/built-in.o init/main.o 
> init/version.o init/do_mounts.o init/initramfs.o
>   	ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s 
> arch/i386/kernel/head.o arch/i386/kernel/init_task.o   
> init/built-in.o --start-group  usr/built-in.o  
> arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  
> arch/i386/mach-default/built-in.o  kernel/built-in.o  
> mm/built-in.o  fs/built-in.o  ipc/built-in.o  
> security/built-in.o  crypto/built-in.o  lib/lib.a  
> arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o  
> arch/i386/pci/built-in.o  net/built-in.o --end-group  -o vmlinux
> sound/built-in.o(.text+0x3750b): In function 
> `snd_opl3_synth_event_input':
> : undefined reference to `snd_seq_instr_event'

The -mm patches include the lates from Linus's repository.  There is a large
change to sound/core/seq/Makefile there.  Seems that Kai was there ;)



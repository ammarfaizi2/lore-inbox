Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316788AbSFUUhe>; Fri, 21 Jun 2002 16:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316789AbSFUUhd>; Fri, 21 Jun 2002 16:37:33 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:59918 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S316788AbSFUUhc>; Fri, 21 Jun 2002 16:37:32 -0400
Date: Fri, 21 Jun 2002 22:37:26 +0200
From: Jurriaan on Alpha <thunder7@xs4all.nl>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.24 doesn't compile on Alpha
Message-ID: <20020621203726.GA2308@alpha.of.nowhere>
Reply-To: thunder7@xs4all.nl
References: <20020621064835.GA13502@alpha.of.nowhere> <000301c2191e$5a4a3080$010b10ac@sbp.uptime.at> <20020621141957.GA22555@alpha.of.nowhere> <20020621192405.A749@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020621192405.A749@jurassic.park.msu.ru>
User-Agent: Mutt/1.3.28i
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Date: Fri, Jun 21, 2002 at 07:24:05PM +0400
> On Fri, Jun 21, 2002 at 04:19:57PM +0200, Jurriaan on Alpha wrote:
> > I tried #define smp_num_cpus 1 in include/asm-alpha/smp.h (the non-smp
> > section) but the same line in include/asm/mmu_context.h works - for a
> > while.
> 
> I'm running 2.5.24 on sx164 with following (unfinished - SMP is broken)
> patch.
> 
This patchs helps a lot; now I get:

make[1]: Entering directory `/usr/src/linux-2.5.24/init'
  Generating /usr/src/linux-2.5.24/include/linux/compile.h (updated)
  gcc -Wp,-MD,./.version.o.d -D__KERNEL__ -I/usr/src/linux-2.5.24/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-p
ointer -fno-strict-aliasing -fno-common -pipe -mno-fp-regs -ffixed-8 -mcpu=ev56 -Wa,-mev6 -nostdinc -iwithprefix include    -DKBUILD_
BASENAME=version   -c -o version.o version.c
   ld  -r -o init.o main.o version.o do_mounts.o
make[1]: Leaving directory `/usr/src/linux-2.5.24/init'
  ld -static -T arch/alpha/vmlinux.lds -N  arch/alpha/kernel/head.o init/init.o --start-group arch/alpha/kernel/kernel.o arch/alpha/m
m/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o arch/alpha/math-emu/built-in.o /usr/src/linux-2.5.24/arch/alpha/lib/lib.a lib/lib.a
/usr/src/linux-2.5.24/arch/alpha/lib/lib.a drivers/built-in.o sound/sound.o net/network.o --end-group -o vmlinux
drivers/built-in.o(.data+0x37118): undefined reference to `local symbols in discarded section .text.exit'
net/network.o: In function `ip_conntrack_helper_register':
net/network.o(.text+0x5e68c): undefined reference to `__this_module'
net/network.o: In function `ip_conntrack_helper_unregister':
net/network.o(.text+0x5e76c): undefined reference to `__this_module'
net/network.o: In function `ip_nat_helper_register':
net/network.o(.text+0x62894): undefined reference to `__this_module'
net/network.o: In function `ip_nat_helper_unregister':
net/network.o(.text+0x62b5c): undefined reference to `__this_module'
make: *** [vmlinux] Error 1
alpha:/usr/src/linux-2.5.24#

I'll probably have to fiddle with my .config to solve this.

Thanks,
Jurriaan
-- 
Our music has many faces and many moods like the land we live in.
It is a fusion of energy and serenity
        Kansas
Debian GNU/Linux 2.4.19p10 on Alpha 990 bogomips load:0.54 0.74 0.77

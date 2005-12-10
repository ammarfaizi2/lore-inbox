Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964935AbVLJTcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964935AbVLJTcz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 14:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964945AbVLJTcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 14:32:55 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:28602 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964935AbVLJTcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 14:32:55 -0500
Subject: Re: i386 -> x86_64 cross compile failure (binutils bug?)
From: Lee Revell <rlrevell@joe-job.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20051210071935.GQ11190@wotan.suse.de>
References: <1134154208.14363.8.camel@mindpipe> <439A0746.80208@mnsu.edu>
	 <1134173138.18432.41.camel@mindpipe> <439A201D.7030103@mnsu.edu>
	 <1134179410.18432.66.camel@mindpipe> <p73oe3ppbxj.fsf@verdi.suse.de>
	 <1134191524.18432.82.camel@mindpipe> <20051210071935.GQ11190@wotan.suse.de>
Content-Type: text/plain
Date: Sat, 10 Dec 2005 14:34:33 -0500
Message-Id: <1134243273.18432.104.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-12-10 at 08:19 +0100, Andi Kleen wrote:
> On Sat, Dec 10, 2005 at 12:12:03AM -0500, Lee Revell wrote:
> > On Sat, 2005-12-10 at 01:56 -0700, Andi Kleen wrote:
> > > Lee Revell <rlrevell@joe-job.com> writes:
> > > >  - disable CONFIG_IA32_EMULATION
> > > 
> > > I just tried it here. Adding -m64 to CFLAGS/AFLAGS on a native
> > > 64bit biarch toolchain and it compiled without problems. It ends
> > > up with -m64 -m32 for the 32bit vsyscall files, but that seems
> > > to DTRT at least in gcc 4.
> > 
> > Nope, passing -m64 -m32 does not seem to DTRT on native 32bit biarch
> > toolchain:
> 
> How about this patch? 

FWIW it still fails at the final link step:

  ld -m elf_x86_64  -o .tmp_vmlinux1 -T arch/x86_64/kernel/vmlinux.lds
arch/x86_64/kernel/head.o arch/x86_64/kernel/head64.o
arch/x86_64/kernel/init_task.o  init/built-in.o --start-group
usr/built-in.o  arch/x86_64/kernel/built-in.o  arch/x86_64/mm/built-in.o
arch/x86_64/crypto/built-in.o  arch/x86_64/ia32/built-in.o
kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o
security/built-in.o  crypto/built-in.o  lib/lib.a  arch/x86_64/lib/lib.a
lib/built-in.o  arch/x86_64/lib/built-in.o  drivers/built-in.o
sound/built-in.o  arch/x86_64/pci/built-in.o  net/built-in.o
--end-group 
ld:arch/x86_64/kernel/vmlinux.lds:383: parse error
make: *** [.tmp_vmlinux1] Error 1

Here are the relevant lines of arch/x86_64/kernel/vmlinux.lds:

    382 OUTPUT_FORMAT("elf64-x86-64", "elf64-x86-64", "elf64-x86-64")
    383 OUTPUT_ARCH(1:x86-64)
    384 ENTRY(phys_startup_64)

Any ideas?  Another toolchain quirk?

Lee


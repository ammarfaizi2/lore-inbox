Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbTJVVd3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 17:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbTJVVd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 17:33:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:16864 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261176AbTJVVdY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 17:33:24 -0400
Date: Wed, 22 Oct 2003 14:31:42 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Wojciech 'Sas' Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test7 broken
Message-Id: <20031022143142.28efb2fe.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.58L.0310171508480.20432@alpha.zarz.agh.edu.pl>
References: <Pine.LNX.4.58L.0310171508480.20432@alpha.zarz.agh.edu.pl>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Oct 2003 15:13:21 +0200 (CEST) "Wojciech 'Sas' Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl> wrote:

| I try to compile linux-2.6.0-test7 from ftp.kernel.org on SMP machine
| and I god something like this:
| 
| [...]
| make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
|   CHK     include/linux/compile.h
|   LD      kernel/built-in.o
|   GEN     .version
|   CHK     include/linux/compile.h
|   UPD     include/linux/compile.h
|   CC      init/version.o
|   LD      init/built-in.o
|   LD      .tmp_vmlinux1
|   KSYM    .tmp_kallsyms1.S
|   AS      .tmp_kallsyms1.o
|   LD      .tmp_vmlinux2
|   KSYM    .tmp_kallsyms2.S
|   AS      .tmp_kallsyms2.o
|   LD      vmlinux
|   AS      arch/i386/boot/setup.o
|   LD      arch/i386/boot/setup
|   OBJCOPY arch/i386/boot/compressed/vmlinux.bin
|   GZIP    arch/i386/boot/compressed/vmlinux.bin.gz
|   LD      arch/i386/boot/compressed/piggy.o
|   LD      arch/i386/boot/compressed/vmlinux
|   OBJCOPY arch/i386/boot/vmlinux.bin
|   BUILD   arch/i386/boot/bzImage
| Root device is (8, 1)
| Boot sector 512 bytes.
| Setup is 4943 bytes.
| System is 1298 kB
| Kernel: arch/i386/boot/bzImage is ready
|   Building modules, stage 2.
|   MODPOST
| [...]
| *** Warning: "set_special_pids" [fs/jffs/jffs.ko] undefined!
| *** Warning: "percpu_counter_mod" [fs/ext3/ext3.ko] undefined!
| *** Warning: "percpu_counter_mod" [fs/ext2/ext2.ko] undefined!
| 
| and ext2 dosn't work.
| Fast workaround is make file kernel/ksyms.c and add to this file two lines
| #include <linux/percpu_counter.h>
| EXPORT_SYMBOL(percpu_counter_mod);
| and fix kernel/Makefile.

We no longer have kernel/ksyms.c.

| Please don't tell me that this is wrong, I try to understand WHY 
| EXPORT_SYMBOL(percpu_counter_mod) from lib/percpu_counter.c didn't work
| but I faild.
| 
| This work for me.

Weird.  and still happens on -test8 when ext{2,3} is built as a module.
(CONFIG_SMP)

nm lists percpu_counter_mod in lib/lib.a but nm does not list that
symbol in .tmp_vmlinux{1,2}.  It's being dropped for some reason...

I can cause a similar problem by trying to call __div64_32() from
ext3/super.c (just as a test).

--
~Randy

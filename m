Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267365AbSKPVYQ>; Sat, 16 Nov 2002 16:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267366AbSKPVYQ>; Sat, 16 Nov 2002 16:24:16 -0500
Received: from suonpaa.iki.fi ([62.236.96.196]:56539 "EHLO
	oberon.erasmus.jurri.net") by vger.kernel.org with ESMTP
	id <S267365AbSKPVYP>; Sat, 16 Nov 2002 16:24:15 -0500
To: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>
Cc: Gregoire Favre <greg@ulima.unil.ch>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.5.47-ac5:undefined reference to `boot_gdt_table'
References: <200211161526.gAGFQbq02692@localhost.localdomain>
From: Samuli Suonpaa <suonpaa@iki.fi>
Date: Sat, 16 Nov 2002 23:30:07 +0200
In-Reply-To: <200211161526.gAGFQbq02692@localhost.localdomain> ("J.E.J.
 Bottomley"'s message of "Sat, 16 Nov 2002 10:26:36 -0500")
Message-ID: <87el9l42zk.fsf@puck.erasmus.jurri.net>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.E.J. Bottomley" <James.Bottomley@steeleye.com> writes:
>>   	ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s arch/i386/kernel/
>> head.o \ arch/i386/kernel/init_task.o  init/built-in.o --start-group
>> usr/built-in.o  \ arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o
>>  \ arch/i386/mach-generic/built-in.o  kernel/built-in.o  mm/built-in.o
>>  fs/built-in.o  \ ipc/built-in.o  security/built-in.o  crypto/
>> built-in.o  drivers/built-in.o  \ sound/built-in.o  arch/i386/pci/
>> built-in.o  net/built-in.o  lib/lib.a  \ arch/i386/lib/lib.a
>> --end-group  -o .tmp_vmlinux1 \ arch/i386/kernel/built-in.o(.data+0x15a
>> 5): In function `gdt_48': : undefined \
>>                 reference to `boot_gdt_table' make: ***
>> [.tmp_vmlinux1] Error 1
> I think this is because -ac5 has X86_TRAMPOLINE dependent on
> X86_LOCAL_APIC.

> If you change
>
> config X86_TRAMPOLINE
> 	bool
> 	depends on SMP || (VOYAGER && SMP) || X86_LOCAL_APIC
>
> to
>
> 	depends on SMP
>
> in arch/i386/Kconfig
>
> does this fix the problem?

Worked here, at least.

Suonp‰‰...

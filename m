Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265022AbSKFNAB>; Wed, 6 Nov 2002 08:00:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265024AbSKFNAB>; Wed, 6 Nov 2002 08:00:01 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:15512 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265022AbSKFM70>; Wed, 6 Nov 2002 07:59:26 -0500
Subject: Re: 2.5.46: DVB don't work...
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Gregoire Favre <greg@ulima.unil.ch>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-dvb@linuxtv.org
In-Reply-To: <20021106112353.GA22269@ulima.unil.ch>
References: <20021105163106.GA5169@ulima.unil.ch> 
	<20021106112353.GA22269@ulima.unil.ch>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Nov 2002 13:28:33 +0000
Message-Id: <1036589313.9781.10.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-06 at 11:23, Gregoire Favre wrote:
> On Tue, Nov 05, 2002 at 05:31:06PM +0100, Gregoire Favre wrote:
> 
> I have tried to compil dvb-ttpci in the kernel:
> 
>   	ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o --start-group  usr/built-in.o  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  arch/i386/mach-generic/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o  net/built-in.o --end-group  -o .tmp_vmlinux1
> drivers/built-in.o(.data+0xf6f4): undefined reference to `local symbols in discarded section .exit.text'
> make: *** [.tmp_vmlinux1] Error 1
> 
> Anyone got a fix?

Missing devexit_p for the pci remove call somewhere. I'll take a look if
I get time, but you are looking for a pci module declaration which has a
remove function that isnt marked __devexit_p() when the function it
calls is


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271847AbRICWWj>; Mon, 3 Sep 2001 18:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271846AbRICWW3>; Mon, 3 Sep 2001 18:22:29 -0400
Received: from hank-fep6-0.inet.fi ([194.251.242.201]:8098 "EHLO
	fep06.tmt.tele.fi") by vger.kernel.org with ESMTP
	id <S271841AbRICWWP>; Mon, 3 Sep 2001 18:22:15 -0400
Message-ID: <3B940291.C752F45B@pp.inet.fi>
Date: Tue, 04 Sep 2001 01:22:09 +0300
From: Jari Ruusu <jari.ruusu@pp.inet.fi>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19aa2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: Announce loop-AES-v1.4d file/swap crypto package
In-Reply-To: <3B93B32A.69D25916@pp.inet.fi> <3B93EE69.5674035F@eyal.emu.id.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eyal Lebedinsky wrote:
> Jari Ruusu wrote:
> > In short: If file and swap crypto is all you need, this package is a hassle
> > free replacement for international crypto patch and HVR's crypto-api.
> 
> 1) It claims to allow you to specify the kernel sources dir, but it then
> runs 'depmod' without a nominated version which is only valid if you
> are building for the running kernel. I now have it doing
>         depmod -ae $(KERNELRELEASE)

I will fix that in next release. However, most systems (if not all) run
depmod from bootup initialization scripts. Depmod from the Makefile is only
needed when you intend to use the driver immediately without rebooting.
 
> 2) 'make' will also install the module. It would be nice to have an
> explicit 'make install' instead.

Getting kernel Makefile to jump back to loop-AES directory for "make
install" is easy for 2.4 kernels, but not so easy for 2.2 and 2.0 kernels.
It makes sense to have identical build instructions for all supported
kernels.
 
> 3) The module is installed as loop.o, same as the standard kernel
> module. I prefer to use different names for added modules.

It is a replacement for kernel's loop.o driver. Actually, it _is_ kernel's
loop.c patched and compiled outside of kernel tree. My patch just fixes
known bugs in stock loop.c and pre-registers AES transfer.
 
> Also, it ends up in
>         /lib/modules/VERSION/block/loop.o
> which is fine for 2.2, but 2.4 uses
>         /lib/modules/VERSION/kernel/drivers/block/loop.o
> so you now have two loop.o - do you know which one will be loaded?

Loop-AES build instructions _require_ you to disable the loop driver in the
kernel. If you have two loop.o drivers, you skipped some build instructions.
Also, it can't be placed in /lib/modules/VERSION/kernel/drivers/block/loop.o
because kernel's "make modules_install" will remove all non-configured
drivers from there. If it was placed there, it would disappear next time you
recompile and reinstall other kernel modules.
 
> I changed it to install as loop-aes.o:
>         cp -p loop.o $(ML)/kernel/drivers/block/loop-aes.o
> and I can now select a module in the modules config.

If the module name is loop.o then kmod will automatically load it to kernel
when needed (assuming that CONFIG_KMOD=y). That way, there is no need to
modprobe or insmod it. Just use it, and it will be there when you need it.
 
Regards,
Jari Ruusu <jari.ruusu@pp.inet.fi>


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263794AbTAVWTZ>; Wed, 22 Jan 2003 17:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263977AbTAVWTZ>; Wed, 22 Jan 2003 17:19:25 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:39175 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id <S263794AbTAVWTY>; Wed, 22 Jan 2003 17:19:24 -0500
Date: Wed, 22 Jan 2003 17:27:26 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
X-X-Sender: root@oddball.prodigy.com
Reply-To: Bill Davidsen <davidsen@tmr.com>
To: Bill Davidsen <davidsen@tmr.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.5] Local printer not supported in 2.5?
In-Reply-To: <Pine.LNX.4.44.0301221630510.1168-100000@oddball.prodigy.com>
Message-ID: <Pine.LNX.4.44.0301221721150.1160-100000@oddball.prodigy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jan 2003, Bill Davidsen wrote:

> I still can't print from any 2.5 kernel. I have the printer driver loaded, 
> using:
>   alias parport_lowlevel parport_pc
> in the /etc/modprobe.conf (generated with 0.9.9pre).
> 
> Modules loaded:
>   Module                  Size  Used by
>   eepro100               20076  - 
>   mii                     4064  - 
>   parport_pc             21992  - 
>   parport                35520  - 
> 
> There are no parport messages in dmesg, but when I did the first build I 
> missed modules_install and it complained that I had the wrong (with 
> preempt) modules. This persist with every kernel tried on this machine, 
> from 2.5.50 forward.

Hum, that's no longer true, it appears the Linux PnP support didn't set up 
the card, because if I tell the BIOS that the OS is *not* PnP aware, I 
then get messages:
  pnp: the driver 'parport_pc' has been registered
  pnp: pnp: match found with the PnP device '00:12' and the driver 'parport_pc'
  parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
  parport0: irq 7 detected
  parport0: cpp_daisy: aa5500ff(00)
  parport0: assign_addrs: aa5500ff(00)
  Module parport cannot be unloaded due to unsafe usage in include/linux/module.h:430
  Module parport_pc cannot be unloaded due to unsafe usage in include/linux/module.h:430
  parport0: Legacy device

Infortunately the lpd still says it can't find the printer, the irq isn't 
in /proc/interrupts, and is the "unloaded" stuff informational or does it 
indicate that the modules are being deactivated?

> Booting with 2.4.18 redhat or 2.4.20 kernel.org both work just fine and 
> can use the printer.
> 
> From config:
>   # Parallel port support
>   CONFIG_PARPORT=m
>   CONFIG_PARPORT_PC=m
>   CONFIG_PARPORT_PC_CML1=m
>   # CONFIG_PARPORT_SERIAL is not set
>   CONFIG_PARPORT_PC_FIFO=y
>   CONFIG_PARPORT_PC_SUPERIO=y
>   # CONFIG_PARPORT_OTHER is not set
>   CONFIG_PARPORT_1284=y
> 
> 
> dmesg reports:
>   pnp: the driver 'parport_pc' has been registered
>   pnp: match found with the PnP device '00:12' and the driver 'parport_pc'

See above, this has been addressed.
> 
> What have I missed?

I miss 2.4.20, is what I miss.


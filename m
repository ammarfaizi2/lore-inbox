Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316851AbSGVMw2>; Mon, 22 Jul 2002 08:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316880AbSGVMw2>; Mon, 22 Jul 2002 08:52:28 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:14866 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316851AbSGVMw0>; Mon, 22 Jul 2002 08:52:26 -0400
Date: Mon, 22 Jul 2002 13:55:32 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Lightweight patch manager <patch@luckynet.dynu.com>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] Get export-objs right
Message-ID: <20020722135532.C2838@flint.arm.linux.org.uk>
References: <Pine.LNX.4.44.0207220642530.30654-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0207220642530.30654-100000@hawkeye.luckynet.adm>; from patch@luckynet.dynu.com on Mon, Jul 22, 2002 at 06:47:04AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2002 at 06:47:04AM -0600, Lightweight patch manager wrote:
> This corrects all export-objs directives in Makefiles that regard .c 
> files.
> 
> diff -Nur linux-2.5.27/arch/arm/kernel/Makefile thunder-2.5/arch/arm/kernel/Makefile
> --- linux-2.5.27/arch/arm/kernel/Makefile	Sat Jul 20 13:12:18 2002
> +++ thunder-2.5/arch/arm/kernel/Makefile	Mon Jul 22 06:19:21 2002
> @@ -17,7 +17,7 @@
>  obj-n		:=
>  obj-		:=
>  
> -export-objs	:= armksyms.o apm.o dma.o ecard.o fiq.o io.o time.o
> +export-objs	:= armksyms.o dma.o ecard.o fiq.o io.o time.o

apm.c waiting to be merged.

>  obj-$(CONFIG_APM)		+= apm.o
>  obj-$(CONFIG_ARCH_ACORN)	+= ecard.o time-acorn.o
> diff -Nur linux-2.5.27/arch/arm/mach-clps711x/Makefile thunder-2.5/arch/arm/mach-clps711x/Makefile
> --- linux-2.5.27/arch/arm/mach-clps711x/Makefile	Sat Jul 20 13:12:26 2002
> +++ thunder-2.5/arch/arm/mach-clps711x/Makefile	Mon Jul 22 06:19:53 2002
> @@ -14,8 +14,6 @@
>  obj-n			:=
>  obj-			:=
>  
> -export-objs		:= leds-p720t.o
> -

This one's fine.

>  obj-$(CONFIG_ARCH_AUTCPU12) += autcpu12.o
>  obj-$(CONFIG_ARCH_CDB89712) += cdb89712.o
>  obj-$(CONFIG_ARCH_CLEP7312) += clep7312.o
> diff -Nur linux-2.5.27/arch/arm/mach-ftvpci/Makefile thunder-2.5/arch/arm/mach-ftvpci/Makefile
> --- linux-2.5.27/arch/arm/mach-ftvpci/Makefile	Sat Jul 20 13:12:23 2002
> +++ thunder-2.5/arch/arm/mach-ftvpci/Makefile	Mon Jul 22 06:20:41 2002
> @@ -14,7 +14,7 @@
>  obj-n			:=
>  obj-			:=
>  
> -export-objs		:= 
> +export-objs		:= leds.o

Fine.

>  obj-$(CONFIG_PCI)	+= pci.o
>  obj-$(CONFIG_LEDS)	+= leds.o
> diff -Nur linux-2.5.27/arch/arm/mach-integrator/Makefile thunder-2.5/arch/arm/mach-integrator/Makefile
> --- linux-2.5.27/arch/arm/mach-integrator/Makefile	Sat Jul 20 13:12:18 2002
> +++ thunder-2.5/arch/arm/mach-integrator/Makefile	Mon Jul 22 06:20:22 2002
> @@ -14,8 +14,6 @@
>  obj-n			:=
>  obj-			:=
>  
> -export-objs		:= leds.o
> -

Fine.

>  obj-$(CONFIG_LEDS)	+= leds.o
>  obj-$(CONFIG_PCI)	+= pci_v3.o pci.o
>  
> diff -Nur linux-2.5.27/arch/arm/mach-pxa/Makefile thunder-2.5/arch/arm/mach-pxa/Makefile
> --- linux-2.5.27/arch/arm/mach-pxa/Makefile	Sat Jul 20 13:11:21 2002
> +++ thunder-2.5/arch/arm/mach-pxa/Makefile	Mon Jul 22 06:21:07 2002
> @@ -12,7 +12,7 @@
>  obj-n :=
>  obj-  :=
>  
> -export-objs := generic.o irq.o dma.o sa1111.o
> +export-objs := generic.o dma.o

sa1111 is waiting to appear from Nico.

>  # Common support (must be linked before board specific support)
>  obj-y += generic.o irq.o dma.o
> diff -Nur linux-2.5.27/arch/arm/mach-sa1100/Makefile thunder-2.5/arch/arm/mach-sa1100/Makefile
> --- linux-2.5.27/arch/arm/mach-sa1100/Makefile	Sat Jul 20 13:12:31 2002
> +++ thunder-2.5/arch/arm/mach-sa1100/Makefile	Mon Jul 22 06:21:37 2002
> @@ -11,8 +11,7 @@
>  obj-  :=
>  led-y := leds.o
>  
> -export-objs :=	dma.o generic.o irq.o pcipool.o sa1111.o sa1111-pcibuf.o \
> -		usb_ctl.o usb_recv.o usb_send.o pm.o
> +export-objs :=	dma.o generic.o pcipool.o sa1111.o sa1111-pcibuf.o pm.o

USB stuff pending GregKH/myself doing some evaluation work.

>  # This needs to be cleaned up.  We probably need to have SA1100
>  # and SA1110 config symbols.

I'm busy with serial stuff at the moment and haven't had time to push any
ARM stuff to Linus since .25; don't expect me to do anything with this
for a while.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


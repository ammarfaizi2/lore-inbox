Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131354AbRAaLkY>; Wed, 31 Jan 2001 06:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131341AbRAaLkO>; Wed, 31 Jan 2001 06:40:14 -0500
Received: from gw.lowendale.com.au ([203.26.242.120]:30842 "EHLO
	marina.lowendale.com.au") by vger.kernel.org with ESMTP
	id <S131339AbRAaLkF>; Wed, 31 Jan 2001 06:40:05 -0500
Date: Wed, 31 Jan 2001 22:54:22 +1100 (EST)
From: Neale Banks <neale@lowendale.com.au>
To: Keith Owens <kaos@ocs.com.au>
cc: Stephen Rothwell <sfr@linuxcare.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18: apm initialised before dmi_scan? 
In-Reply-To: <1211.980858931@ocs3.ocs-net>
Message-ID: <Pine.LNX.4.05.10101312249450.16611-100000@marina.lowendale.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jan 2001, Keith Owens wrote:

> >If this implies that apm is initialised *before* the dmi_scan then there
> >is potentially a problem with buggy BIOSen that oops instead of reporting
> >power status
> 
> This should fix the link order, at the (small) expense of compiling
> dmi_scan for exported symbols, even though it does not really export
> symbols.  Against 2.2.18.
> 
> Index: 18.1/arch/i386/kernel/Makefile
> --- 18.1/arch/i386/kernel/Makefile Thu, 23 Nov 2000 11:48:07 +1100 kaos (linux-2.2/E/b/40_Makefile 1.1.4.4 644)
> +++ 18.2(w)/arch/i386/kernel/Makefile Tue, 30 Jan 2001 23:47:17 +1100 kaos (linux-2.2/E/b/40_Makefile 1.1.4.4 644)
> @@ -15,8 +15,8 @@ all: kernel.o head.o init_task.o
>  O_TARGET := kernel.o
>  O_OBJS   := process.o signal.o entry.o traps.o irq.o vm86.o \
>              ptrace.o ioport.o ldt.o setup.o time.o sys_i386.o \
> -	    bluesmoke.o dmi_scan.o
> -OX_OBJS  := i386_ksyms.o
> +	    bluesmoke.o
> +OX_OBJS  := i386_ksyms.o dmi_scan.o
>  MX_OBJS  :=
>  
>  ifdef CONFIG_PCI

Thanks Keith - works nicely.

If this is a correct and justifiable fix for 2.2 then in 2.4 should
dmi_scan.o be included in export-objs?  Or is there a "better" way of
doing this?

Neale.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

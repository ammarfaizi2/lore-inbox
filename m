Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315760AbSENPNM>; Tue, 14 May 2002 11:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315762AbSENPNL>; Tue, 14 May 2002 11:13:11 -0400
Received: from chaos.analogic.com ([204.178.40.224]:26496 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S315760AbSENPNK>; Tue, 14 May 2002 11:13:10 -0400
Date: Tue, 14 May 2002 11:10:25 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Alvaro de Luna <aluna@datsi.fi.upm.es>
cc: linux-kernel@vger.kernel.org
Subject: Re: DOS functions setvect, getvect
In-Reply-To: <3CE11548.C55BBE7@datsi.fi.upm.es>
Message-ID: <Pine.LNX.3.95.1020514110020.2245A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 May 2002, Alvaro de Luna wrote:

> Hi,
>     I'm trying to transform a DOS driver into a Linux one, but don't
> know
>     what functions use to replace "setvect" and "getvect", does anybody
>     knows?
> 
> Thanks,
>     Alvaro.
> 

You probably want ...

  request_irq(IRQ_NR, isr_procedure, SA_INTERRUPT, 
                         char_ptr_device_name, void_ptr_to_params).
... and ...

  free_irq(IRQ_NR, void_ptr_to_params);

In Linux, the kernel sets up and tears down 'vectors' for you.
You need to get a book on drivers (modules).

In user-mode, there is no such thing as an interrupt vector because
they will all cause a trap to the kernel, the kernel handles them,
usually by killing the process. In one case only, the kernel
allows user mode int 0x80. This is for kernel services. You
can't "get that vector" and "set a new one".


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271971AbRIDN3L>; Tue, 4 Sep 2001 09:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271970AbRIDN3C>; Tue, 4 Sep 2001 09:29:02 -0400
Received: from chaos.analogic.com ([204.178.40.224]:32642 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S271971AbRIDN2r>; Tue, 4 Sep 2001 09:28:47 -0400
Date: Tue, 4 Sep 2001 09:28:52 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Rastislav Stanik <rastos@woctni.sk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Should I use Linux to develop driver for specialized ISA card?
In-Reply-To: <XFMail.010904145710.rastos@woctni.sk>
Message-ID: <Pine.LNX.3.95.1010904091432.19709A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Sep 2001, Rastislav Stanik wrote:

> Hi,
> 
> I'd like to know your opinion on following problem:
> 
> I'm developing specialized plotter.
> The moving parts of the plotter are controlled by ISA card that generates
> (and responds to) interrupts on each movement or printing event.
> The interrupts can be generated quite fast; up to frequency of 4kHz.

Linux drivers have no problem with interrupt-rates up to about 150,000
per second if the CPU is 130 MHz or faster and the ISR is small.

> 
> I need to write a driver for that.
> The 1st prototype is developed in MS-DOS,but I hit problem with memory.
> The driver needs to use (and transfer) quite big chunks of memory.
> 1MB is not enough.
> 

Normally, a Linux driver implements open/close/read/write/poll/ioctl. It
transfers chunks of data so the large memory allocations are in
user-space while the chunks are small buffers in kernel space.


> In NT you don't develop drivers so easily. It is actually a pain.
> Therefore I'm considering Linux. The machine would be probably 
> dedicated and, may be later, embeded in the plotter.
> Problems:
> - It is unlikely that my driver would ever make it to main-stream kernel source.
> - I'm just a C/C++ programmer, I have just rough idea what does it mean to
> 'develop a driver in Linux'. I'm pretty familiar with Linux as sys-admin though.
> 

Linux drivers are quite straight-forward and they can be inserted/removed
from a running kernel (modules). This makes development run very quickly
beause you can make small portions, test them, make more, etc., without
ever having to re-boot. As long as you write code that behaves, i.e., no
buffer overflows, and proper data allocation/deallocation, you will
never have to re-boot.

> All I need is: to have piece of code executed on some interrupt,
> read/write IO ports of the card and be able to transfer big pieces
> of memory to the card.
> 
Trivial.

> What do you think? Is Linux the ideal platform for me?
>

It's ideal. But, you have to start thinking like a Linux/Unix
programmer. For instance, you do not allocate large buffers inside
the kernel, you use poll() or select() to let user-mode code know
that some event (like an interrupt) occurred so you can get/put
data using read() or write(). You use ioctl() to send/receive
control information to your device.
 

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312962AbSFQNJb>; Mon, 17 Jun 2002 09:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313070AbSFQNJa>; Mon, 17 Jun 2002 09:09:30 -0400
Received: from chaos.analogic.com ([204.178.40.224]:9346 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S312962AbSFQNJa>; Mon, 17 Jun 2002 09:09:30 -0400
Date: Mon, 17 Jun 2002 09:11:19 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Emmanuel Michon <emmanuel_michon@realmagic.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: binary compatibity (mixing different gcc versions) in modules
In-Reply-To: <7w3cvmdquu.fsf@avalon.france.sdesigns.com>
Message-ID: <Pine.LNX.3.95.1020617085231.12517B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Jun 2002, Emmanuel Michon wrote:

> Hi,
> 
> looking at nvidia proprietary driver, the makefile warns
> the user against insmod'ing a module compiled with a gcc
> version different from the one that was used to compile
> the kernel.
> 
> This sounds strange to me, since I never encountered this
> problem.
> 
> As a counterpart, what I'm sure of, is that you easily get system
> crashes when insmod'ing a module resulting of the linking together 
> (with ld -r) of object files (.o) that were not produced by the same gcc.
> 
> Can someone give me a clue on what happens?
> 

Nothing happens if you don't use -fcaller-saves or some other such
optimization(s). Even -fomit-frame-pointer is safe across called
functions so there should not be a problem mixing and matching.

Note that your 'C' runtime library was probably not created by your
current C Compiler and your user-mode C programs probably run just
fine.

Very old GNU C compilers followed the "M$" convention of prepending
an underscore on a global variable. Therefore "main:" became "_main:".
With such a compiler output, the linker will have trouble.

If you link together certain objects to make a module, you must
ascertain that the objects were produced using the same kernel
structures (read identical kernel version). As an example, the
main module structure, used by the kernel to find out where your
module's procedures are, is called: "struct file_operations".
The first structure member used to be a pointer to lseek(), now
it's an opaque object of type THIS_MODULE.

Imagine the fun if you made a module with this mixup!

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.


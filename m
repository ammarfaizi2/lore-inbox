Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266962AbTAITHI>; Thu, 9 Jan 2003 14:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266964AbTAITHI>; Thu, 9 Jan 2003 14:07:08 -0500
Received: from chaos.analogic.com ([204.178.40.224]:29824 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S266962AbTAITHG>; Thu, 9 Jan 2003 14:07:06 -0500
Date: Thu, 9 Jan 2003 14:16:53 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Sam Ravnborg <sam@ravnborg.org>
cc: Miles Bader <miles@gnu.org>, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Embed __this_module in module itself.
In-Reply-To: <20030109184935.GA11107@mars.ravnborg.org>
Message-ID: <Pine.LNX.3.95.1030109140617.15280A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jan 2003, Sam Ravnborg wrote:

> On Thu, Jan 09, 2003 at 10:18:53AM +0900, Miles Bader wrote:
> > Sam Ravnborg <sam@ravnborg.org> writes:
> > > Not knowing much about v850, I wonder why you do not need to set the -m
> > > option. Most other architectures do this.
> > 
> > ???
> > 
> > A far as I can see, no architecture does anything different than the
> > default.
> 
> A little grepping gave the following result:
> 
> i386/Makefile:LDFLAGS           := -m elf_i386
> m68k/Makefile:LDFLAGS := -m m68kelf
> mips/Makefile:LDFLAGS           := -G 0
> ppc64/Makefile:LDFLAGS          := -m elf64ppc
> s390/Makefile:LDFLAGS           := -m elf_s390
> s390x/Makefile:LDFLAGS          := -m elf64_s390
> sh/Makefile:LDFLAGS             := -EL
> sh/Makefile:LDFLAGS             := -EB
> sparc/Makefile:LDFLAGS          := -m elf32_sparc
> sparc64/Makefile:LDFLAGS                := -m elf64_sparc
> x86_64/Makefile:LDFLAGS         := -m elf_x86_64
> 
> Little less than half of the architectures defines their own LDFLAGS.
> Most of them set an emulation, most probarly inherited from i386.
> 
> > 
> > [Why on earth would -m be needed, anyway?]
> 
> I do not know, but as can be seen above several architectures use it.
> 
> 
> I have seen your proposed patch for gnu.linkonce.
> I do prefer to have it in arch/v850/Makefile because this is a workaround
> for an architecture specific bug in ld.
> Why not provide your own link script?
> 
> 	Sam

The 'emulation' really defines the linker-script to use. The name
is pretty much a misnomer. Different architectures require different
linking parameters and you can force the linker to provide a `a.out`
(ZMAGIC) output as well as ELF.

Execute  `ld -V` and the linker script will be displayed. If you
do `ld -V -m x` it will show the emulations provided, on ix86
machines, it's i386linux (for a.out) and elf_i386 (for ELF).

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.



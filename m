Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264119AbTLOSdi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 13:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264123AbTLOSdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 13:33:38 -0500
Received: from chaos.analogic.com ([204.178.40.224]:30082 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264119AbTLOSdc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 13:33:32 -0500
Date: Mon, 15 Dec 2003 13:35:40 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Tomas Szepe <szepe@pinerecords.com>
cc: Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
       "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
       Mark Hahn <hahn@physics.mcmaster.ca>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Martin Mares <mj@ucw.cz>
Subject: Re: PCI Express support for 2.4 kernel
In-Reply-To: <20031215181543.GB11260@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.53.0312151328240.14863@chaos>
References: <Pine.LNX.4.44.0312150917170.32061-100000@coffee.psychology.mcmaster.ca>
 <3FDDD8C6.3080804@intel.com> <3FDDDC68.80209@backtobasicsmgmt.com>
 <3FDDE39E.1050300@intel.com> <Pine.LNX.4.53.0312151150090.10342@chaos>
 <20031215170843.GA10857@louise.pinerecords.com> <Pine.LNX.4.53.0312151258550.14778@chaos>
 <20031215181543.GB11260@louise.pinerecords.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Dec 2003, Tomas Szepe wrote:

> On Dec-15 2003, Mon, 13:03 -0500
> Richard B. Johnson <root@chaos.analogic.com> wrote:
>
> > Therefore you make data exist in the .data segment by initializing
> > it. If GCC decides to put this initialized data in the .bss segment,
> > then it is broken. FYI, it doesn't.
>
> Richard, stop denying reality, go check out what gcc 3.3.2 does.
>
> --
> Tomas Szepe <szepe@pinerecords.com>
>

Well, it seems I am NOT denying reality. Others have just
parroted the contents of an ELF __Header__. I will show you the
actual allocation data.

Script started on Mon Dec 15 13:25:21 2003

quark:/home/johnson[1] cat xxx.c

int foo;   // Not initialized
int bar=0; // Initialized

quark:/home/johnson[2] gcc --version
gcc (GCC) 3.2 20020903 (Red Hat Linux 8.0 3.2-7)
Copyright (C) 2002 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

quark:/home/johnson[3] gcc -c -o xxx.o xxx.c
quark:/home/johnson[4] objdump --disassemble-all xxx.o

xxx.o:     file format elf32-i386

Disassembly of section .text:
Disassembly of section .data:

00000000 <bar>:
   0:	00 00                	add    %al,(%eax)
	...
quark:/home/johnson[5] exit

Script done on Mon Dec 15 13:26:17 2003


This clearly shows that "bar" is the only variable in that object
file. The variable, foo, is written in the header (not shown)
so that the loader knows its size and its relocation symbol.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.



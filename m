Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264259AbTLOSqa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 13:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264261AbTLOSqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 13:46:30 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:38056 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S264259AbTLOSqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 13:46:25 -0500
Date: Mon, 15 Dec 2003 19:45:39 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
       "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
       Mark Hahn <hahn@physics.mcmaster.ca>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Martin Mares <mj@ucw.cz>
Subject: Re: PCI Express support for 2.4 kernel
Message-ID: <20031215184539.GA11858@louise.pinerecords.com>
References: <Pine.LNX.4.44.0312150917170.32061-100000@coffee.psychology.mcmaster.ca> <3FDDD8C6.3080804@intel.com> <3FDDDC68.80209@backtobasicsmgmt.com> <3FDDE39E.1050300@intel.com> <Pine.LNX.4.53.0312151150090.10342@chaos> <20031215170843.GA10857@louise.pinerecords.com> <Pine.LNX.4.53.0312151258550.14778@chaos> <20031215181543.GB11260@louise.pinerecords.com> <Pine.LNX.4.53.0312151328240.14863@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0312151328240.14863@chaos>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec-15 2003, Mon, 13:35 -0500
Richard B. Johnson <root@chaos.analogic.com> wrote:

_Please_ pay more attention to what I've had to write.

> > Richard, stop denying reality, go check out what gcc 3.3.2 does.

                                                         ^^^^^

> Well, it seems I am NOT denying reality. Others have just
> parroted the contents of an ELF __Header__. I will show you the
> actual allocation data.
> 
> quark:/home/johnson[1] cat xxx.c
> 
> int foo;   // Not initialized
> int bar=0; // Initialized
>
> quark:/home/johnson[2] gcc --version
> gcc (GCC) 3.2 20020903 (Red Hat Linux 8.0 3.2-7)

            ^^^

> Disassembly of section .text:
> Disassembly of section .data:
> 
> 00000000 <bar>:
>    0:	00 00                	add    %al,(%eax)
> 	...
> 
> This clearly shows that "bar" is the only variable in that object
> file. The variable, foo, is written in the header (not shown)
> so that the loader knows its size and its relocation symbol.

$ # (gcc version is 3.3.2)
$ cat x.c
int foo;
int bar = 0;
$ gcc -c -o x.o x.c
$ objdump --disassemble-all x.o

x.o:     file format elf32-i386

Disassembly of section .bss:

00000000 <bar>:
   0:   00 00                   add    %al,(%eax)
        ...

...

-- 
Tomas Szepe <szepe@pinerecords.com>

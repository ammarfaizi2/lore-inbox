Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314748AbSECQsu>; Fri, 3 May 2002 12:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314751AbSECQst>; Fri, 3 May 2002 12:48:49 -0400
Received: from chaos.analogic.com ([204.178.40.224]:18560 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S314748AbSECQss>; Fri, 3 May 2002 12:48:48 -0400
Date: Fri, 3 May 2002 12:46:12 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Leandro Tavares Carneiro <leandro@ep.petrobras.com.br>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: High Memory Address Space
In-Reply-To: <1020437001.2951.45.camel@linux60>
Message-ID: <Pine.LNX.3.95.1020503123034.1208A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 May 2002, Leandro Tavares Carneiro wrote:

> 
> How is the maximum memory address space, per process or for all process,
> using High Memory Suport to 64Gb? Is possible to alocate more than 3GB
> for one process? Is much diference between kernel 2.4.x and 2.5.x in the
> high memory support?
> 
> Thanks in advance for any help.

Unix/Linux on 32-bit machines use 32-bit address space. All addresses
are virtual so some of the pages can come from anywhere, including
so-called "high memory". The memory managment makes these pages
appear contiguous to each task (and to the kernel itself). One of
the Unix characteristics is that the kernel address space is
shared with each of the process address space. This means that the
actual process address-space does not start at 0 and extend to
0xffffffff. Instead it starts at an address that leaves room for
the kernel. This split can, in principle, be changed. However
it will result in only a few more megabytes of user address space
and might interfere with the memory mapping of runtime libraries
which, last time I checked, presume certain starting addresses:

Script started on Fri May  3 12:39:03 2002
# cat >xxx.c
main() { return 0; }

# gcc -c -o xxx.o xxx.c
# ld -o xxx xxx.o
ld: warning: cannot find entry symbol _start; defaulting to 08048074
# exit
exit
Script done on Fri May  3 12:39:45 2002

You can see that the assumed starting address is 08048074.

So, basically, if you need more address space, you need a 64-bit
machine. Practically, if what you are doing won't fit in the
address space provided, you should re-think how you are doing
it. Usually this involves using the file-system. That's one of
the things it's really good at.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.


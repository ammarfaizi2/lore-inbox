Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315906AbSEGRHk>; Tue, 7 May 2002 13:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315907AbSEGRHj>; Tue, 7 May 2002 13:07:39 -0400
Received: from chaos.analogic.com ([204.178.40.224]:52864 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S315906AbSEGRHi>; Tue, 7 May 2002 13:07:38 -0400
Date: Tue, 7 May 2002 13:10:01 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Padraig Brady <padraig@antefacto.com>
cc: Anton Altaparmakov <aia21@cantab.net>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
In-Reply-To: <3CD800FE.4050004@antefacto.com>
Message-ID: <Pine.LNX.3.95.1020507125431.7587A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 May 2002, Padraig Brady wrote:

> Linus Torvalds wrote:
> >  [ First off: any IDE-only thing that doesn't work for SCSI or other disks
> >    doesn't solve a generic problem, so the complaint that some generic
> >    tools might use it is totally invalid. ]
> > 
> > On Tue, 7 May 2002, Anton Altaparmakov wrote:
> > 
> >>Linux's power is exactly that it can be used on anything from a wristwatch
> >>to a huge server and that it is flexible about everything. You are breaking
> >>this flexibility for no apparent reason. (I don't accept "I can't cope with
> >>this so I remove it." as a reason, sorry).
> > 
> > 
> > Run the 57 patch, and complain if something doesn't work.
> > 
> > Linux's power is that we FIX stuff. That we make it the best system
> > possible, and that we don't just whine and argue about things.
> > 
> > 
> >>As the new IDE maintainer so far we have only seen you removing one
> >>feature after the other in the name of cleanup, without adequate or even
> >>any at all(!) replacements,
> > 
> > 
> > Who cares? Have you found _anything_ that Martin removed that was at all
> > worthwhile? I sure haven't.
> > 
> > Guys, you have to realize that the IDE layer has eight YEARS of absolute
> > crap in it. Seriously. It's _never_ been cleaned up before. It has stuff
> > so distasteful that t's scary.
> > 
> > Take it from me: it's a _lot_ easier to add cruft and crap on top of clean
> > code. You can do it yourself if you want to. You don't need a maintainer
> > to add barnacles.
> > 
> > All the information that /proc/ide gave you is basically available in
> > hdparm, and for your dear embedded system it apparently takes up less
> > space by being in user space. So what is the problem?
> 
> Well my "dear" embedded system doesn't have libc :-(
> So 35664 saved in kernel (less on disk), requires 25212
> extra for hdparm + more for static linked uclibc (hope
> it works ;-)). As a side note if this happens hdparm would
> be a requirement for busybox IMHO, anyway getting back on topic...

Link your embeded stuff against a stripped-down shared libc...

-rwxr-xr-x   1 root     root          876 Apr 26 13:08 crt1.o
-rwxr-xr-x   1 root     root       160824 Feb 25 13:30 ld-linux.so.2
-rwxr-xr-x   1 root     root       160824 Apr 30 11:31 ld.so
-rwxr-xr-x   1 root     root      2376745 Feb 25 13:29 libc.so.6
-rwxr-xr-x   1 root     root       368551 Feb 25 13:29 libm.so.6

This does most everything an embedded system needs. You can extract
the objects from a shared object file (copy), remove the ones you
obviously don't need, make a new shared object file and link. Keep
adding objects until you don't have a any more unresolved symbols.

`ld` allows you to link to whatever you need. I put my special
'libc' plus another private shared library in /opt/lib. On the
target machine, /opt/lib is a sym-link to /lib.

LPATH=/opt/lib
ELINK=-rpath-link $(LPATH) \
 -rpath $(LPATH) \
 -L $(LPATH) -m elf_i386 \
 -dynamic-linker \
 $(LPATH)/ld-linux.so.2 \
 $(LPATH)/crt1.o \
 $(LPATH)/crtendS.o \
 $(LPATH)/libc.so.6 \
 $(LPATH)/libm.so.6


program:	program.o
		ld -o program program.o $(ELINK)


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.


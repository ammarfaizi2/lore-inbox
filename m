Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277246AbRJIOTQ>; Tue, 9 Oct 2001 10:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277241AbRJIOTH>; Tue, 9 Oct 2001 10:19:07 -0400
Received: from chaos.analogic.com ([204.178.40.224]:55168 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S277246AbRJIOSs>; Tue, 9 Oct 2001 10:18:48 -0400
Date: Tue, 9 Oct 2001 10:16:48 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel size
In-Reply-To: <163112682879.20011009161634@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.3.95.1011009100315.5093A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2001, VDA wrote:

> Hi folks
> 
> I recompiled my kernel with GCC 3.0.1 (was 2.95.x)
> and guess what - it got bigger...
> Somehow, I hoped in linux world software gets better
> with time, not worse...
> 
> Maybe that's my fault (misconfigured GCC etc) ?
> What do you see?
> 
> Being curious, I looked into vmlinux (uncompressed kernel).

It's much worse than you can imagine!

`strings /proc/kcore | grep GNU' >qqq.qqq`

Causes a file this big to be generated:
-rw-r--r--   1 root     root      1069748 Oct  9 10:01 qqq.qqq

That's how much space is being wasted by GNU advertising.

A single program:

int foo;


Compiled, produces this:

	.file	"xxx.c"
	.version	"01.01"
gcc2_compiled.:
	.comm	foo,4,4
	.ident	"GCC: (GNU) egcs-2.91.66 19990314 (egcs-1.1.2 release)"

It __might__ be possible to link, without linking in ".ident", which
currently shares space with .rodata. My gcc man pages are not any
better than the usual Red Hat so I can't find out if there is any way
to turn OFF these spurious strings.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.



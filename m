Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbTISNFR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 09:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbTISNFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 09:05:16 -0400
Received: from chaos.analogic.com ([204.178.40.224]:55937 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261556AbTISNFJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 09:05:09 -0400
Date: Fri, 19 Sep 2003 09:06:46 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Hugang <hugang@soulinfo.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: use O_DIRECT open file, when read will hang.
In-Reply-To: <20030919124631.3b4e6301.hugang@soulinfo.com>
Message-ID: <Pine.LNX.4.53.0309190903490.14246@chaos>
References: <20030919124631.3b4e6301.hugang@soulinfo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Sep 2003, Hugang wrote:

Your script cannot work.
Also, nothing hangs.

> Hello all:
>
> Steps to reproduce:
>
> rm -f /tmp/1.log
> touch /tmp/1.log
> echo << EOF > /tmp/hang.c
  ^^^^______ cat, not echo

> #include <sys/types.h>
> #include <asm/fcntl.h>
>
> main()
> {
>         int i;
>         char buf[1025];
>
>         i = open("/tmp/1.log", O_RDONLY | 040000, 0);
>         if ( i != -1) {
>                 read(i, buf, 1);
>         }
>         printf("'%s'", buf);
> }
> EOF
> gcc -o /tmp/hang /tmp/hang.c
> /tmp/hang
>
>

This is a `strace` of it working:

getpid()                                = 14243
open("/tmp/1.log", O_RDONLY|0x4000)     = 3
read(3, "", 1)                          = 0
fstat(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(4, 1), ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x400aa000
ioctl(1, TCGETS, {B38400 opost isig icanon echo ...}) = 0
write(1, "\'\'", 2)                     = 2
munmap(0x400aa000, 4096)                = 0
_exit(2)                                = ?

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
            Note 96.31% of all statistics are fiction.



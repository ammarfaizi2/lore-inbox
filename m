Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262457AbSLBNEm>; Mon, 2 Dec 2002 08:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262901AbSLBNEm>; Mon, 2 Dec 2002 08:04:42 -0500
Received: from chaos.analogic.com ([204.178.40.224]:2180 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S262457AbSLBNEl>; Mon, 2 Dec 2002 08:04:41 -0500
Date: Mon, 2 Dec 2002 08:13:47 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Super user <lnxuser2002@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Size limitation for the module
In-Reply-To: <20021129123052.61297.qmail@web14609.mail.yahoo.com>
Message-ID: <Pine.LNX.3.95.1021202080121.20938A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Nov 2002, Super user wrote:

> Hi All,
> 
> I have a kernel module which is a huge one. Around 1.5
> MB. Is there any known problems in having a such a big
> module.
> 
> The problem is after inserting the module, the box
> freezes after some time.

[SNIPPED...]

There might not be 1.5 MB available from kmalloc() and there
may be a bug in kmalloc() when it gets to allocating more
memory than it has (these boundary conditions may not have been
tested very well, or your module isn't checking returned results).

Normally, if you need lots of memory for a module, you tell
the kernel upon boot that there is less memory than there is.
IOW, you reserve it. Then, in your module you use ioremap() to
allocate it exclusively for your module.

This method has many advantages as well. FYI, the memory is
never paged, it's always immediately available for your module.

In principle, you are supposed to use copy/from/to/io and
read/b/w/l/write/b/w/l to access it, but on ix86 (only), you
can initialize a pointer with the value returned from ioremap().

This, of course is not portable, but a module allocation of 1.5 MB
is not portable anyway, so doit2it.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
   Bush : The Fourth Reich of America



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132800AbRDDMTd>; Wed, 4 Apr 2001 08:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132801AbRDDMTX>; Wed, 4 Apr 2001 08:19:23 -0400
Received: from cr502987-a.rchrd1.on.wave.home.com ([24.42.47.5]:29703 "EHLO
	the.jukie.net") by vger.kernel.org with ESMTP id <S132800AbRDDMTN>;
	Wed, 4 Apr 2001 08:19:13 -0400
Date: Wed, 4 Apr 2001 08:18:22 -0400 (EDT)
From: Bart Trojanowski <bart@jukie.net>
To: Remko van der Vossen <remko.van.der.vossen@cmg.nl>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: PThreads in kernel module & network interface
In-Reply-To: <B569A4D2254ED2119FE500104BC1D5CD01294138@NL-EIN-MAIL01>
Message-ID: <Pine.LNX.4.30.0104040812010.10013-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 4 Apr 2001, Remko van der Vossen wrote:
> second problem is that when I use the PThread functions from this module I
> need the pthread library. As you probably know gcc doesn't link the pthread
> library into the module, so I tried to do that with ld, that in itself
> worked, I successfully linked the pthread library into the module I made,

The first problem you are running into is mixing user space with kernel
code.  You cannot use pthreads in the kernel... not directly anyways.  You
could use kernel_thread() instead.

If your future stack will have a BSD socket interface you could prototype
your server in user space - and use pthreads.  If you don't want the
interface then you can hook into the stack directly by using the sock_*
functions (see include/linux/net.h).  You will probably get everything you
need to start you off from an article by Alessandro Rubini at the Linux
Magazine:	http://www.linux-mag.com/2000-12/gear_01.html

> Thank you in advance,

Cheers,
Bart.

-- 
	WebSig: http://www.jukie.net/~bart/sig/



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135328AbRDWRVp>; Mon, 23 Apr 2001 13:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135293AbRDWRVf>; Mon, 23 Apr 2001 13:21:35 -0400
Received: from chaos.analogic.com ([204.178.40.224]:4739 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S135328AbRDWRVW>; Mon, 23 Apr 2001 13:21:22 -0400
Date: Mon, 23 Apr 2001 13:20:48 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: John Weber <weber@nyc.rr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Disappearing RAM
In-Reply-To: <3AE4512D.9030602@nyc.rr.com>
Message-ID: <Pine.LNX.3.95.1010423125835.26466A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Apr 2001, John Weber wrote:

> 
> There appears to be quite a difference between the memory usage reported
> by top
> (immediately after boot and minus all user processes) and that reported
> by the kernel
> during boot.  Can anyone give me any hints as to why this might happen?
> 
> I am assuming that if I subtract all the memory in use by processes
> listed by top from all
> the memory in use that this equals the amount of memory used by the
> kernel.
> These numbers do not add up.
> 
> A related question:  In the 2.2 kernels, does the kernel pre-allocate
> any amount of memory
> for modules?
> 
> Or is everything I'm seeing related to VM bugs in 2.2.<19 ?

Not VM bugs. There may be a bug (or two), but this is not it. Linux
tries to use ALL the memory that it finds. This is to speed I/O
and other operations. If you do `ls -R /`, you will see that a
lot of memory is now allocated to the directory cache. Basically,
any time you perform some I/O Linux tries to keep the result of
the last I/O operation in memory just in case you need that
data again.

In fact, when disk data are modified, the only time it's guaranteed
to have been all written to the disk is when the disk is `umounted`
during shutdown, unless the disk is mounted in a special way.

When processes need RAM, these caches are reused on, the last
time I checked, a least-used basis. So, if a process needs
memory, some pages from the cache that have not been used for awhile
are torn down (possibly written, if modified) and its RAM is used for
process RAM.

When modules are installed, the kernel dynamically allocates the
RAM for the module. There are three main types of memory that the
kernel can allocate; (1) normal virtual RAM; (2) non-paged
virtual RAM (for stuff that must be present during an interrupt),
and; (3) physical RAM (for DMA buffers). All such RAM is accessed
by its virtual address in the kernel so, once allocated, there are
no special coding provisions required. See /usr/include/linux/mm.h
for details.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129304AbRBSP7c>; Mon, 19 Feb 2001 10:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129742AbRBSP7X>; Mon, 19 Feb 2001 10:59:23 -0500
Received: from chaos.analogic.com ([204.178.40.224]:64385 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129304AbRBSP7H>; Mon, 19 Feb 2001 10:59:07 -0500
Date: Mon, 19 Feb 2001 10:58:36 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: David Howells <dhowells@cambridge.redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [LONG RANT] Re: Linux stifles innovation... 
In-Reply-To: <Pine.LNX.3.96.1010219085405.17842F-100000@mandrakesoft.mandrakesoft.com>
Message-ID: <Pine.LNX.3.95.1010219101720.30581A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Feb 2001, Jeff Garzik wrote:

> On Mon, 19 Feb 2001, David Howells wrote:
> > I suspect part of the problem with commercial driver support on Linux is that
> > the Linux driver API (such as it is) is relatively poorly documented
> 
> In-kernel documentation, agreed.
> 
> _Linux Device Drivers_ is a good reference for 2.2 and below.
> 
> > and seems
> > to change almost on a week-by-week basis anyway. I've done my share of chasing
> > the current kernel revision with drivers that aren't part of the kernel tree:
> > by the time you update the driver to work with the current kernel revision,
> > there's a new one out, and the driver doesn't compile with it.
> 
> This is entirely in your imagination.  Driver APIs are stable across the
> stable series of kernels: 2.0.0 through 2.0.38, 2.2.0 through 2.2.18,
> 2.4.0 through whatever.
> 
> 	Jeff
> 

One of the latest module killers was the opaque type, "THIS_MODULE",
put at the beginning of struct file_operations. This happened between
2.4.0 and 2.4.x.  So it's not "imagination".

It is well understood that there will be changes to the driver APIs, but
some could be better thought out to accomplish what must be accomplished,
but at the same time, minimize the code changes to existing drivers.

While on the subject of compatibility, I just put 1 gb of memory in
one of my machines at home this weekend, with 256 mb sticks now costing
under $US 80, I figured it was about time. The machine would not boot
with Linux 2.4.1 just Uncompressing .... then nothing. I had to remove one
memory stick. I recompiled with "high memory" enabled, CONFIG_HIGHMEM4G.

I was unable to use the new kernel because the drivers I need for
`initrd` all had undefined symbols relating to some high memory stuff.
This, in spite of the fact that I did:

cp .config ..
make clean
make distclean
cp ../.config
make oldconfig
make dep
make bzImage
make modules
make modules_install

I can't understand how changes in memory management could possibly
affect drivers! They should not care where memory comes from! If
a driver, calling kmalloc() or whatever, needs to know anything
about where the pages made available were stashed, then something's
broken, plain and simple.

Also, with 4 gb of address space in ix86 machines, we should not
have any problems accessing memory until the sum of all the
RAM, plus the sum of all the address-space needed for PCI resources,
plus anything below 1 megabyte, plus the physical memory required
for PTEs and kernel resources, starts to get near 4 gb. Presently,
the address limit without "highmem hacks" is less than 1 gb. This
needs some work.  It looks as though somebody guessed that 'PAGE_OFFSET'
imposed some kind of limit. It doesn't as long as it's summed, not ORed
(some early code I looked at ORed in PAGE_OFFSET in several places,
destroying the linearity of address arithmetic).

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.



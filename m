Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261349AbSKBUBO>; Sat, 2 Nov 2002 15:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261356AbSKBUBN>; Sat, 2 Nov 2002 15:01:13 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:37383 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261349AbSKBUBK>; Sat, 2 Nov 2002 15:01:10 -0500
Message-ID: <3DC3BFE4.8080904@zytor.com>
Date: Sat, 02 Nov 2002 04:07:00 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Aaron Lehmann <aaronl@vitelus.com>, Jeff Garzik <jgarzik@pobox.com>,
       LKML <linux-kernel@vger.kernel.org>, viro@math.psu.edu
Subject: Re: [BK PATCHES] initramfs merge, part 1 of N
References: <Pine.LNX.4.44.0211021049480.2413-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> The real advantage to me is two-fold:
> 
>  - make it easier for people to customize their initial system without 
>    having to muck with kernel code or even use a different boot sequence.  
>    One example of this is the difference between vendor install kernels 
>    (using initrd) and a normal install kernel (which doesn't).
> 
>    So I'd much rather see us _always_ using initrd, and the difference 
>    between an install kernel and a regular kernel is really just the size 
>    of the initrd thing.
> 
>  - Many things are much more easily done in user space, because user space 
>    has protections, "infinite stack", and in general a lot better 
>    infrastructure (ie easier to debug etc). At the same time, many things 
>    need to be done _before_ the kernel is fully ready to hand over control 
>    to a normal user space: do ACPI parsing so that we can initialize the
>    devices so that we can use the "real" user space that is installed on
>    disk etc.
> 
>    Sometimes there is overlap between these two things (ie the "easier to 
>    do in user space" and "needs to be done before normal user space can be
>    loaded"). ACPI is one potential example. Mounting the root filesystem 
>    over NFS after having done DHCP or other auto-discovery is another.  
> 

I agree 100% with this.  I don't think <kernel>+<early userspace> will 
ever be smaller than the current kernel, but I have invested quite a bit 
of effort into it for exactly the reasons done above.

klibc binaries might not be what one usually tends to run, but during 
klibc development I could still use standard gdb, strace, and just plain 
"run it off the command line" debugging techniques from a full-blown 
environment.  When that doesn't work (like testing dynamic klibc), 
chroot will usually do the trick.  The compile-test-debug cycle is so 
much faster than for a kernel boot that it's just plain amazing.

	-hpa



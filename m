Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269407AbRHQOqe>; Fri, 17 Aug 2001 10:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269350AbRHQOqP>; Fri, 17 Aug 2001 10:46:15 -0400
Received: from irmgard.exp-math.uni-essen.de ([132.252.150.18]:42244 "EHLO
	irmgard.exp-math.uni-essen.de") by vger.kernel.org with ESMTP
	id <S269407AbRHQOqK>; Fri, 17 Aug 2001 10:46:10 -0400
Date: Fri, 17 Aug 2001 16:46:22 +0200 (MESZ)
From: "Dr. Michael Weller" <eowmob@exp-math.uni-essen.de>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: David Madore <david.madore@ens.fr>, linux-kernel@vger.kernel.org
Subject: Re: broken memory chip -> software fix?
In-Reply-To: <Pine.LNX.3.95.1010817101952.256A-100000@chaos.analogic.com>
Message-Id: <Pine.A32.3.95.1010817163950.21198A-100000@werner.exp-math.uni-essen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Aug 2001, Richard B. Johnson wrote:

> mmap(0x04d5a000, PAGE_SIZE, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_FIXED, fd,
>            ^^^^ page boundary
> 0);
> 
> 'MAP_FIXED' is your friend. This will take the offending page size 
> (0x1000) on x86, out of use and give it to you. 'fd' is initialized
> by opening /dev/mem.

Sorry, you are completely confusing things. MAP_FIXED in conjunction
with 0x04d5a000 will (attempt to) map to address 0x04d5a000 in the virtual
address space of the calling process. This has no relation what so ever to
the physical memory addressed. Rather than that, use the 0x04d5a000 as the
last argument to mmap (where we have the 0 above), the so called offset
in the file (/dev/mem). You don't need to fiddle with MAP_FIXED or the
first argument. It shouldn't matter to your program where the bad bit
shows up in it's address space (as long as it knows the actual address
chosen, cf. return value of mmap).

While this gives your program access to the physical memory, it doesn't
keep the kernel from using it as well. Use /dev/mem to access physical
memory, not to reserve it. For that use the other hints given on the list
aka mem= boot arg or kernel patch.

Michael.

--

Michael Weller: eowmob@exp-math.uni-essen.de, eowmob@ms.exp-math.uni-essen.de,
or even mat42b@spi.power.uni-essen.de. If you encounter an eowmob account on
any machine in the net, it's very likely it's me.


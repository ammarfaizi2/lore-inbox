Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277228AbRKABKE>; Wed, 31 Oct 2001 20:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277229AbRKABJp>; Wed, 31 Oct 2001 20:09:45 -0500
Received: from a1as05-p109.stg.tli.de ([195.252.187.109]:27273 "EHLO
	dea.linux-mips.net") by vger.kernel.org with ESMTP
	id <S277228AbRKABJn>; Wed, 31 Oct 2001 20:09:43 -0500
Date: Thu, 1 Nov 2001 02:06:32 +0100
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Green <greeen@iii.org.tw>
Cc: LinuxEmbeddedMailList <linux-embedded@waste.org>,
        LinuxKernelMailList <linux-kernel@vger.kernel.org>,
        MipsMailList <linux-mips@fnet.fr>, linux-mips@oss.sgi.com
Subject: Re: Discontinuous memory!!
Message-ID: <20011101020632.A5076@dea.linux-mips.net>
In-Reply-To: <00c701c1612b$4c133620$4c0c5c8c@trd.iii.org.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <00c701c1612b$4c133620$4c0c5c8c@trd.iii.org.tw>; from greeen@iii.org.tw on Tue, Oct 30, 2001 at 06:11:43PM +0800
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2001 at 06:11:43PM +0800, Green wrote:

> I am porting Linux to R3912. 
> 
> There are two memory block on my target board. 
> 
> One is 16MB                  from 0x8000 0000 to 0x8100 0000.
> 
> The other one is 16MB   from 0x8200 0000 to 0x8300 0000.
> 
> But I found kernel just managed the first memory block.
> 
> How could I modify the kernel to support 32MB discontinuous memory?
> 
> Now I am trying to add entries to page table.
> It will halt at decompressing ramdisk.
> 
> Has anyone resolve this kind of problem before?

The kernel support this type of memory architecture if you enable
CONFIG_DISCONTIGMEM.  One machine which uses this feature is the Origin,
grep in arch/mips64 for CONFIG_DISCONTIGMEM.  There are also several
ARM system using it.

As support for CONFIG_DISCONTIGMEM is less than perfect you should check
if your system allows for reconfiguration of memory as a single physically
contiguous chunk.

Don't use add_memory_region() in this case; that code only works well
for small holes in memory address space.  Your holes are fairly large
so memory management would waste about 2mb if you would not use
CONFIG_DISCONTIGMEM.

  Ralf

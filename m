Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289219AbSAVKER>; Tue, 22 Jan 2002 05:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289220AbSAVKEI>; Tue, 22 Jan 2002 05:04:08 -0500
Received: from mail2.infineon.com ([192.35.17.230]:63653 "EHLO
	mail2.infineon.com") by vger.kernel.org with ESMTP
	id <S289219AbSAVKDy> convert rfc822-to-8bit; Tue, 22 Jan 2002 05:03:54 -0500
X-Envelope-Sender-Is: Erez.Doron@savan.com (at relayer mail2.infineon.com)
Subject: Re: non volatile ram disk
From: Erez Doron <erez@savan.com>
To: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Cc: linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3C4C3201.8956660F@loewe-komp.de>
In-Reply-To: <1011618928.2825.5.camel@hal.savan.com> 
	<3C4C1A96.3504174D@loewe-komp.de>  <1011620576.2978.0.camel@hal.savan.com>
	<1011622206.2978.3.camel@hal.savan.com>  <3C4C3201.8956660F@loewe-komp.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/1.0 (Preview Release)
Date: 22 Jan 2002 11:39:50 +0200
Message-Id: <1011692390.5447.2.camel@hal.savan.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-01-21 at 17:21, Peter Wächtler wrote:
> Erez Doron schrieb:
> > 
> > the exact log i get:
> > 
> > Creating 3 MTD partitions on "SA1100 flash":
> > 0x00000000-0x00040000 : "bootldr"
> > mtd: Giving out device 0 to bootldr
> > 0x00040000-0x02000000 : "root"
> > mtd: Giving out device 1 to root
> > 0xc2000000-0xc4000000 : "rd"
> > mtd: partition "rd" is out of reach -- disabled
> > 
> > notes:
> > 1. the flash is at physical adress 0-0x1ffffff (32mb)
> > 2. the ram is at physical adress 0xc0000000-0xc3ffffff
> > i tried to map an mtd device to the second part of the ram, but got
> > "partition is out of reach"
> > 
> > any idea ?
> 
> you are confusing the address space of the kernel (starting with 3GB [0xc0000000])
> with the addresses of the RAM (the upper 32MB starts at 0x2000000)
> 
no, i do not ( compaq document says the ram starts at 0xc0000000, i also
verified it by doing peek and poke via the bootloader)

> Then there will be some CS (chip selects) to distinguish what "bus address space"
> to use. Like CS1 for Flash and CS0 for RAM (don't know details of SA1100/iPAQ)
> 
> You have to use the special MTD device that talks to system RAM.
> Again, I don't know the details, but menuconfig gives you:
> 
> RAM/ROM/Flash chip drivers
> 	Support for RAM chips in bus mapping
> 
> Self-contained MTD device drivers
>  	Uncached system RAM (NEW)
> 
> The former sounds like RAM on expansion bus, the latter seems to be
> what you are looking for.
> 
> Now: is the RAM battery backed, or not? If not, you want to use
> the flash as nonvolatile disk - otherwise there would be no need 
> to restart the system and hence a normal RAM disk would be nonvolatile.
> 
yes it is

thanks anyway
erez.
> 
> > 
> > On Mon, 2002-01-21 at 15:42, Erez Doron wrote:
> > > hi
> > >
> > > thanks for replying,
> > >
> > > I already tried to map an MTD to physical memory, but got an error and
> > > an mtd with size 0
> > >
> > > dou you know why ?
> > >
> > > regards
> > > erez
> > >
> > > On Mon, 2002-01-21 at 15:41, Peter Wächtler wrote:
> > > > Erez Doron schrieb:
> > > > >
> > > > > hi
> > > > >
> > > > > I'm looking for a way to make a ramdisk which is not erased on reboot
> > > > > this is for use with ipaq/linux.
> > > > >
> > > > > i tought of booting with mem=32m and map a block device to the rest of
> > > > > the 32M ram i have.
> > > > >
> > > > > the probelm is that giving mem=32m to the kernel will cause the kernel
> > > > > to map only the first 32m of physical memory to virtual one, so using
> > > > > __pa(ptr) on the top 32m causes a kernel oops.
> > > > >
> > > > > any idea ?
> > > > >
> > > >
> > > > a MTD is the way to go, which uses the "reserved" mem area.
> > > > I assume that the RAM is battery backed
> > > > -


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261921AbSIYGUI>; Wed, 25 Sep 2002 02:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261922AbSIYGUI>; Wed, 25 Sep 2002 02:20:08 -0400
Received: from pacific.moreton.com.au ([203.143.238.4]:5105 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S261921AbSIYGUH>; Wed, 25 Sep 2002 02:20:07 -0400
Message-ID: <3D9156E6.1030703@snapgear.com>
Date: Wed, 25 Sep 2002 16:25:42 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Conserving memory for an embedded application
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Wed, 25 Sep 2002 14:53, Michael D. Crawford wrote:
>> One question I have is whether it is possible to burn an uncompressed image
>> of the kernel into flash, and then boot the kernel in-place, so that it is
>> not copied to RAM when it runs.  Of course the kernel would need RAM for
>> its data structures and user programs, but it would seem to me I should be
>> able to run the kernel without making a RAM copy.
> The uclinux guys have eXecute In Place  - google search for uclinux and XIP 
> will produce a stack of hits - here's one:
> http://www.snapgear.com/tb20010618.html

Yep, we have this for uClinux. Currently we are only doing
this on MMU-less processors though, I haven't heard of anyone
doing kernel (or apps) XIP from flash on VM processors.

Kernel running direct from flash is reasonably easy to do
in uClinux, and pretty much all supported architectures can do it.
(The supported archiectures includes embedded Motorola m68k
(68306, 68328, 68332, 68360), Motorola ColdFire (5206, 5206e,
5249, 5272, 5307, 5407), MMUless ARM cores (Atmel/AT91,
NetSilicon/NET+ARM, Samsung/4510, Conexant/P52, etc),
SPARC LEON, NEC v850, OPENcores OR1000, NIOS core, i960,
and in the works SH2, and MIPS 4k.

We can do apps too, although on most architecture with no
VM this requires some compiler support for PIC code (either
using a GOT or only relative addressing). Currently this
is only done for the m68k, ColdFire and ARM platforms. This
would not be a problem for VM processors.

Most uClinux platforms only have flash, so this setup is
used extensively. And most people use read-only root filesystems
on flash to make them as small as possible. Someting like
the ROMfs type or CRAMfs are good options here.

I know others have mentioned performance here. But for most
people in this space it is the unit $ that is most important.
For simple uClinux systems using a 2.0.39 kernel you can run
in 2MiB of RAM if you don't want many apps (and you have
configured your kernel appropriaetely). That would be with 1MiB
of flash for kernel and small filesystem. Although you can trade
off RAM and flash here to get your best mix. I build demo
uClinux systems for the older Motorola ColdFire eval boards that
have 1MiB of RAM. And in that I run a 2.0.39 kernel and a shell,
with about 100k left over :-)  [And that is all in RAM, kernel +
filesystem + apps]

Many of the modern embedded 32bit CPU's have cache, and the slower
flash access speeds are well hidden anyway. Usually only a small
performance penalty. I have a demo board that I can configure
for either 32 or 16 bit memory, and the difference on most
benchmarks with that is about 10%.

Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com


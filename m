Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263342AbTAXT2L>; Fri, 24 Jan 2003 14:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263837AbTAXT2L>; Fri, 24 Jan 2003 14:28:11 -0500
Received: from ns.suse.de ([213.95.15.193]:14342 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S263342AbTAXT2J>;
	Fri, 24 Jan 2003 14:28:09 -0500
Date: Fri, 24 Jan 2003 20:37:21 +0100
From: Andi Kleen <ak@suse.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: ak@suse.de, linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: two x86_64 fixes for 2.4.21-pre3
Message-ID: <20030124193721.GA24876@wotan.suse.de>
References: <15921.37163.139583.74988@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15921.37163.139583.74988@harpo.it.uu.se>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2003 at 08:16:59PM +0100, Mikael Pettersson wrote:
> 1. The new IDE code in -pre references a few new macros and
>    inlines from <asm/system.h> that x86_64 doesn't provide.

Already fixed in my tree, but thanks for the reminder to push 
it to Marcelo. I have some more bug fixes that I will push to
him soon too.

> 2. bootsect.S has the same bug that i386' bootsect.S had
>    until I fixed it in 2.4.14 or so: it stops the floppy
>    controller in a way that cause newer FDCs to lock up.
>    The same patch as in i386' bootsect.S fixes the problem.

Ok, will check that.

> 
> The x86_64 kernel boots RH8.0 fairly well, but the IA32 emulation
> has some rough spots. In particular, "sleep" SEGVs with a #GP
> every time, and sys32_ioctl() complains:

The sys32_ioctl warnings are usually harmless.
I think some i386 hwclock versions even call bogus ioctls just in case
it is running on m68k or something like that.
I believe I fixed up all rtc clock ioctls that are actually used.
[someone familiar with rtc double checking it would be welcome of course]

Of course patches are always welcome.

> 
> sleep[15] general protection rip:4004441c rsp:ffffed60 error:0
> sys32_ioctl(hwclock:23): Unknown cmd fd(3) cmd(00004b50) arg(ffffeb50)
> date[28] general protection rip:4002141c rsp:ffffebc0 error:0
> date[30] general protection rip:400204ee rsp:ffffe4c4 error:0
> sys32_ioctl(mount:62): Unknown cmd fd(4) cmd(80041272) arg(ffff6948)
> sys32_ioctl(mount:62): Unknown cmd fd(4) cmd(80041272) arg(ffff6948)
> sys32_ioctl(mount:69): Unknown cmd fd(4) cmd(80041272) arg(ffff6968)
> sys32_ioctl(mount:69): Unknown cmd fd(4) cmd(80041272) arg(ffff6968)
> rpmq[120] general protection rip:401c641c rsp:ffffed40 error:0
> sleep[140] general protection rip:4003ebe5 rsp:ffffed60 error:0
> sys32_ioctl(iwconfig:183): Unknown cmd fd(3) cmd(00008b01) arg(ffffea90)
> sleep[196] general protection rip:4003ebe5 rsp:ffffed20 error:0
> 
> (The system is vanilla RH8.0 with Athlon binaries, running under
> the Virtutech Simics 1.4.7 simulator. The x86_64 kernel was
> cross-compiled with binutils-2.13.2.1 and gcc-3.2.1.)

Works for me on Simics with a SuSE 32bit userland.

You have to figure out what breaks on RedHat yourself.

We had some problems with the TLS register used on very new glibcs
(%gs), but they should be fixed now in the codedrop in 2.4.21pre3.

-Andi

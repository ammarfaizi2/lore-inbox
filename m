Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263875AbTF0GJt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 02:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263894AbTF0GJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 02:09:49 -0400
Received: from mho.net ([64.58.22.200]:16542 "EHLO es1036.belits.com")
	by vger.kernel.org with ESMTP id S263875AbTF0GJq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 02:09:46 -0400
Date: Fri, 27 Jun 2003 00:18:04 -0600 (MDT)
From: Alex Belits <abelits@phobos.illtel.denver.co.us>
To: Guennadi Liakhovetski <gl@dsa-ac.de>
cc: linux-kernel@vger.kernel.org, debian-glibc@lists.debian.org
Subject: Re: VIA Ezra CentaurHauls
In-Reply-To: <Pine.LNX.4.33.0306181205180.2967-100000@pcgl.dsa-ac.de>
Message-ID: <Pine.LNX.4.53.0306262351040.29477@phobos.illtel.denver.co.us>
References: <Pine.LNX.4.33.0306181205180.2967-100000@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jun 2003, Guennadi Liakhovetski wrote:

> Hello
>
> We have a platform with the above processor, and we happened to have 2
> revisions thereof: stepping 8 and 10. With stepping 8 we are getting
> "random" application crashes (segfaults), sometimes with kernel-Oopses.
> The distribution is Debian-Woody. I saw some messages on the Debian
> mailing list about problems with exactly this CPU, however, it was not
> related to different revisions (stepping), perhaps, the author only had
>  / tried stepping 8. The fix was to upgrade libc. I've done this (to
> version libc6_2.3.1-16, but it didn't help. Any ideas?

  I have two EPIA 800 motherboards with different CPUs:

1. The board has "Revision B" printed on it.
CPU is:
processor       : 0
vendor_id       : CentaurHauls
cpu family      : 6
model           : 7
model name      : VIA Ezra
stepping        : 8
cpu MHz         : 800.047
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu de tsc msr cx8 mtrr pge mmx 3dnow
bogomips        : 1595.80

2. The board is "Revision D", but otherwise looks exactly the same.
CPU is:
processor       : 0
vendor_id       : CentaurHauls
cpu family      : 6
model           : 7
model name      : VIA Samuel 2
stepping        : 3
cpu MHz         : 800.047
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu de tsc msr cx8 mtrr pge mmx 3dnow
bogomips        : 1595.80

  Both boards were used in exactly the same environment, as a replacement
for a failed FV24 motherboard in SV24 box that had Debian Woody already
installed. Obviously, to make it boot I had to recompile the kernel, and
I had to recompile mplayer that I have previously built for i686
(everything was done with gcc 2.95.4).

  First board worked perfectly until I have started (as a regular user)
RealPlayer 8. After that the box became unstable, and other applications
(mozilla, mplayer, gcc) started to crash randomly with SEGV. However I
have not seen a kernel crash.

  I have tried different X drivers (trident from 4.3.0, trident from
current, vesa), different memory, one or two sticks, different power
supplies (including a known-good ATX power supply just in case), different
CMOS settings (including "safe" default, all caches off, etc.), and the
result was the same -- no problems without RealPlayer, application crashes
after it started. TRplayer, that uses RealPlayer's libraries, has the same
effect, however mplayer (tested only with non-Realmedia sources) worked
perfectly, and even shown an impressive performance by playing SVCD in
vidix mode with no dropped frames (as long as I was not doing anything
else at the same time). When I have started RealPlayer, programs started
to randomly crash, and whatever the problem was, it was not confined to
the userid that RealPlayer was running as -- mplayer and gcc were running
as root when they crashed. Usually things crashed with segmentation fault,
however once RealPlayer crashed with floating point exception. Puzzled, I
have ran memtest86, and all memory that ever was in that box passed all
basic tests (I had no patience for anything more than that).

  When I have installed the second motherboard (obviously, with no other
modifications), all problems disappeared. I have also checked the
RealPlayer binaries, and objdump shown no cmov.

  I don't know what exactly happens, but it looks for me very strange that
a single piece of code causes all this havoc, and that over all that time
apparently no SIGILLs happened. I can only speculate that "something"
leaves some piece of state in CPU (or maybe in cache) that survives a
context switch, and messes up the state of other processes (registers or
maybe memory). And whatever it is, "VIA Samuel 2, stepping 3" does not
have it.

-- 
Alex

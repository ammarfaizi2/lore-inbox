Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbUDECTN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 22:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbUDECTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 22:19:13 -0400
Received: from mta6.srv.hcvlny.cv.net ([167.206.5.72]:45909 "EHLO
	mta6.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S261326AbUDECTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 22:19:06 -0400
Date: Sun, 04 Apr 2004 22:18:57 -0400
From: Jeff Sipek <jeffpc@optonline.net>
Subject: Re: 2.6.5-aa1
In-reply-to: <20040405002028.GB21069@dualathlon.random>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Marcus Hartig <m.f.h@web.de>, linux-kernel@vger.kernel.org
Message-id: <200404042219.05212.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: Text/Plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.6.1
References: <40707888.80006@web.de> <200404041859.47940.jeffpc@optonline.net>
 <20040405002028.GB21069@dualathlon.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 04 April 2004 20:20, Andrea Arcangeli wrote:
> did you get an oops or just a sigsegv? (see dmesg) 

only sigsegv

> If you only got a 
> sigsegv can you try to keep the segfaulting process under "strace -o
> /tmp/o -p <pid>" and report the last few syscalls before the segfault?

Sure. I started the process as:

artsdsp -m et

et is a shell script (created during the installation) that changes the 
working directory and executes et.x86. Then, I attached strace to the actual 
executable (et.x86.)

Here are last few lines of the output:

ioctl(68, 0xc0104629, 0xbfffda98)       = 0
munmap(0x47e37000, 1056768)             = 0
ioctl(68, 0xc0104629, 0xbfffda98)       = 0
ioctl(70, 0xc0184633, 0xbfffdaa4)       = 0
ioctl(68, 0xc0104629, 0xbfffdab4)       = 0
ioctl(71, 0xc01046cf, 0xbfffda88)       = 0
close(71)                               = 0
ioctl(68, 0xc0104629, 0xbfffdab4)       = 0
ioctl(72, 0xc01046cf, 0xbfffda88)       = 0
close(72)                               = 0
ioctl(68, 0xc0104629, 0xbfffdab4)       = 0
ioctl(73, 0xc01046cf, 0xbfffda88)       = 0
close(73)                               = 0
ioctl(68, 0xc0104629, 0xbfffdaa4)       = 0
ioctl(68, 0xc0104629, 0xbfffdaa4)       = 0
ioctl(68, 0xc0104629, 0xbfffdaa4)       = 0
ioctl(68, 0xc0104629, 0xbfffda98)       = 0
ioctl(68, 0xc0104629, 0xbfffda8c)       = 0
ioctl(68, 0xc0104629, 0xbfffdaa4)       = 0
ioctl(68, 0xc0104629, 0xbfffdaa4)       = 0
ioctl(68, 0xc0104629, 0xbfffdaa4)       = 0
munmap(0x4804b000, 4096)                = 0
ioctl(68, 0xc0104629, 0xbfffdab4)       = 0
ioctl(68, 0xc0104629, 0xbfffdab4)       = 0
close(70)                               = 0
getpid()                                = 1987
munmap(0x46b9b000, 378720)              = 0
munmap(0x46bf8000, 4933916)             = 0
write(2, "Shutdown tty console\n", 21)  = 21
ioctl(0, SNDCTL_TMR_TIMEBASE or TCGETS, {B38400 opost isig -icanon -ec
ho ...}) = 0
ioctl(0, SNDCTL_TMR_STOP or TCSETSW, {B38400 opost isig icanon echo ..
.}) = 0
ioctl(0, SNDCTL_TMR_TIMEBASE or TCGETS, {B38400 opost isig icanon echo
 ...}) = 0
munmap(0x4bbd5000, 1210664)             = 0
munmap(0x4c029000, 46072)               = 0
munmap(0x4c257000, 344064)              = 0
munmap(0x4c035000, 2233160)             = 0
munmap(0x4c2ab000, 1210664)             = 0
munmap(0x4c3d3000, 46072)               = 0
munmap(0x489bd000, 4096)                = 0
exit_group(0)                           = ?

> That should reduce the scope of the problem, I had a look at the
> diff between rc3 and 2.6.5 final but I found nothing obvious that could
> explain your problem (yet).

I had to use artsdsp to run et, because it, just like everything else here, 
hangs when it tries to open /dev/dsp. Even dd if=/dev/dsp of=/dev/null hangs. 
Interestingly enough, xmms works without any problems via both alsa and oss 
emulation.

Strace reports shows this:
open("/dev/dsp", O_RDWR
and waits forever. While lsof shows NO processes. (Note: the sound issue is 
not new, I just tested 2.6.2-rc? and it was broken there too.)

Jeff.

- -- 
Keyboard not found!
Press F1 to enter Setup
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAcMIXwFP0+seVj/4RAsEoAKCxzeLvcxtmCIk5TDqiBQvFHAcJ4QCdH8yg
BqvMqoTQvcSEjPC453IJTOs=
=Fq9B
-----END PGP SIGNATURE-----

Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316391AbSEQQuA>; Fri, 17 May 2002 12:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316421AbSEQQt7>; Fri, 17 May 2002 12:49:59 -0400
Received: from chaos.analogic.com ([204.178.40.224]:9600 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S316391AbSEQQt6>; Fri, 17 May 2002 12:49:58 -0400
Date: Fri, 17 May 2002 12:50:18 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Athanasius <Athanasius@miggy.org.uk>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Just an offer
In-Reply-To: <20020517163024.GB17483@miggy.org.uk>
Message-ID: <Pine.LNX.3.95.1020517123652.637A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 May 2002, Athanasius wrote:

> On Fri, May 17, 2002 at 10:48:21AM -0400, Richard B. Johnson wrote:
> > Where there is a will, there is a way. As others have reported, you
> > can have an old "always-on" machine at the remote site. You can have
> > LILO redirect kernel messages out the serial port to be viewed
> 
>    It strikes me that this is also in part a LILO 'problem'.  We could
> use some way to tell LILO to only boot a given image _once_ as the
> default, and thence reboot to the normal default.  Combine this with any
> of the methods for remote reboot (hardware watchdog, other machine wired
> to reset, whatever) and you can easily recover from a futzed new kernel.
>    I'm sure LILO can find room for a single byte 'flag' for such things
> and an extra per-config option in /etc/lilo.conf.
> 
> -Ath, checking the LILO docs to see if it does something like this
> already...
> -- 

Of course there is a 'default' entry to be booted by LILO. But
this is what it will boot if there's nobody at the remote site
to hit the ALT key and change to another.

LILO could be modified to look for a printer-port bit pattern
to decide which entry it will boot. This is trivial but makes
it incompatible with systems that don't have anything connected
(which could cause any random bit-pattern to be latched.

LILO could also be modified to use the BIOS int 0x14 RS-232C
interface to send prompts out there as well as the screen/keyboard.
This allows an always-on remote computer to do the boot configuration.

Nevertheless, there is no way for LILO to keep track of boots and
decide for itself if it should try the 'next' kernel because the
previous didn't work. This would require that it write something
into media that is not always writable. The PC, itself, has no
where to store such information except in the CMOS, all locations
of which may already have been 'taken' or, at least included in
the checksum, resulting in no boot sequence at all because the
BIOS will say "CMOS Checksum failure... hit [F2]..." or whatever
else non-standard may exist.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.


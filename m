Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271675AbRHQPj2>; Fri, 17 Aug 2001 11:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271676AbRHQPjT>; Fri, 17 Aug 2001 11:39:19 -0400
Received: from chaos.analogic.com ([204.178.40.224]:6784 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S271675AbRHQPjI>; Fri, 17 Aug 2001 11:39:08 -0400
Date: Fri, 17 Aug 2001 11:39:14 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Holger Lubitz <h.lubitz@internet-factory.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Encrypted Swap
In-Reply-To: <3B7D2F3C.A4687E25@internet-factory.de>
Message-ID: <Pine.LNX.3.95.1010817111201.863A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Aug 2001, Holger Lubitz wrote:

> Ryan Mack proclaimed:
> > is running.  If the system is physically compromised, there is little way
> > I can think of to take root without having to at least reboot the
> > computer, thus destroying the unencrypted contents of RAM.
> 
> This is a myth. RAM survives rebooting, even after a quick power cycle
> most cells will probably still be ok. And with todays memory sizes, it
> would take a noticable amount of time to initialize all of it to a given
> value, so most systems don't do it (just testing some bytes of every
> megabyte instead).
> 
> Holger
> -

Errrm no. All BIOS that anybody would use write all memory found when
initializing the SDRAM controller. They need to because nothing,
refresh, precharge, (or if you've got it, parity/crc) will work
until every cell is exercised. A "warm-boot" is different. However,
if you hit the reset or the power switch, nothing in RAM survives.

The BIOS procedure necessary to size RAM, and find out what sticks
are in what slots, is quite a memory-distructor itself. With SDRAM
controllers, after the reset, all memory addresses are ignored.
A write to memory writes to ALL memory plus the controller itself.
You typically set up the controller by writing some commands to
address 0. Once there is a power-up, the BIOS must delay at least
100 us before trying to initialize the SDRAM controller. The
"all banks precharge" command connects all banks together and
anything they contained is lost forever. This is the first command
necessary to initialize the SDRAM controller. All the command bits
are driven as 12 bits and they are sinked by every cell on every
chip because the all-banks precharge hooked them together. So, even
if by some magic the cells had survived the power-cycle, the lowest
12 bits in every long-word will now be corrupted by the initialization
commands that follow.

The so-called "quick" memory test just doesn't test the memory which
typically involves setting/resetting/checking every bit in memory. The
initialiation, sizing and the zeroing still occurs.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423225AbWCUSmS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423225AbWCUSmS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 13:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423203AbWCUSmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 13:42:18 -0500
Received: from rwcrmhc11.comcast.net ([204.127.192.81]:53692 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1423225AbWCUSmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 13:42:17 -0500
Message-ID: <442048B2.9020809@comcast.net>
Date: Tue, 21 Mar 2006 13:40:50 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mail/News 1.5 (X11/20060309)
MIME-Version: 1.0
To: Joshua Kugler <joshua.kugler@uaf.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Lifetime of flash memory
References: <44203179.3090606@comcast.net> <200603210920.53549.joshua.kugler@uaf.edu>
In-Reply-To: <200603210920.53549.joshua.kugler@uaf.edu>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Joshua Kugler wrote:
> On Tuesday 21 March 2006 08:01, John Richard Moser wrote:
>> I have a kind of dumb question.  I keep hearing that "USB Flash Memory"
>> or "Compact Flash Cards" and family have "a limited number of writes"
>> and will eventually wear out.  Recommendations like "DO NOT PUT A SWAP
>> FILE ON USB MEMORY" have come out of this.  In fact, quoting
>> Documentation/laptop-mode.txt:
>>
>>   * If you're worried about your data, you might want to consider using
>>     a USB memory stick or something like that as a "working area". (Be
>>     aware though that flash memory can only handle a limited number of
>>     writes, and overuse may wear out your memory stick pretty quickly.
>>     Do _not_ use journalling filesystems on flash memory sticks.)
>>
>> The question I have is, is this really significant?  I have heard quoted
>> that flash memory typically handles something like 3x10^18 writes; and
>> that compact flash cards, USB drives, SD cards, and family typically
>> have integrated control chipsets that include wear-leveling algorithms
>> (built-in flash like in an iPaq does not; hence jffs2).  Should we
>> really care that in about 95 billion years the thing will wear out
>> (assuming we write its entire capacity once a second)?
>>
>> I call FUD.
> 
> Search for a thread on LKML having to do with enabling "sync" on removable 
> media, especially VFAT media.  If you are copying a large file, and the FAT 
> on the device is being updated with every block, you can literally fry your 
> device in a matter of minutes, because the FAT is always in the same spot, 
> thus it is always overwriting the same spot.
> 

I've run with 'sync', it makes the removable device operate at a blazing
1.2k/s transfer rate instead of 13M/s.  I actually tried to `dd
if=/dev/zero of=/media/usbdisk bs=64k` to zero out 150 megs of free
space, but gave up after about half an hour.  This was a test to see the
speed of the drive under sync/nosync modes.

I thought these things had wear leveling on the control chips, seriously.

"USB mass storage controller - implements the USB host controller and
provides a seamless linear interface to block-oriented serial flash
devices while hiding the complexities of block-orientation, block
erasure, and wear balancing. The controller contains a small RISC
microprocessor and a small amount of on-chip ROM and RAM. (item 2 in the
diagram)"

^^^ From a diagram of a USB flash drive on Wikipedia.
http://en.wikipedia.org/wiki/USB_flash_drive

These drives seem to be rated for millions of writes:

"In normal use, mid-range flash drives currently on the market will
support several million cycles, although write operations will gradually
slow as the device ages."

Although there have been cases...

"A few cheaper USB flash drives have been found to use unsuitable flash
memory chips labelled as 'ROM USE ONLY' - these are intended for tasks
such as Flash BIOS for Routers rather than for continual rewrite use,
and fail after a very small number of cycles. [6]"

At which point we obviously know we shouldn't be doing what we're doing
with these things in the first place!

With proper wear balancing, a million writes across a drive should last
quite a while.  About:

(C*10.0^6bytes * ((64.0 * 1024bytes) / Wblocks)) / (60s/min * 60min/hr *
24.0hr/day * 365.25day/yr)

C=Capacity, W=Written blocks.  This gives you how many years the drive
lasts writing W blocks per second (the unit is years/blockseconds).

For a 256M flash drive this should be 130 years; a 4GiB iPod nano should
last 2080 years under this abuse (1 write to 1 block per 1 second); and
a 32GiB "flash hard disk" should last like 16600 years.  That does, of
course, assume wear-leveling takes the entire storage area into account
instead of localizing to a single small area.

> j----- k-----
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond

    We will enslave their women, eat their children and rape their
    cattle!
                                     -- Evil alien overlord from Blasto
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRCBIsQs1xW0HCTEFAQK9EQ/9FYw9OzNYWrJFqLvtQgKegAvCFps2piR0
ZGqiLTHCA+BApZ3k+1vdxdFHKpT9t3HDsvjsS1GoIRqbMyD1u+ZbbjKUBLf5DQSO
SyBnpQRfnDOXoXnNM92PRObuRbvsVHzwpMMd79IljFKmneUnUrw0wem2/rv1FEbb
Q8c6IzLmzK/18oG0OowxWl8DjhwY8QmAPA45SJ0VE9RL3nM0uigY7ISVNEMK6qEb
sNuQ9tYkE8qkzTakbk09pVG7G9GljVbUMbBbkwb2v7aihnSEcFMCl717+KrDxuRL
ogGSZHZcF/bNs8FNlHAPBm057xHYpBiGaVwvM9Nm6aXPBxzxVed4iyTQ3NUyiy0K
m7YnpLrSJ3vDxge3tB/sOoIvXTg1LlfU5tjqE37YGBGxmuSNXyeP9yWuuw00Fxzd
osYKtu7FX6h8REo5NUtOB+1t7HGe3dMa7PAuBjz6f+MbBd0psr/4id/ecm6m7yuU
UJDHYVnN5kN/kDahN9VrEWLW7i04tAiCEPccQ/42pBM7EzjUkeBmNSWvn18XVBr+
2A+EIDY/+BtmJHJyC0WTvFN5mlnJ/tSdNP0zQx/5o5XvqdQEw1SnbmsToYl3w+MD
i2k0dt+8VUgLGv3YJYfTGYasllND//qI8kqRFzkcxifSVDI4eWm8p18fw8XSOluK
0RzELRz6VK4=
=9NS3
-----END PGP SIGNATURE-----

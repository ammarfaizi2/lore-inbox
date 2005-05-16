Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261705AbVEPPaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbVEPPaY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 11:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbVEPP2C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 11:28:02 -0400
Received: from alog0210.analogic.com ([208.224.220.225]:43689 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261705AbVEPP1I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 11:27:08 -0400
Date: Mon, 16 May 2005 11:26:38 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Jeff Garzik <jgarzik@pobox.com>
cc: Matthias Andree <matthias.andree@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: Disk write cache (Was: Hyper-Threading Vulnerability)
In-Reply-To: <4288AF3A.2000008@pobox.com>
Message-ID: <Pine.LNX.4.61.0505161057570.18962@chaos.analogic.com>
References: <1115963481.1723.3.camel@alderaan.trey.hu> <20050515145241.GA5627@irc.pl>
 <Pine.LNX.4.58.0505151657230.19181@artax.karlin.mff.cuni.cz>
 <200505151121.36243.gene.heskett@verizon.net>
 <Pine.LNX.4.58.0505151809240.26531@artax.karlin.mff.cuni.cz>
 <20050516111859.GB13387@merlin.emma.line.org> <4288AF3A.2000008@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 May 2005, Jeff Garzik wrote:

> Matthias Andree wrote:
>> On Sun, 15 May 2005, Mikulas Patocka wrote:
>>
>>
>>> Note that disk can still ignore FLUSH CACHE command cached data are small
>>> enough to be written on power loss, so small FLUSH CACHE time doesn't
>>> prove disk cheating.
>>
>> Have you seen a drive yet that writes back blocks after power loss?
>>
>> I have heard rumors about this, but all OEM manuals I looked at for
>> drives I bought or recommended simply stated that the block currently
>> being written at power loss can become damaged (with write cache off),
>> and that the drive can lose the full write cache at power loss (with
>> write cache on) so this looks like daydreaming manifested as rumor.
>
> Upon power loss, at least one ATA vendor's disks try to write out as
> much data as possible.
>
> 	Jeff

Then I suggest you never use such a drive. Anything that does this,
will end up replacing a good track with garbage. Unless a disk drive
has a built-in power source such as super-capacitors or batteries, what
happens during a power-failure is that all electronics stops and
the discs start coasting. Eventually the heads will crash onto
the platter. Older discs had a magnetically released latch which would
send the heads to an inside landing zone. Nobody bothers anymore.

Many high-quality drives cache data. Fortunately, upon power loss
these data are NOT attempted to be written. This means that,
although you may have incomplete or even bad data on the physical
medium, at least the medium can be read and written. The sectoring
has not been corrupted (read destroyed).

If you think about the physical process necessary to write data to
the medium, you will understand that without a large amount of
energy storage capacity on the disk, it's just not possible.

To write a sector, one needs to cache the data in a sector-buffer
putting on a sector header and trailing CRC, wait for the write-
splice from the previous sector (could be almost one rotation),
then write data and sync to the sector. If the disc is too slow,
these data will be underwrite the sector. Also, if the disc
was only 5 percent slow, the clock recovery on a subsequent
read will be off by 5 percent, outside the range of PLL lock-in,
so you write something that can never be read, a guaranteed bad block.

Combinations of journalizing on media that can be completely flushed,
and ordinary cache-intensive discs can result in reliable data
storage. However a single ATA or SCSI disk just isn't a perfectly
reliable storage medium although it's usually good enough.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.

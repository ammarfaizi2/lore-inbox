Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbWBZMzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbWBZMzF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 07:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750901AbWBZMzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 07:55:05 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:36008 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S1750817AbWBZMzD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 07:55:03 -0500
Message-ID: <4401A532.4030602@dgreaves.com>
Date: Sun, 26 Feb 2006 12:55:14 +0000
From: David Greaves <david@dgreaves.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: Mark Lord <lkml@rtr.ca>, Justin Piszcz <jpiszcz@lucidpixels.com>,
       Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       albertcc@tw.ibm.com, axboe@suse.de, htejun@gmail.com
Subject: Re: LibPATA code issues / 2.6.15.4
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F2050B.8020006@dgreaves.com> <Pine.LNX.4.64.0602141211350.10793@p34> <200602141300.37118.lkml@rtr.ca> <440040B4.8030808@dgreaves.com> <440083B4.3030307@rtr.ca> <Pine.LNX.4.64.0602251244070.20297@p34> <4400A1BF.7020109@rtr.ca> <4400B439.8050202@dgreaves.com> <4401122A.3010908@rtr.ca> <44019E96.20804@superbug.co.uk>
In-Reply-To: <44019E96.20804@superbug.co.uk>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Courtier-Dutton wrote:

> I have two desktop linux machines. One is an old Pentium 3 which shows
> the following errors(no libata involved):
> Linux version 2.6.15-rc4 (root@games) (gcc version 4.0.3 20051111
> (prerelease) (Debian 4.0.2-4)
> ) #1 Sat Dec 3 18:47:19 GMT 2005
> Dec 16 22:51:57 games kernel: hdc: dma_intr: status=0x51 { DriveReady
> SeekComplete Error }
> Dec 16 22:52:32 games kernel: hdc: dma_intr: error=0x40 {
> UncorrectableError }, LBAsect=53058185, sector=53057951
> Dec 16 22:52:32 games kernel: ide: failed opcode was: unknown
> Dec 16 22:52:32 games kernel: end_request: I/O error, dev hdc, sector
> 53057951
> Dec 16 22:52:32 games kernel: hdc: dma_intr: status=0x51 { DriveReady
> SeekComplete Error }
> Dec 16 22:52:32 games kernel: hdc: dma_intr: error=0x10 {
> SectorIdNotFound }, LBAsect=53058185, sector=53057959
> Dec 16 22:52:32 games kernel: ide: failed opcode was: unknown

This looks like a simple bad disk drive. Notice that the sectors are
quite close.
If you like you can move the drive to a working machine and run a
badblocks on it.
do 'man badblocks' before you start.
Is it SMART capable? What does
  smartctl -a /dev/hdc
show?

ddrescue may be your friend if you need to recover data.

Reply offlist if this is the case.

> The other has the following errors:
> Linux version 2.6.15.1 (root@localhost) (gcc version 3.4.5 (Gentoo
> 3.4.5, ssp-3.4.5-1.0, pi
> e-8.7.9)) #3 SMP PREEMPT Fri Feb 3 23:19:05 GMT 2006
> Feb 10 23:30:07 localhost kernel: ata3: command 0xb0 timeout, stat
> 0xd0 host_stat 0x0
> Feb 10 23:30:07 localhost kernel: ata3: translated ATA stat/err
> 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> Feb 10 23:30:07 localhost kernel: ata3: status=0xd0 { Busy }
> Feb 10 23:30:07 localhost kernel: ATA: abnormal status 0xD0 on port
> 0xF880E087
> Feb 10 23:30:07 localhost last message repeated 3 times
> Feb 10 23:30:10 localhost kernel: ata3: PIO error
> Feb 10 23:30:10 localhost kernel: ata3: status=0x50 { DriveReady
> SeekComplete }
> Feb 11 10:18:10 localhost kernel: ata2: command 0xb0 timeout, stat
> 0xd0 host_stat 0x0
> Feb 11 10:18:10 localhost kernel: ata2: translated ATA stat/err
> 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> Feb 11 10:18:10 localhost kernel: ata2: status=0xd0 { Busy }
> Feb 11 10:18:10 localhost kernel: ATA: abnormal status 0xD0 on port 0x177
> Feb 11 10:18:10 localhost last message repeated 3 times

Have you got smartd running?
I get a similar problem running some smartcl commands (-s on and -o on)
I suspect this is a libata ata passthru problem - but I'm *guessing* :)

check the last messages in dmesg then run
smartctl -data -s on /dev/sd...
smartctl -data -o on /dev/sd...
See if there are new messages in dmesg

David

-- 


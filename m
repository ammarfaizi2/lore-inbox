Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131208AbRCGVT0>; Wed, 7 Mar 2001 16:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131209AbRCGVTR>; Wed, 7 Mar 2001 16:19:17 -0500
Received: from chaos.analogic.com ([204.178.40.224]:25728 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S131208AbRCGVTK>; Wed, 7 Mar 2001 16:19:10 -0500
Date: Wed, 7 Mar 2001 16:17:50 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Andre Hedrick <andre@linux-ide.org>
cc: Harvey Fishman <fishman@panix.com>, "J. Dow" <jdow@earthlink.net>,
        Jens Axboe <axboe@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Microsoft ZERO Sector Virus, Result of Taskfile WAR
In-Reply-To: <Pine.LNX.4.10.10103071225510.19253-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.3.95.1010307155738.12565A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Mar 2001, Andre Hedrick wrote:

> 
> Harvey,
> 
> That is not the case Joanne is pointing out.
> The SCSI low-level format glue performed by the HOST gets destroyed
> If you write to LBA Zero.  ATA only suffers the lose of the partition
> table and that can be recovered, but SCSI needs that information to know
> where everything else is on the drive.
> 
> You know I really do not care anymore that people can screw themselves,
> and that Linux has choosen the road of pure UNIX, user beware.  After the
> last battles, I encourge stupidity, because the no IOCTLS will require you
> know how to use the hardware rules completely, and if you compose the
> wrong command because you can not/will not understand the rules of IO and
> use the interface improperly, tough.
[SNIPPED...]

You can read/write/trash LBA zero all you want with SCSI. It contains
only user (your) data. The disk drive contains a RCT (reconstruction and
caching table). The entries in this are built up during the format-unit
command. If you interrupt the power at just the right instant during
a format-unit, you can corrupt this table and make the drive unusable.

It is highly unlikely that you'd be able to crowbar the supply at just
the right instant, even if you designed the drive and knew what it
was doing at every instance.

This is not something you could do with software. SCSI talks SCSI, there
are no SCSI commands that say "corrupt the RCT". So a virus, although
it can blow away all user data, and can initiate a format-unit command
(BIOS function code 7), can't get at anything that will disable
the drive.

That said, the format-unit command takes some interesting parameters.
One of them is a defect list. It is possible to format the drive so
that all cylinders are "defective"!!  Of course this goes away when
you format the drive without such a defect list.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310364AbSCLCvb>; Mon, 11 Mar 2002 21:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310370AbSCLCvX>; Mon, 11 Mar 2002 21:51:23 -0500
Received: from avocet.mail.pas.earthlink.net ([207.217.120.50]:10631 "EHLO
	avocet.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S310364AbSCLCvJ>; Mon, 11 Mar 2002 21:51:09 -0500
Message-ID: <01a401c1c970$aeb74110$1125a8c0@wednesday>
From: "J. Dow" <jdow@earthlink.net>
To: "Jeff Garzik" <jgarzik@mandrakesoft.com>,
        "Linus Torvalds" <torvalds@transmeta.com>
Cc: "Bill Davidsen" <davidsen@tmr.com>, "LKML" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0203111741310.8121-100000@home.transmeta.com> <3C8D667F.5040208@mandrakesoft.com>
Subject: Re: [patch] My AMD IDE driver, v2.7
Date: Mon, 11 Mar 2002 18:50:34 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Jeff Garzik" <jgarzik@mandrakesoft.com>

> Linus Torvalds wrote:
> 
> >
> >On Mon, 11 Mar 2002, Jeff Garzik wrote:

...

> First, for verification of the driver, it's darned useful to be able to 
> issue ATA commands from userspace.  But since we're being generic, let's 
> just call them device commands, and imagine SCSI perhaps playing in this 
> playground too.

No fooling! (By way of history I was one of the SCSI device driver mavens
for the Amiga. We covered this generic command ground, recovered this ground,
and generally ground this ground into the ground.)

> Second, if you are issuing device commands from userspace, you need to 
> deal with synchronization with the commands being issued from kernel space.

Generally speaking, yes.

> Third, if you have synchronization, that's a good and easy point to add 
> -optional- filtering.

And while I see your point I still ask, "But why?" To make this work the
way it should work you will need a special table of normally disallowed
commands that are allowed for each specific device on the IDE buses
within a machine. You also need this to be generic enough to allow some
commands to go through except for some specific sets of parameters. Now,
I realize that SCSI is more generic than IDE. However, contemplating this
sort of filtering within SCSI device drivers fell into such a point of
silliness that it became the general concensus within the community that
the filtering is inappropriate. In point of fact this proved useful when
technology marched on. The facility within SCSI device drivers for directly
issueing low level commands became instantly important with the advent of
drives that were larger than 2^24 bytes. The normal read/write interface
on the device drivers was byte offset and byte count oriented, even though
it required the byte offsets to be on block boundaries. The direct SCSI
command interface allowed for workaround patches that broke the disk into
several virtual disks. These patches would open the low level driver and
insert themselves as the "real" device driver for the set of devices on
each SCSI bus. This died away fairly quickly as filesystem adaptations
became more popular. These adaptations, in the case finally adopted within
the latest OS revisions, involved an institutionalized driver patch that
presented a proper 64 bit read/write interface to the filesystems. The
fact that the device drivers that are no longer under any sort of
development are patched using direct SCSI commands is neatly hidden
from the users. But it is there and allowed the OS to survive where there
was no further maintenance effort taking place.

I note there seem to be more than one device driver for Linux that is no
longer maintained or poorly maintained. While I doubt this will be the
case for generic IDE, I do suspect that specific IDE interfaces that have
"peculiarities" will fall by the wayside as fewer people use them. It
might be nice to have the ability to patch around these drivers rather
than try to patch then with no test cases handy. It saved a significant
amount of grief on the Amiga. There's no reason I can see that it would
not save grief on Linux.

> Now... the overall point I am trying to sell is...  IFF certain 
> lesser-used device commands are primarily issued from userspace, and IFF 
> it is not reasonable to create a new kernel interface, is it not 
> reasonable to be able to issue raw device commands from userspace?  Just 
> the verification case alone seems like a strong argument.
> 
> Call it device_command not ata_command if you want, and add SCSI 
> support.  Passing in raw device_commands from userspace is useful, IMO. 
>  Throw in filtering of those commands, and life is golden for everybody 
> AFAICS.  There is no need to be ATA specific with these goals...

It might be a good exercise, Jeff, to define the filters in such a way
that potentially harmful commands can be adequately filters while other
potentially "saving" commands can be allowed even if they differ only in
parameters. It is also interesting to note that direct userland ATA and
ATAPI reads and writes are fully as dangerous as any exotic level commands.
Linux seems to allow this danger. What makes the other commands so dangerous?
I'm not as familiar with the Linux SCSI interfaces as with those of the
Amiga. (I've sort of moved on to video work.) However, I wonder if the Linux
SCSI world filters "mode select" and manufacturer defined commands or not.
I suspect they have a longer history with this sort of interface and its
abuse than IDE. It might pay to investigate and adopt consonant postures.

{^_^}   Joanne Dow, jdow@earthlink.net, did Amiga SCSI device drivers for
        a decade or so as a consultant.


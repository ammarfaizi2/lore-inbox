Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311898AbSDXMdd>; Wed, 24 Apr 2002 08:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311917AbSDXMdc>; Wed, 24 Apr 2002 08:33:32 -0400
Received: from chaos.analogic.com ([204.178.40.224]:38276 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S311898AbSDXMdb>; Wed, 24 Apr 2002 08:33:31 -0400
Date: Wed, 24 Apr 2002 08:31:35 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Bill Davidsen <davidsen@tmr.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A CD with errors (scratches etc.) blocks the whole system while reading damadged files
In-Reply-To: <Pine.LNX.3.96.1020423182543.31248C-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.3.95.1020424081802.20796A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Apr 2002, Bill Davidsen wrote:

> On Fri, 19 Apr 2002, Richard B. Johnson wrote:
> 
> > On Thu, 18 Apr 2002, Dr. Death wrote:
> > 
> > > Problem:
> > > 
> > > I use SuSE Linux 7.2 and when I create md5sums from damaged files on a 
> > > CD, the WHOLE system  freezes or is ugly slow untill md5 has passed the 
> > > damaged part of the file !
> > > 
> > 
> > So what do you suggest? You can see from the logs that the device
> > is having difficulty  reading your damaged CD. You can do what
> > Windows-95 does (ignore the errors and pretend everything is fine),
> > or what Windows-98 and Windows-2000/Prof does (blue-screen, and re-boot),
> > or you can try like hell to read the files like Linux does. What do you
> > suggest?
> 
> Several things come to mind:
> 1 - don't dedicate the entire machine to retrying the error such that
>     everything else runs slowly if at all.

But it doesn't! As previously stated, if you have a device on a common
'channel' (like IDE), that everybody else is trying to use, then
everybody else ends up waiting. However, if your errored devices don't
take over a common I/O channel, everybody else gets the CPU while the
errors are being retried.

For instance, I have SCSI for my disks, and I use IDE for a R/W CD
because it's cheap. I can "try forever" reading dorked CDs and the
only process affected at all is the one trying to read the CD. I
can do full-speed compiles while the CD is being retried.

It's all about configuration. The kernel drivers sleep while waiting
for interrupts that will determine the success or failure of the
disk operation. The 'sleep' means that the CPU gets given to somebody
who could use it.


> 2 - if the hardware returns an uncorrectable sector error that should be
>     passed back to the user process rather than retried. An unconditional
>     deep retry on an error the hardware labels as uncorrectable is not
>     desirable, and not better than the Windows in most cases.
> 

The problem is that the hardware usually waits for the worse-case time
(disk spin-up time) to even report an error. It's not like you could
somehow wait for one rev of the disk to determine if a sector could
be read. The disk, itself, retries for a long time, then it reports
a rather general-purpose error (media error on SCSI, bad sector on
IDE, record not found, etc).

> I took a bottle cap to one of the morning's AOL CDs and then tried to read
> it. It's really not just annoying, it's pretty much useless. If you were
> staging software off a CD on a running server, your clients would NOT be
> happy!
> 

Put your CDs on a different controller and you can do anything you
want without affecting other tasks.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.


Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312582AbSDXTym>; Wed, 24 Apr 2002 15:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312584AbSDXTyl>; Wed, 24 Apr 2002 15:54:41 -0400
Received: from chaos.analogic.com ([204.178.40.224]:9344 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S312582AbSDXTyj>; Wed, 24 Apr 2002 15:54:39 -0400
Date: Wed, 24 Apr 2002 15:52:00 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Bill Davidsen <davidsen@tmr.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A CD with errors (scratches etc.) blocks the whole system while reading damadged files
In-Reply-To: <Pine.LNX.3.96.1020424150911.3065D-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.3.95.1020424153658.5784A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Apr 2002, Bill Davidsen wrote:

> On Wed, 24 Apr 2002, Richard B. Johnson wrote:
> 
> > On Tue, 23 Apr 2002, Bill Davidsen wrote:
> 
> > > Several things come to mind:
> > > 1 - don't dedicate the entire machine to retrying the error such that
> > >     everything else runs slowly if at all.
> > 
> > But it doesn't! As previously stated, if you have a device on a common
> > 'channel' (like IDE), that everybody else is trying to use, then
> > everybody else ends up waiting. However, if your errored devices don't
> > take over a common I/O channel, everybody else gets the CPU while the
> > errors are being retried.
> > 
> > For instance, I have SCSI for my disks, and I use IDE for a R/W CD
> > because it's cheap. I can "try forever" reading dorked CDs and the
> > only process affected at all is the one trying to read the CD. I
> > can do full-speed compiles while the CD is being retried.
> 
> That's very nice for a system where cost is no object, but ATAPI/IDE is
> where the bulk of Linux system are running. Putting the CD on another
> cable is realistic (the system I hung does that) but putting the CD on IDE
> and the disk on SCSI is not cost effective compared to fixing the hang in
> software.
>  

It is NOT a hang in the software. IDE means Integrated Drive Electronics.
The ONLY thing the CPU has to work with is the electronics IN the drive.
It communicates with the drive from a port on the mother-board. There
is no controller on the motherboard. There is absolutely nothing to
isolate one drive from another. A single drive, doing its retries will
"own" that drive-cable until it has either succeded or given up.

The CPU software MUST NOT do anything on that port until the previous
request was answered via interrupt. This means that if the CD is
using the bus, no task can access any hard-disk drive that is on
that same port.

You can see that there is plenty of CPU time available by having
one task do;

while true; do echo "Hello World!"; done

(before you access you damaged CD).

Then, using another VT, access your damaged CD.

When you switch to the 'Hello world' terminal, it's merrily spinning
along, getting all the CPU time your other task would have gotten
if the drive was readable.

> > It's all about configuration. The kernel drivers sleep while waiting
> > for interrupts that will determine the success or failure of the
> > disk operation. The 'sleep' means that the CPU gets given to somebody
> > who could use it.
> 
> It would also be nice if the other IDE channels were given to "somebody
> who could use it," but that would appear in some cases not to happen.
> 

There are no other IDE channels to give up. The 'master/save'
configuration should be labled 'cheaper' and the two/channel
configuration should be labeled 'cheapest'. It's what you pay
for. It has nothing to do with the kernel or its drivers.
Recent work on IDE was an attempt to get DMA operations and
other 'speed-up' operations to work better. They will never
work well because IDE is not designed to work well. It's
designed to simply exist.

[SNIPPED...]


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.


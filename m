Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbWBMQbe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbWBMQbe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 11:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbWBMQbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 11:31:33 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:57274 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932116AbWBMQbc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 11:31:32 -0500
Date: Mon, 13 Feb 2006 11:31:27 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Phillip Susi <psusi@cfl.rr.com>
cc: Kyle Moffett <mrmacman_g4@mac.com>, Alon Bar-Lev <alon.barlev@gmail.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Flames over -- Re: Which is simpler?
In-Reply-To: <43F0027E.2070207@cfl.rr.com>
Message-ID: <Pine.LNX.4.44L0.0602131113310.7035-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Feb 2006, Phillip Susi wrote:

> During suspend the hardware is usually completely powered off, and in 
> either case, there is nothing running on the CPU to monitor device 
> insertion/removal.

Like Kyle said, this depends to some extent on the system.  However, 
during Suspend-to-RAM it is definitely true that the RAM at least is 
powered on.  Other components may be powered as well.  Otherwise you 
wouldn't be able to awaken the system by pressing a button/opening the 
case/whatever.

>  When the system is resumed the kernel decides if the 
> hardware has changed the same way for either system: it probes the 
> hardware to see if it is still there.  There isn't anything special that 
> monitors device insertion/removal while suspended to ram.

Sorry, but you're wrong.  First of all, testing if hardware is there is
different from testing whether it has changed -- it could have changed 
while the system was asleep, with the result that hardware is indeed there 
but it's not the _same_ hardware.

Second, with USB at any rate, in addition to checking that hardware is 
still there, the kernel queries the USB controller to see if a disconnect 
occurred while the system was asleep.  (If the controller wasn't powered 
during that time then it will report that every USB device was 
disconnected.)

Third, there is indeed something special that monitors USB device 
insertion/removal while suspended to RAM -- the USB host controller does 
so if it has suspend power.

> >> This is not true.  The USB bus is shut down either way, and provided 
> >> that you have not unplugged the disk, nothing will be screwed when you 
> >> resume from disk or ram.
> > 
> > Have you actually tried it?  I have.  
> 
> If it doesn't work then you have found a bug and should file a report. 

No.  It does work exactly as designed and it's not buggy.  You just don't
understand it.

> The state of the kernel after resuming from either suspend to disk, or 
> suspend to ram is the same.  The filesystem is still mounted, and any 
> dirty pages in ram will be flushed just like normal.  Whether the disk 
> is connected via SCSI, SATA, USB, or whatever does not matter.

Don't be silly.  Dirty pages can't be flushed to disks that are no longer
attached!  And if a USB disk was unplugged while the system was asleep,
the kernel will know that it is no longer attached.  I don't know which
other bus drivers check for this sort of thing.

> The kernel knows that the same device is still there on the bus, and so 
> it picks up right where it left off.  If it thinks the device has been 
> unplugged and reconnected, that is a bug.

It's not a bug if the device _has_ been unplugged and reconnected.  When 
that happens, there's no way for the kernel to tell whether the device 
there now is the same as the device that used to be there.

Alan Stern


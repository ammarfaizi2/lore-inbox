Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751575AbWBMDwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575AbWBMDwh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 22:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751577AbWBMDwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 22:52:37 -0500
Received: from ms-smtp-04-smtplb.tampabay.rr.com ([65.32.5.134]:3489 "EHLO
	ms-smtp-04.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S1751575AbWBMDwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 22:52:36 -0500
Message-ID: <43F0027E.2070207@cfl.rr.com>
Date: Sun, 12 Feb 2006 22:52:30 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mail/News 1.5 (X11/20060119)
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
CC: Kyle Moffett <mrmacman_g4@mac.com>, Alon Bar-Lev <alon.barlev@gmail.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Flames over -- Re: Which is simpler?
References: <Pine.LNX.4.44L0.0602122104330.20351-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0602122104330.20351-100000@netrider.rowland.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern wrote:
> 
> It's not just semantics.  There's a real difference between maintaining
> state in the hardware and maintaining it somewhere else.  The biggest
> difference is that if the hardware retains suspend power, it is able to
> detect disconnections.  When the system resumes, it _knows_ whether a
> device was attached the entire time, as opposed to being unplugged and
> replugged (or possibly a different device plugged in!) while the system
> was asleep.  If the hardware is down completely, there is no way of
> telling for certain whether a device attached to some port is the same one
> that was there when the system got suspended.
> 

During suspend the hardware is usually completely powered off, and in 
either case, there is nothing running on the CPU to monitor device 
insertion/removal.  When the system is resumed the kernel decides if the 
hardware has changed the same way for either system: it probes the 
hardware to see if it is still there.  There isn't anything special that 
monitors device insertion/removal while suspended to ram.

>> This is not true.  The USB bus is shut down either way, and provided 
>> that you have not unplugged the disk, nothing will be screwed when you 
>> resume from disk or ram.
> 
> Have you actually tried it?  I have.  

If it doesn't work then you have found a bug and should file a report. 
The state of the kernel after resuming from either suspend to disk, or 
suspend to ram is the same.  The filesystem is still mounted, and any 
dirty pages in ram will be flushed just like normal.  Whether the disk 
is connected via SCSI, SATA, USB, or whatever does not matter.

> 
> In any case, it is undeniably true that if the bus is shut down then all
> the USB connections are lost.  When you resume it will be the same as if
> you had unplugged all the USB devices and then replugged them.  Not a good
> thing to do when they contain mounted filesystems; all the memory mappings
> are invalidated.
> 

The kernel knows that the same device is still there on the bus, and so 
it picks up right where it left off.  If it thinks the device has been 
unplugged and reconnected, that is a bug.

> (Bear in mind that whether a USB bus gets shut down depends on the
> motherboard; some supply suspend power and some don't.  It depends on the
> USB controller too; some support low-power states other than "completely
> off" and others don't.)
> 
> Alan Stern
> 


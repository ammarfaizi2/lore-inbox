Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261927AbVBDVEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261927AbVBDVEp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 16:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264116AbVBDVBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 16:01:17 -0500
Received: from ida.rowland.org ([192.131.102.52]:2308 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S263764AbVBDUzR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 15:55:17 -0500
Date: Fri, 4 Feb 2005 15:55:06 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Rusty Russell <rusty@rustcorp.com.au>
cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] 2.6: USB disk unusable level of data corruption
In-Reply-To: <1107519382.1703.7.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44L0.0502041539350.674-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Feb 2005, Rusty Russell wrote:

> OK, I recently made the mistake of buying a USB case with a drive in it
> and putting my home directory on it.  I have since then had multiple
> ext3 and ext2 errors: 2.6.8, 2.6.9, 2.6.10 and 2.6.11-rc3 all exhibit
> the problem within an hour of stress (untarring a fresh kernel tree, cp
> -al'ing to apply patches repeatedly, my normal workload).  I haven't had
> any similar problems on my internal IDE drive.  2.4 succeeded once, and
> once had data corruption (although nowhere near as as bad as the 2.6
> corruption, and it got much further).
> 
> I realize "ub" exists, but it doesn't seem to want to deal with a disk
> device.
> 
> Is USB/SCSI just terminally broken under 2.6?  I'll be getting a power
> supply to test the drive using firewire, which it also supports, to
> ensure this isn't a disk issue (although the 2.4 goodness undermines
> this theory).

Right now we have no reason to believe there's anything wrong with the USB 
stack or the usb-storage/SCSI drivers.  A few other people have also 
reported data corruption at about the same level as you; we've only been
able to trace a couple of them to software errors.  And those generally 
involved a higher error rate than you're seeing.

The most likely explanation seems to be hardware problems.  Particularly
for high-speed USB devices, 2.6 drives the hardware much closer to the
limit than 2.4 or Windows (to judge by the problem reports we've seen).  
One case came up just a couple of days ago, in which this sort of data
corruption was definitively traced to a known erratum in the peripheral's
USB interface.  (The controller chip was an old revision which has been
supplanted, but who knows what sort of hardware lurks in the hearts of
commercial drives?)

Alan Stern


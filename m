Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbWBMCTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWBMCTG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 21:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbWBMCTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 21:19:06 -0500
Received: from mx1.rowland.org ([192.131.102.7]:18954 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S1751157AbWBMCTF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 21:19:05 -0500
Date: Sun, 12 Feb 2006 21:19:02 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Phillip Susi <psusi@cfl.rr.com>
cc: Kyle Moffett <mrmacman_g4@mac.com>, Alon Bar-Lev <alon.barlev@gmail.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Flames over -- Re: Which is simpler?
In-Reply-To: <43EFD806.3000904@cfl.rr.com>
Message-ID: <Pine.LNX.4.44L0.0602122104330.20351-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Feb 2006, Phillip Susi wrote:

> Alan Stern wrote:
> > Both of you are missing an important difference between Suspend-to-RAM and 
> > Suspend-to-Disk.
> > 
> > Suspend-to-RAM is a true suspend operation, in that the hardware's state
> > is maintained _in the hardware_.  External buses like USB will retain
> > suspend power, for instance (assuming the motherboard supports it; some
> > don't).
> > 
> > Suspend-to-Disk, by contrast, is _not_ a true suspend.  It can more 
> > accurately be described as checkpoint-and-turn-off.  Hardware state is not 
> > maintained.  (Some systems may support a special ACPI state that does 
> > maintain suspend power to external buses during shutdown, I forget what 
> > it's called.  And I down't know whether swsusp uses this state.)
> > 
> 
> I would disagree.  The only difference between the two is WHERE the 
> state is maintained - ram vs. disk.  I won't really argue it though, 
> because it's just semantics -- call it whatever you want.

It's not just semantics.  There's a real difference between maintaining
state in the hardware and maintaining it somewhere else.  The biggest
difference is that if the hardware retains suspend power, it is able to
detect disconnections.  When the system resumes, it _knows_ whether a
device was attached the entire time, as opposed to being unplugged and
replugged (or possibly a different device plugged in!) while the system
was asleep.  If the hardware is down completely, there is no way of
telling for certain whether a device attached to some port is the same one
that was there when the system got suspended.

Another difference is the possibility of remote wakeup.  Clearly it can't 
happen when there's no power available.

> > So for example, let's say you have a filesystem mounted on a USB flash or
> > disk drive.  With Suspend-to-RAM, there's a very good chance that the
> > connection and filesystem will still be intact when you resume.  With
> > Suspend-to-Disk, the USB connection will terminate when the computer shuts
> > down.  When you resume, the device will be gone and your filesystem will
> > be screwed.
> > 
> 
> This is not true.  The USB bus is shut down either way, and provided 
> that you have not unplugged the disk, nothing will be screwed when you 
> resume from disk or ram.

Have you actually tried it?  I have.  

In any case, it is undeniably true that if the bus is shut down then all
the USB connections are lost.  When you resume it will be the same as if
you had unplugged all the USB devices and then replugged them.  Not a good
thing to do when they contain mounted filesystems; all the memory mappings
are invalidated.

(Bear in mind that whether a USB bus gets shut down depends on the
motherboard; some supply suspend power and some don't.  It depends on the
USB controller too; some support low-power states other than "completely
off" and others don't.)

Alan Stern


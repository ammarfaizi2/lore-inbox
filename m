Return-Path: <linux-kernel-owner+w=401wt.eu-S1750999AbXAOQgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbXAOQgk (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 11:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750993AbXAOQgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 11:36:40 -0500
Received: from firewall.rowland.harvard.edu ([140.247.233.35]:39709 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1750981AbXAOQgj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 11:36:39 -0500
Date: Mon, 15 Jan 2007 11:36:38 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Oliver Neukum <oneukum@suse.de>
cc: linux-usb-devel@lists.sourceforge.net, Oliver Neukum <oliver@neukum.org>,
       <icxcnika@mar.tar.cc>, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] 2.6.20-rc4: usb somehow broken
In-Reply-To: <200701151724.42831.oneukum@suse.de>
Message-ID: <Pine.LNX.4.44L0.0701151129070.15327-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jan 2007, Oliver Neukum wrote:

> Am Montag, 15. Januar 2007 17:03 schrieb Alan Stern:
> > On Mon, 15 Jan 2007, Oliver Neukum wrote:
> 
> > > Upon further thought, a module parameter won't do as the problem
> > > will arise without a driver loaded. A sysfs parameter turns the whole
> > > affair into a race condition. Will you set the guard parameter before the
> > > autosuspend logic strikes?
> > > Unfortunately this leaves only the least attractive solution.
> > 
> > There could be a mixed approach: a builtin blacklist that is extensible 
> > via a procfs- or sysfs-based interface.
> 
> If you want to ask with a lot of bug reports which blacklist was loaded,
> then we could.

This is a "damned-if-you-do, damned-if-you-don't" situation.  Anyway, I've 
never liked the idea of loading up the kernel with a bunch of preset 
blacklist entries.  For most users that are a waste of space, and unneeded 
entries almost never get removed.

> > Note that we actually have two problems to contend with.  Some devices
> > must never be autosuspended at all (they disconnect when resuming), and
> > others need a reset after resuming.
> 
> Do those who can be brought back with a reset need to be listed at all?
> Error handling is not a bad idea.

The problem is that the system can't always tell that a reset is needed.  
There might be no symptoms at all.  For example, I've got a USB keypad 
which doesn't work right after a resume -- key presses never get sent to 
the computer.  As far as the system can tell the device is fine, though.

Alan Stern


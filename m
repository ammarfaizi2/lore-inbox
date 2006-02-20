Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932602AbWBTEEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932602AbWBTEEx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 23:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932603AbWBTEEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 23:04:52 -0500
Received: from mx1.rowland.org ([192.131.102.7]:22793 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S932602AbWBTEEw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 23:04:52 -0500
Date: Sun, 19 Feb 2006 23:04:48 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Olivier Galibert <galibert@pobox.com>
cc: Pavel Machek <pavel@ucw.cz>, Phillip Susi <psusi@cfl.rr.com>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       Alon Bar-Lev <alon.barlev@gmail.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Flames over -- Re: Which is simpler?
In-Reply-To: <20060220012619.GA27899@dspnet.fr.eu.org>
Message-ID: <Pine.LNX.4.44L0.0602192254140.29356-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Feb 2006, Olivier Galibert wrote:

> On Mon, Feb 20, 2006 at 02:01:02AM +0100, Pavel Machek wrote:
> > Actually, if you really want to do this, it would probably make sense
> > to do at blockdevice level -- with device mapper magic or something.
> > 
> > That way you could prompt user "return that flash driver, I still want
> > to write to it" after surprise unplug, etc. And suspend is special
> > case of surprise unplug, then replug.
> 
> I'm not sure.  Suspend is not a surprise, so you can do things so that
> you don't lose anything (what I described is pretty much unmounting
> while keeping file references).  Surprise unplug, there is no way you
> can make the filesystem clean if it wasn't already.

I like Pavel's suggestion.  It's simpler at the device driver level 
(unless you're working on the device-mapper driver!) and it can apply to 
situations other than unplug-during-suspend.

As for making the filesystem clean following a surprise unplug...  You can
if the device is plugged back in later and you recognize it as the same
device.

> I also think that USB flash and this kind of things should go back to
> clean state as soon as possible even whe mountd, but that's a
> different issue.

A new mount option, like "-o clean"?  Something that would flush data
writes immediately (like "sync") and would flush metadata writes whenever
a file is closed and other similar occasions?  People have been asking for 
something like this.  Mounting with "sync" is very bad for flash memory 
devices, and mounting without it messes up progress-bar displays in user 
programs.  Something in between would be appreciated.  Especially for the 
VFAT driver.

Alan Stern


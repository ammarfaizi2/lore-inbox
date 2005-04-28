Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262211AbVD1S0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262211AbVD1S0w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 14:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262210AbVD1S0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 14:26:52 -0400
Received: from mail.tmr.com ([64.65.253.246]:33554 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S262189AbVD1S0f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 14:26:35 -0400
Date: Thu, 28 Apr 2005 14:13:27 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Multiple functionality breakages in 2.6.12rc3 IDE layer
In-Reply-To: <1114703284.18809.208.camel@localhost.localdomain>
Message-ID: <Pine.LNX.3.96.1050428140509.29292A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Apr 2005, Alan Cox wrote:

> Ages ago we added an ide_default driver to clean up all the corner cases
> like spurious IRQs for a device with no matching driver (eg ide-cd and
> no CD driver) as well as ioctls and file access. 
> 
> 2.6.12rc removes it. Unfortunately it also means that if your only IDE
> interface is one you hand configure you can no longer run Linux. It also
> changes other aspects of behaviour although they don't look problematic
> for most users. You can no longer
> 	- Control the bus state of an interface
> 	- Reset an interface

But isn't that the stuff we use for swapping drives? Down the drive, down
the interface, swap, and restart? Are these the functions called by hdparm
(-bRU) which are all of a sudden not going to work? Or am I being
alarmist?

> 	- Add an interface if none exist
> 	- Issue raw commands
> 	- Get an objects bios geometry
> 	- Read the identify data by ioctl (its still in proc but may be stale)
> 
> without having a device specific driver loaded matching the media - and
> that only works if its already detected the device correctly.

I missed the discussion of why it was felt that the users would no longer
want to be able to do these things, or the new way to do it.
> 
> I don't have the tools at the moment to generate spurious IRQ's for
> devices with no driver loaded but it does look like the code may well
> then crash. From the way the changes were done it appears the current
> IDE maintainers never appreciated that ide_default existed for far more
> than just cleaning up ide-proc but also to handle IRQ's, opening of
> empty slots, ioctls and power
> management ?
> 
I suspect that's true, but should it not have been discussed first?

> The ability to specify the IDE ports on the command line as needed for
> some Sony laptop installs have also become "obsolete" over time. They
> still appear to work but spew a warning that the user will soon be
> screwed.

I'll have to read the release notes and see who to thank for this
reduction in functionality.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267493AbTAGVZh>; Tue, 7 Jan 2003 16:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267606AbTAGVZg>; Tue, 7 Jan 2003 16:25:36 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:8196 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267493AbTAGVZf>; Tue, 7 Jan 2003 16:25:35 -0500
Date: Tue, 7 Jan 2003 21:34:13 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Helge Hafting <helgehaf@aitel.hist.no>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: 2.5.54: radeonfb almost works
In-Reply-To: <3E14315E.F80B3DFF@aitel.hist.no>
Message-ID: <Pine.LNX.4.44.0301072124250.17129-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Just booting with video=radeon gives me a 640x400
> mode.  There's some initial garbage (looks like early boot
> messages converted to graphichs at the wrong resolution)
> on the screen, but that isn't a problem.  The low resolution
> is, though.

640x480 is normal. 

 
> I first tried "fbset 1280x1024-60", which changed
> the resolution, but the console was still a
> small 640x400 thing in the upper left corner of
> the 1280x1024 display.  Not very useful.

Because fbset is only useful for setting /dev/fb. You want to use stty
to set the resolution now. The advantage of this is we don't end up
with a console mode of 80 3/4 columns by 30 1/4 rows. 
Try

stty cols 160 rows 64 

assuming you are using 8x16 fonts.
 
> So I tried booting with video=radeon:1280x1024-32@60
> That gave me a blank screen, the monitor complained
> about "no signal".
> 
> But I logged in blind, and ran fbset 1280x1024-60
> again.  This gave me the console I want.
> 1280x1024 resolution, with 160x64 characters.

Sounds like a monitor timings issue. fbset cheats by taking
times from the /etc/fb.mods file. I'm working on patch 
that was sent to me to deal with this.

> Another problem comes up when running X.  Switching
> from X to some virtual console always gives me the
> "no signal" thing, and I have to type the fbset
> command blind before the console becomes
> visible.  Switching back to X is never a problem.

Same problem again. It is a monitor timings issue. 
We are working on this.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262019AbRFBWra>; Sat, 2 Jun 2001 18:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262009AbRFBWrU>; Sat, 2 Jun 2001 18:47:20 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:33028 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S262019AbRFBWrB>; Sat, 2 Jun 2001 18:47:01 -0400
Date: Sun, 3 Jun 2001 00:46:55 +0200
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Reading from /dev/fb0 very slow?
Message-ID: <20010603004655.E2434@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20010602105249.A979@bug.ucw.cz> <E156JUS-0002DC-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <E156JUS-0002DC-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, Jun 02, 2001 at 11:03:24PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I did some benchmarks, and my framebuffer is *way* faster when writing
> > than when reading:
> 
> That is quite normal.

Unfortunately, at least X and few framebuffer modes can not survive
that too well.

vesafb ypan mode attempts to do video-to-video copy, which is slow.
Xserver attempts that, too. 

> > That is 6 times slower! This is also very visible in X, where moving
> > regions is expensive, while just drawing regions is fast. For example
> > gnome-terminal is *way* faster *with* transparent background option.
> > 
> > Any idea why such assymetry? [This is toshiba 4030cdt with vesafb and
> > 2.4.5]
> 
> Writes to a PCI device can be queued or posted. Reads from a PCI device for
> obvious reasons have to stall the CPU until the data returns. 

But they can't be posted indifinitely, right? I'm copying whole
framebuffer at a time, I do not believe PCI has enough buffers to
cache *that*. [Or is it using some kind of burst mode it can not use
for reading? That does not give a sense, you can cache reads, too....]

-- 
The best software in life is free (not shareware)!		Pavel
GCM d? s-: !g p?:+ au- a--@ w+ v- C++@ UL+++ L++ N++ E++ W--- M- Y- R+

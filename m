Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132701AbRDQO4H>; Tue, 17 Apr 2001 10:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132704AbRDQOzk>; Tue, 17 Apr 2001 10:55:40 -0400
Received: from dentin.eaze.net ([216.228.128.151]:16646 "EHLO xirr.com")
	by vger.kernel.org with ESMTP id <S132700AbRDQOyn>;
	Tue, 17 Apr 2001 10:54:43 -0400
Date: Tue, 17 Apr 2001 09:55:06 -0500 (CDT)
From: SodaPop <soda@xirr.com>
To: Pavel Machek <pavel@suse.cz>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Oscillations in disk write compaction, poor interactive performance
In-Reply-To: <20010416152928.B40@(none)>
Message-ID: <Pine.LNX.4.30.0104170950350.24360-100000@xirr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Apr 2001, Pavel Machek wrote:

> Hi!
>
> > It also seems that in the 2.4 kernels, we can get into a sort of
> > oscillation mode, where we can have long periods of disk activity
> > where nothing can get done - the low points, where only 2-3 writes
> > per second can occur, so completely screw up the interactive
> > performance that you simply have to take your hands off the
> > keyboard and go get coffee until the disk writes complete.  I know
> > we get better performance overall this way, but it can be
> > frustrating when this occurs in the middle of video capture.
>
> I see oscilation even in 2.2.X case....
>
> Can you try running while true; do sync; sleep 1; done? It should help.
>
> If it helps, try playing with bdflush/kupdate or how is it called/ parameters.
>
> --
> Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
> details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.
>

The problem isn't that it oscillates, at least the oscillations shouldn't
cause any problems - though we probably shouldn't see large scale
oscillations like this anyway.

The problem is that at the low point in the cycle, the machine is
unusable.  It is utterly unresponsive until the writes complete, which can
take a very long time (in the case of the ppc machine, several minutes!)
Anything that does disk I/O will block for a long time - having 'ls' take
two minutes is not a good thing.

2.2 does not exhibit this behaviour.

On the plus side, it appears that several other people are reporting this
problem in 2.4, so I don't think I'm totally out to lunch.

-dennis T


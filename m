Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282712AbRK0B25>; Mon, 26 Nov 2001 20:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282716AbRK0B2r>; Mon, 26 Nov 2001 20:28:47 -0500
Received: from mauve.demon.co.uk ([158.152.209.66]:57473 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP
	id <S282712AbRK0B2c>; Mon, 26 Nov 2001 20:28:32 -0500
From: Ian Stirling <root@mauve.demon.co.uk>
Message-Id: <200111270123.BAA02056@mauve.demon.co.uk>
Subject: Re: Journaling pointless with today's hard disks?
To: landley@trommello.org
Date: Tue, 27 Nov 2001 01:23:32 +0000 (GMT)
Cc: andre@linux-ide.org (Andre Hedrick), cw@f00f.org (Chris Wedgwood),
        linux-kernel@vger.kernel.org
In-Reply-To: <0111261535070J.02001@localhost.localdomain> from "Rob Landley" at Nov 26, 2001 03:35:07 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Monday 26 November 2001 15:30, Andre Hedrick wrote:
> > On Mon, 26 Nov 2001, Rob Landley wrote:
> 
> > > Just add an off-the-shelf capacitor to your circuit.  The firmware
> > > already has to detect power failure in order to park the head sanely, so

> > Send me an outline/discription and I will present it during the Dec T13
> > meeting for a proposal number for inclusion into ATA-7.
> 
> What kind of write-up do you want?  (How formal?)
> 
> The trick here is limiting the scope of the problem.  Your buffer can't be 
> larger than you can reliably write back on a sudden power failure.  (This 
> should be obvious.)  So the obvious answer is to make your writeback cache 
> SMALL.  The problems that go with flushing it are then correspondingly small.
<snip>
> 
> Now a cache large enough to hold 2 full tracks could also hold dozens of 
> individual sectors scattered around the disk, which could take a full second 
> to write off and power down.  This is a "doctor, it hurts when I do this" 
> question.  DON'T DO THAT.

Or, to seek to a journal track, and write the cache to it.
Errors are a problem, writing twice may help.
This avoids having to block on bad write patterns, for example, if you
are writing mixed blocks that go to tracks 1 and 88, you can't start to
write blocks that would go to track 44.
Performance would rise if it can do the writes in elevator order.

<snip>
> That way, the power down problem is strictly limited:
> 
> 1) write out the track you're over
> 2) seek to the second track
> 3) write that out too
> 4) park the head

Or 2) optionally seek to the journal track, and write the journal.

> 
> What new hardware is involved?
> 
> Add a capacitor.
> 
> Add a power level sensor.  (Drives may already have this to know when to park 
> the head.)
Most drives I've taken apart recently seem to have passive means, 
a spring to move the head to the side, and a magnet to hold it there.
<Snip>> 
> I think that's it.  Did I miss anything?  Oh yeah, on power fail stop 

It needs a power switch to stop back-feeding the computer.


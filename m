Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280593AbRKYAxl>; Sat, 24 Nov 2001 19:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280620AbRKYAx3>; Sat, 24 Nov 2001 19:53:29 -0500
Received: from vega.ipal.net ([206.97.148.120]:61110 "HELO vega.ipal.net")
	by vger.kernel.org with SMTP id <S280612AbRKYAxW>;
	Sat, 24 Nov 2001 19:53:22 -0500
Date: Sat, 24 Nov 2001 18:53:21 -0600
From: Phil Howard <phil-linux-kernel@ipal.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Journaling pointless with today's hard disks?
Message-ID: <20011124185321.C4372@vega.ipal.net>
In-Reply-To: <20011124174134.B4372@vega.ipal.net> <200111250024.AAA10086@mauve.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200111250024.AAA10086@mauve.demon.co.uk>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2001 at 12:24:28AM +0000, Ian Stirling wrote:

| <snip>
| > It could be that other drives have the capability to detect and write
| > over sectors made bad by power off.  Or maybe they lock out the sector
| > and map to a spare.  They might even have enough spin left to finish
| > the sector correctly in more cases.
| > 
| > So I doubt the issue is present in other drives, unless the issue is
| > not really as big of one as we might think and the problems with IBM
| > drives are something else.
| > 
| > I do worry that the lighter the platters are, the faster they try to
| > make the drives spin with smaller motors, and the quicker they slow
| > down when power is lost.
| 
| Utterly unimportant.
| Let's say for the sake of argument that the drives spins down to a stop
| in 1 second.
| Now, the datarate for this 40G IDE drive I've got in my box is about
| 25 megabytes per second, or about 50K sectors per second.
| Slowing down isn't a problem.

If it takes 1 second to spin down to a stop, the it probably will
have slowed to a point where serialization writing a sector cannot
be kept in sync within 1 to 5 milliseconds.  Once they _start_
slowing down, time is an extremely precious resource.  That data
pattern has to be read back at full speed.

| 
| Somewhere I've got a databook, ca 85 I think, for a motor driver chip, 
| to drive spindle motors on hard disks, with integrated 
| diodes that rectify the power coming from the disk when the power fails,
| to give a little grace.
| 
| If written by people with a clue, the drive does not need to do much
| seeking to write the data from a write-cache to dics, just one seek 
| to a journal track, and a write.
| This needs maybe 3 revs to complete, at most.

By the time the seek completes, the speed is probably too slow to do a
good write.  Options to deal with this include special handling for the
emergency track to allow reading it back by intentionally slowing down
the drive for that recovery.  Another option is flash disk.

The apparent problem in the IBM DTLA is the write didn't have enough
time to complete with the platter still spinning within spec.  That
means the sector gets compressed at the end and the bit density is
increased beyond readable levels (if it could go higher reliably, they
would just record everything that way).  That and the end of the sector
doesn't fall off into the gap between sectors where there is probably
some low level stuff.  So on readback, some bits are in error due to
the clocking rate rising due to the compression, and the trailing edge
hits the previous sector occupant's un-erased end before the gap.

-- 
-----------------------------------------------------------------
| Phil Howard - KA9WGN |   Dallas   | http://linuxhomepage.com/ |
| phil-nospam@ipal.net | Texas, USA | http://phil.ipal.org/     |
-----------------------------------------------------------------

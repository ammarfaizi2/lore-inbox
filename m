Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136635AbREGTSv>; Mon, 7 May 2001 15:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136633AbREGTSl>; Mon, 7 May 2001 15:18:41 -0400
Received: from bitmover.com ([207.181.251.162]:33614 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S136635AbREGTSY>;
	Mon, 7 May 2001 15:18:24 -0400
Date: Mon, 7 May 2001 12:18:22 -0700
From: Larry McVoy <lm@bitmover.com>
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Wow! Is memory ever cheap!
Message-ID: <20010507121822.V14127@work.bitmover.com>
Mail-Followup-To: "H. Peter Anvin" <hpa@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010505095802.X12431@work.bitmover.com> <20010506142043.B31269@metastasis.f00f.org> <20010505194536.D14127@work.bitmover.com> <9d6qk6$i86$1@cesium.transmeta.com> <20010507115659.T14127@work.bitmover.com> <3AF6F11E.3A03050E@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3i
In-Reply-To: <3AF6F11E.3A03050E@transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2001 at 12:01:50PM -0700, H. Peter Anvin wrote:
> Larry McVoy wrote:
> > > Isn't this pretty much saying "if you're willing to dedicate your
> > > system to running nothing but Bitkeeper, you can run it really fast?"
> > 
> > A) Fast has nothing to do with it, ECC runs at the same speed as non-ECC;
> 
> "It" meaning BitKeeper.

What does BitKeeper have to do with this conversation?  

s/BitKeeper/any_app_which_has_integrity_checks/

Whether that app runs fast or not has nothing to do with ECC/non-ECC, right?
And while whether that app runs fast or not may have something to do with
other apps that you run along side of it, that's true for all apps, right?
So why the focus on BitKeeper?  Am I missing something?

> This is not true in my experience.  YES, it will detect bad memory
> configurations, but with over 2^34 memory cells to worry about -- each of
> them carrying a charge of a few dozen electrons only -- you WILL have
> random failures, especially if the memory is allowed to remain stale for
> extended periods of time, as is very likely in a configuration like this
> (think disk cache.)

BitKeeper, at least, runs the integrity checks every time it accesses the
data.  So it doesn't matter if it is in the disk cache or not.  The same
could be true of any other application.

> Bad memory configurations is bad.  However, good memory configurations
> are not necessarily perfect.

No, they most certainly aren't.  You can have all the ECC you want and if 
the disk or the bus or some or the part of the path corrupts the data then
you are hosed.

Dave Clark made the point that you _MUST_ have end to end checks if you 
care about your data.  He would argue, correctly, in my opinion, that 
it doesn't matter if you have ECC, something else can screw you.

And in fact, while we were having this discussion I was running a disk
scrubber to see if I had bad disks or not:

[root@disks /u1]# df -m .
Filesystem           1M-blocks      Used Available Use% Mounted on
/dev/hdg2                17099         0     17099   0% /u1
[root@disks /u1]# ~lm/tmp/a.out 17000
000000000000000001111111111
BAD @ 1045602304 3e50b000:3e52a000
[root@disks /u1]# 

and from dmesg:

hdh: irq timeout: status=0x50 { DriveReady SeekComplete }
hdg: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14

But my application was NEVER notified that the drive subsystem was hosed,
the operating system (this is 2.4.4, by the way, steaming hot bits), never
told the application that the data was probably bad.  And it isn't a memory
problem, I ran a memory scrubber and the system memory is just fine, it's
the disk subsystem that went out to lunch.  Without telling me, by the way.
If this happened inside of SUN the guy reponsible would be getting a new
orifice courtesy of systems group.  Not cool to pass the data up when it
is bad.

So explain to me how ECC is enough?  It's clearly not.  People have made
compelling arguments for end to end checks for at least 25 years, the
internet works largely because of these end to end checks (turn off 
checksums and find out if I'm right or not, you'll see), ECC isn't end to
end, so what's the point?  Yeah, it's better than nothing but to argue
that it even remotely approaches enough is just flat out wrong, and it
is is _inherently_ unable to be part of a solution which is correct, it's
simply one place that the data lands.  
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 

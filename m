Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129300AbRCFHDe>; Tue, 6 Mar 2001 02:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129276AbRCFHDY>; Tue, 6 Mar 2001 02:03:24 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:40203
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129300AbRCFHDO>; Tue, 6 Mar 2001 02:03:14 -0500
Date: Mon, 5 Mar 2001 23:03:02 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Jonathan Morton <chromi@cyberspace.org>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Jeremy Hansen <jeremy@xxedgexx.com>, linux-kernel@vger.kernel.org
Subject: Re: scsi vs ide performance on fsync's
In-Reply-To: <l03130307b6ca031531fc@[192.168.239.101]>
Message-ID: <Pine.LNX.4.10.10103052254370.13719-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Mar 2001, Jonathan Morton wrote:

> It's pretty clear that the IDE drive(r) is *not* waiting for the physical
> write to take place before returning control to the user program, whereas
> the SCSI drive(r) is.  Both devices appear to be performing the write

Wrong, IDE does not unplug thus the request is almost, I hate to admit it
SYNC and not ASYNC :-(  Thus if the drive acks that it has the data then
the driver lets go.

> immediately, however (judging from the device activity lights).  Whether
> this is the correct behaviour or not, I leave up to you kernel hackers...

Seagate has a better seek profile than ibm.
The second access is correct because the first one pushed the heads to the
pre-seek.  Thus the question is were is the drive leaving the heads when
not active?  It does not appear to be in the zone 1 region.

> IMHO, if an application needs performance, it shouldn't be syncing disks
> after every write.  Syncing means, in my book, "wait for the data to be
> committed to physical media" - note the *wait* involved there - so syncing
> should only be used where data integrity in the event of a system failure
> has a much higher importance than performance.

I have only gotten the drive makers in the past 6 months to committee to
actively updating the contents of the identify page to reflect reality.
Thus if your drive is one of those that does a stress test check that goes:
"this bozo did not really mean to turn off write caching, renabling <smurk>"

Cheers,

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130030AbQKXJNp>; Fri, 24 Nov 2000 04:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129971AbQKXJNf>; Fri, 24 Nov 2000 04:13:35 -0500
Received: from cs.columbia.edu ([128.59.16.20]:20214 "EHLO cs.columbia.edu")
        by vger.kernel.org with ESMTP id <S129728AbQKXJNU>;
        Fri, 24 Nov 2000 04:13:20 -0500
Date: Fri, 24 Nov 2000 00:43:06 -0800 (PST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Andre Hedrick <andre@linux-ide.org>
cc: Guest section DW <dwguest@win.tue.nl>, linux-kernel@vger.kernel.org
Subject: Re: ext2 filesystem corruptions back from dead? 2.4.0-test11
In-Reply-To: <Pine.LNX.4.10.10011232155540.2957-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.21.0011240025570.16450-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2000, Andre Hedrick wrote:

> Since there have been not kernel changes to the driver that effect the
> code since 2.4.0-test5 or test6 and it now randomly shows up after five or
> six revisions out from the change, and the changes were chipset only.
> 
> Please make your point.

My point is simple: I'm trying to see if there is a pattern. I've had
filesystems corrupted with 2.2.18 + the backported IDE driver. Other
people have had filesystems corrupted with 2.4.0 + the same IDE driver.
If *all* people seeing f/s corruption have IDE disks and *none* of them
have SCSI, there might be something worth looking into. It might as well 
be pure coincidence.

What's especially bothering me is the fact that I've seen the IDE driver
choke on DMA or something, and then continue on with life, while serving
*bad* *data* to the upper layers. Even if there were real problems with
the DMA transfers (which is not the case, 2.2.18pre without the IDE patch
runs flawlessly), a driver should never ever serve bad blocks to the f/s
layer. Locking up the machine completely, like some SCSI low-level drivers
do, is much better.

************************************************************************
So I'm asking the same question, to all those who have seen unexplained
filesystem corruption with 2.4.0: are you using IDE drives? If the answer
is yes, can you check the logs and see if, at *any* point before the
corruption occurred, the IDE driver choked and disabled DMA for *any* of
your disks?
************************************************************************

Even if 90% of the installed base is IDE and 10% is SCSI, in terms of how
heavily the hardware is being stressed the advantage of IDE over SCSI is
definitely not 9:1.

And Andre, don't take this personally. We're just trying to save our
precious data here, nothing more. :-) If something comes out of this
inquiry, it might just give you a lead.

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

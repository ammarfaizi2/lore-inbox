Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131144AbRCGSh5>; Wed, 7 Mar 2001 13:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131149AbRCGShs>; Wed, 7 Mar 2001 13:37:48 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:18439 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131144AbRCGShd>; Wed, 7 Mar 2001 13:37:33 -0500
Date: Wed, 7 Mar 2001 10:36:38 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeremy Hansen <jeremy@xxedgexx.com>
cc: Mike Black <mblack@csihq.com>, Andre Hedrick <andre@linux-ide.org>,
        Douglas Gilbert <dougg@torque.net>, linux-kernel@vger.kernel.org
Subject: Re: scsi vs ide performance on fsync's  
In-Reply-To: <Pine.LNX.4.33L2.0103071302140.30803-100000@srv2.ecropolis.com>
Message-ID: <Pine.LNX.4.10.10103071034210.2784-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 7 Mar 2001, Jeremy Hansen wrote:
> 
> So in the meantime as this gets worked out on a lower level, we've decided
> to take the fsync() out of berkeley db for mysql transaction logs and
> mount the filesystem -o sync.
> 
> Can anyone perhaps tell me why this may be a bad idea?

Two reasons:
 - it doesn't help. The disk will _still_ do write buffering. It's the
   DISK, not the OS. It doesn't matter what you do.
 - your performance will suck.

Use fsync(). That's what it's there for. 

Tell people who don't have an UPS to disable write caching. If they have
one (of the many, apparently) IDE disks that refuse to disable it, tell
them to either get an UPS, or to switch to another disk.

		Linus


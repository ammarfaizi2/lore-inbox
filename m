Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131619AbRCSUVx>; Mon, 19 Mar 2001 15:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131627AbRCSUVo>; Mon, 19 Mar 2001 15:21:44 -0500
Received: from c266492-a.lakwod1.co.home.com ([24.1.8.253]:43784 "EHLO
	benatar.snurgle.org") by vger.kernel.org with ESMTP
	id <S131619AbRCSUVY>; Mon, 19 Mar 2001 15:21:24 -0500
Date: Mon, 19 Mar 2001 15:19:37 -0500 (EST)
From: William T Wilson <fluffy@snurgle.org>
To: Otto Wyss <otto.wyss@bluewin.ch>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Linux should better cope with power failure
In-Reply-To: <3AB66233.B85881C7@bluewin.ch>
Message-ID: <Pine.LNX.4.21.0103191513000.22425-100000@benatar.snurgle.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Mar 2001, Otto Wyss wrote:

> inactivity. From the impression I got during the following startup, I
> assume Linux (2.4.2, EXT2-filesystem) is not very suited to any power
> failiure or manually switching it off. Not even if there wasn't any
> activity going on.

What data, if any, did you lose?

While fsck complains loudly when the system comes back up, 9 times in 10
no data is actually lost during a power loss.  e2fsck is really good at
recovering damaged filesystems.

> How could this be accomplished:
> 1. Flush any dirty cache pages as soon as possible. There may not be any
> dirty cache after a certain amount of idle time.

Mount the filesystem synchronously to accomplish this.  It will prevent
the kernel from using a write cache basically.  It will ensure that if a
write operation completes, then the data will be physically on the disk
afterward.

> 2. Keep open files in a state where it doesn't matter if they where
> improperly closed (if possible).

The way to do this is to use a highly reliable filesystem, such as ext3fs,
Tux or ReiserFS.  These filesystems guarantee that metadata is consistent
at all times.

> 3. Swap may not contain anything which can't be discarded. Otherwise
> swap has to be treated as ordinary disk space.

I can't think of a case where the contents of swap matter in any way for
recovering from a power failure.


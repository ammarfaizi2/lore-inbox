Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281775AbRKZPUw>; Mon, 26 Nov 2001 10:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281772AbRKZPUo>; Mon, 26 Nov 2001 10:20:44 -0500
Received: from [206.196.53.54] ([206.196.53.54]:59524 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S281762AbRKZPUa>;
	Mon, 26 Nov 2001 10:20:30 -0500
Date: Mon, 26 Nov 2001 09:22:40 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Andrew Morton <akpm@zip.com.au>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext3: kjournald and spun-down disks
In-Reply-To: <3C01B845.33314F49@zip.com.au>
Message-ID: <Pine.LNX.4.40.0111260910410.15983-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Nov 2001, Andrew Morton wrote:

> Oliver Xymoron wrote:
> >
> > Ok, so what's the theory behind the journal timer? Why would we want
> > ext3 journal flushed more or less often than ext2 metadata given that
> > they're of equivalent importance?
>
> umm, err..  If your machine crashes, ext3 will restore its state
> to that which pertained between zero and five seconds before the crash.
>
> With ext2+fsck, things are not as clear.  Your data will be restored
> to that which pertained from zero to thirty seconds prior to crash.

And that's my point exactly. In terms of integrity, each timer serves the
same purpose - get the filesystem on disk in sync with what's in memory.
Obviously ext3 does a better job of this than ext2 in terms of recovering
from partial transactions, but in both cases the flush is accomplishing
the same thing. I can see no a priori reason why the ext3 journal flush
would be timed differently than ext2 journal flush. If the flush time for
ext3 should be shorter, then so should the time for everything else. See?

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318250AbSIBUa5>; Mon, 2 Sep 2002 16:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317334AbSIBUa5>; Mon, 2 Sep 2002 16:30:57 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:3057 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S316682AbSIBUa4>;
	Mon, 2 Sep 2002 16:30:56 -0400
Date: Mon, 2 Sep 2002 22:35:25 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andries.Brouwer@cwi.nl, neilb@cse.unsw.edu.au,
       <linux-kernel@vger.kernel.org>, <linux-raid@vger.kernel.org>
Subject: Re: PATCH - change to blkdev->queue calling triggers BUG in md.c
Message-ID: <20020902203525.GB9328@win.tue.nl>
References: <UTC200209020853.g828rtj03830.aeb@smtp.cwi.nl> <Pine.LNX.4.44.0209020950500.2452-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209020950500.2452-100000@home.transmeta.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2002 at 10:01:46AM -0700, Linus Torvalds wrote:

> For example, the higher levels want to do a partition table re-read
> if the media really has changed.

My original setup made a kernel that does not know anything about
partition tables. User space would tell the kernel about partitions
on some block device.

Roughly speaking the impact is that there is a partx invocation
before a mount.

Now it seems Al is doing all the work, so I can just sit back and watch.
But I hope he makes precisely this: a kernel that does not do any
partition reading of its own.

Andries


[Yes, it is fundamentally wrong when the kernel starts guessing.
Guessing filesystem type is bad. Also guessing partition table type
is bad. Moreover, the kernel probing may lead to device problems
and even to kernel crashes, as I last observed two days ago.
Only the user knows what she wants to do with this disk. Format?
Remove OnTrack Disk Manager? There are all kinds of situations
where partition table re-read is directly harmful.]

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265139AbTLKQPZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 11:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265145AbTLKQPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 11:15:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:59589 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265139AbTLKQPY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 11:15:24 -0500
Date: Thu, 11 Dec 2003 08:15:18 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jens Axboe <axboe@suse.de>
cc: Douglas Gilbert <dougg@torque.net>, linux-kernel@vger.kernel.org
Subject: Re: cdrecord hangs my computer
In-Reply-To: <20031211125608.GG7599@suse.de>
Message-ID: <Pine.LNX.4.58.0312110807250.2267@home.osdl.org>
References: <3FD444DD.4080206@torque.net> <20031211125608.GG7599@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 11 Dec 2003, Jens Axboe wrote:
>
> What makes you say that Linux has a block-centric IO architecture? 2.6
> block io layer is quite happy to do byte-granularity SCSI commands for
> you.

Indeed.

I don't think some people really _realize_ how much cleaner and generic
the generic block layer is compared to SCSI.

Yes, we call it "block layer" for historical reasons, but the fact is,
it's a "packet command" layer with knowledge of blocking (ie the merging
and sorting code has the ability to merge packets that are marked as
mergeable and fit certain criteria).

And the reason it is so much superior to SCSI is that it's designed to be
generic enough that it doesn't _care_ what the device is. The generic
block layer can work with MD, with floppy disks, with traditional SCSI
devices, and it just _works_.

The block layer doesn't have any silly assumptions about what it is
talking to, although it has some helper functions that are directly aimed
at a block device that implements a SCSI-like packet command set. But they
literally are helper functions - the block layer does not force your
floppy device to pretend that it is some kind of strange SCSI disk when it
isn't.

			Linus

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129397AbRB1XaP>; Wed, 28 Feb 2001 18:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129398AbRB1XaG>; Wed, 28 Feb 2001 18:30:06 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:16139 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129397AbRB1X37>; Wed, 28 Feb 2001 18:29:59 -0500
Date: Wed, 28 Feb 2001 15:29:34 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Steve Whitehouse <Steve@ChyGwyn.com>
cc: pavel@suse.cz, Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: NBD Cleanup patch and bugfix in ll_rw_blk.c
In-Reply-To: <200102282127.VAA20600@gw.chygwyn.com>
Message-ID: <Pine.LNX.4.10.10102281525420.6380-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 28 Feb 2001, Steve Whitehouse wrote:
> 
> I tested the patch with a printk() which printed whenever the new call to the
> request function was triggered. It didn't happen once in normal fs use
> with ext2 on a scsi disk.

As far as I can tell, the patch will trigger only for a not-empty request
list, where the elevator decides to put the new request at the head of the
queue.

Which is probably unlikely (and with the current elevator it might even be
impossible). But it does not look impossible in theory. And I'd really
prefer _not_ to have something that
 - looks completely bogus from a design standpoint
 - might be buggy under some rather unlikely circumstances

Reading them together they become "might cause disk corruption in some
really hard-to-trigger circumstances". No, thank you.

Note that I suspect that all current drivers (or at least the common ones)
have protection against being called multiple times, simply because 2.2.x
used to do it. Which again means that you'd probably never see problems
in practice. But that doesn't make it _right_. 

		Linus


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262219AbTEZUXM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 16:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbTEZUXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 16:23:12 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:61191 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262219AbTEZUXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 16:23:11 -0400
Subject: Re: [BK PATCHES] add ata scsi driver
From: James Bottomley <James.Bottomley@steeleye.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0305261317520.12186-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0305261317520.12186-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 26 May 2003 16:36:18 -0400
Message-Id: <1053981380.1768.203.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-26 at 16:27, Linus Torvalds wrote:
> Talking about tagged queueing - does the SCSI layer still remove the
> request from the request list when it starts executing it?

That's a block layer requirement (blk_queue_start_tag does the dequeue).
But yes, for untagged requests, we still dequeue them manually.

> At least historically that's a major mistake, and generates a crappy 
> elevator, because it removes information from the block layer about where 
> the disk is (or is going to be).
> 
> I know Andrew thinks that SCSI tagged queuing is a bunch of crap, and he 
> has the latency numbers to prove it. He blames the SCSI disks themselves, 
> but I think it might be the fact that SCSI makes it impossible to make a 
> fair queuing algorithm for higher levels by hiding information.
> 
> Has anybody looked at just removing the request at command _completion_ 
> time instead? That's what IDE does, and it's the _right_ thing to do.

Well...I could do it, but since it only applies to untagged devices
(which is really tapes and some CD-ROMs nowadays), I'm not sure it would
be worth the effort.

> I'd hate for SATA to pick up these kinds of mistakes from the SCSI layer.

The elevator is based on linear head movements.  I'm not sure its
optimal to figure out a way to leave all the executing tagged requests
in the queue, is it?  They can be spread out all over the disc with no
idea which one the disc is currently executing.

James



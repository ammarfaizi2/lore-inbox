Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbTEZUOu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 16:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262206AbTEZUOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 16:14:50 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:43531 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262193AbTEZUOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 16:14:49 -0400
Date: Mon, 26 May 2003 13:27:17 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCHES] add ata scsi driver
In-Reply-To: <1053976644.2298.194.camel@mulgrave>
Message-ID: <Pine.LNX.4.44.0305261317520.12186-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 26 May 2003, James Bottomley wrote:
>
> On Mon, 2003-05-26 at 15:07, Jens Axboe wrote:
> > Alright, so what do you need? Start out with X tags, shrink to Y (based
> > on repeated queue full conditions)? Anything else?
> 
> Actually, it's easier than that: just an API to alter the number of tags
> in the block layer (really only the size of your internal hash table). 
> The actual heuristics of when to alter the queue depth is the province
> of the individual drivers (although Doug Ledford was going to come up
> with a generic implementation).

Talking about tagged queueing - does the SCSI layer still remove the
request from the request list when it starts executing it?

At least historically that's a major mistake, and generates a crappy 
elevator, because it removes information from the block layer about where 
the disk is (or is going to be).

I know Andrew thinks that SCSI tagged queuing is a bunch of crap, and he 
has the latency numbers to prove it. He blames the SCSI disks themselves, 
but I think it might be the fact that SCSI makes it impossible to make a 
fair queuing algorithm for higher levels by hiding information.

Has anybody looked at just removing the request at command _completion_ 
time instead? That's what IDE does, and it's the _right_ thing to do.

I'd hate for SATA to pick up these kinds of mistakes from the SCSI layer.

			Linus


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262227AbTEZUhH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 16:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbTEZUhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 16:37:06 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:40205 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262227AbTEZUhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 16:37:06 -0400
Date: Mon, 26 May 2003 13:49:57 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jens Axboe <axboe@suse.de>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCHES] add ata scsi driver
In-Reply-To: <20030526203800.GP845@suse.de>
Message-ID: <Pine.LNX.4.44.0305261345460.13489-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 26 May 2003, Jens Axboe wrote:
> 
> I know this is a pet peeve of yours (must be, I remember you bringing it
> up at least 3 time before :), but I don't think that's necessarily true.
> It shouldn't matter _one_ bit whether you leave the request there or
> not, it's unmergeable.

It's not the merging that I worry about. It's latency and starvation.

Think of it this way: if you keep feeding a disk requests, and the disk 
always tries to do the closest one (which is a likely algorithm), you can 
easily have a situation where the disk _never_ actually schedules a 
request that is at one "end" of the platter. 

Think of all the fairness issues we've had in the elevator code, and 
realize that the low-level disk probably implements _none_ of those 
fairness algorithms.

> As long as the io scheduler keeps track of this (and it does!) we are
> golden.

Hmm.. Where does it keep track of request latency for requests that have 
been removed from the queue?

		Linus


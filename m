Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262252AbTEZVVh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 17:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262253AbTEZVVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 17:21:37 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:25617 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262252AbTEZVVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 17:21:35 -0400
Date: Mon, 26 May 2003 14:34:24 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jens Axboe <axboe@suse.de>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCHES] add ata scsi driver
In-Reply-To: <20030526205725.GT845@suse.de>
Message-ID: <Pine.LNX.4.44.0305261429550.13489-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 26 May 2003, Jens Axboe wrote:
> 
> > Think of all the fairness issues we've had in the elevator code, and 
> > realize that the low-level disk probably implements _none_ of those 
> > fairness algorithms.
> 
> I think it does, to some extent at least.

I doubt they do a very good job of it. I know of bad cases, even with 
"high-end" hardware. Sure, we can hope that it's getting better, but do we 
want to bet on it.

> > Hmm.. Where does it keep track of request latency for requests that have 
> > been removed from the queue?
> 
> Well, it doesn't...

Yeah. Which means that right now _really_ long starvation will show up as
timeouts, while other cases will just show up as bad latency.

Which will _work_, of course (assuming the timeout handling is correct,
which is a big if in itself), but it still sucks from a usability
standpoint.

Even if we drop our timeouts from 30 seconds (or whatever they are now)
down to just a few seconds, that's a _loooong_ time, and we should be a
lot more proactive about things. Audio/video stuff tends to want things
with latencies in the tenth-of-a-second range, even when they buffer
things up internally to hide the worst cases.

			Linus

